#!/usr/bin/env bash
# Regenerate the reproducibility logs.  Run from any directory.
#
#   bash run_all.sh            # full validation (about 40 minutes on a quiet C500 slice)
#   bash run_all.sh quick      # fast acceptance: checks + graded shapes only
#
# Each step writes one log.  Timing steps want a quiet card: check the board's
# GPU-Util in `mx-smi` first -- another tenant at 90% turns 0.97 ms into 141 ms.
set -euo pipefail
export PYTHONDONTWRITEBYTECODE=1
HERE=$(cd "$(dirname "$0")" && pwd)
SRC=$(dirname "$HERE")
PKG=$(dirname "$SRC")
LOGS=$PKG/02_日志与结果
KERNEL=$SRC/kernel
COMPAT=$SRC/compat
mkdir -p "$LOGS"
# One cache directory for the whole package: TileLang's on-disk cache keys on the
# prim_func and the pass configs, so anything that changes below `T.gemm` is invisible
# to it.  Nothing here does, but keeping the package's compiles out of the default
# directory makes a cold-compile log reproducible.
export TILELANG_CACHE_DIR=${TILELANG_CACHE_DIR:-/tmp/tilelang-cache-submit-xh-202608}
# The reference environment uses a source checkout rather than an installed
# wheel.  Make the package runnable from a fresh shell while preserving any
# caller-provided TileLang path.
if [ -d /app/tilelang-metax ]; then
  export PYTHONPATH=/app/tilelang-metax${PYTHONPATH:+:$PYTHONPATH}
fi

echo "== 00 environment"
{
  date -Is
  uname -a
  echo "--- python / torch / tilelang ---"
  python - <<'PY'
import torch, tilelang, sys
print("python  ", sys.version.split()[0])
print("torch   ", torch.__version__)
print("tilelang", getattr(tilelang, "__version__", "(dev build)"), tilelang.__file__)
p = torch.cuda.get_device_properties(0)
print("device  ", p.name, "CU=%d" % p.multi_processor_count,
      "vram=%.2f GiB" % (p.total_memory / (1 << 30)))
PY
  echo "--- mx-smi ---"
  if command -v mx-smi >/dev/null 2>&1; then
    mx-smi 2>/dev/null | sed -n '1,30p'
  else
    echo "mx-smi: unavailable"
  fi
} > "$LOGS/00_env.log" 2>&1

echo "== 01 submission sandbox check"
python "$HERE/check_submission.py" "$KERNEL/submission.py" > "$LOGS/01_check_submission.log" 2>&1

echo "== 02 moe.py <-> submission.py device-code equivalence"
python "$HERE/check_equiv.py" "$KERNEL/moe.py" "$KERNEL/submission.py" \
  > "$LOGS/02_check_equiv.log" 2>&1

echo "== 04 performance, the three graded shapes"
python "$HERE/local_bench.py" --module "$KERNEL/submission.py" \
  --only oj1exact,oj2exact,oj3exact --iters 40 --no-torch-baseline \
  > "$LOGS/04_perf_test.log" 2>&1

if [ "${1:-full}" != "quick" ]; then
  echo "== 03 functional sweep, all 27 layouts (slow)"
  python "$HERE/local_bench.py" --module "$KERNEL/submission.py" --func-only \
    > "$LOGS/03_func_test.log" 2>&1

  echo "== 05 per-kernel profile (mcTracer)"
  if [ -x /opt/maca/bin/mcTracer ]; then
    {
      # mcTracer wants an executable path, not a shell string, and resolves --odname
      # relative to the current directory (an absolute path fails), so run it from $PKG.
      cd "$PKG"
      for case in oj1exact oj2exact oj3exact; do
        echo "### $case"
        TRACE_DIR="/tmp/moe_submit_trace_$case"
        mkdir -p "$TRACE_DIR"
        /opt/maca/bin/mcTracer --odname "$TRACE_DIR" --name t "$(which python)" \
          "$HERE/prof_target.py" --case "$case" --module "$KERNEL/submission.py" --iters 10 \
          2>&1 | tail -1
        python "$HERE/trace_summary.py" "$TRACE_DIR"/*.json
      done
    } > "$LOGS/05_kernel_profile.log" 2>&1
  else
    echo "mcTracer unavailable; profile skipped" > "$LOGS/05_kernel_profile.log"
  fi

  echo "== 06/07 starter-kit harness, our kernel"
  ( cd "$COMPAT" && python fusedmoe_benchmark.py ) > "$LOGS/06_official_functional.log" 2>&1 || true
  ( cd "$COMPAT" && python perf_slice.py )        > "$LOGS/07_official_perf.log" 2>&1 || true

  echo "== 08 starter-kit harness, the starter kit's own kernel (baseline)"
  {
    MOE_IMPL=template bash -c "cd '$COMPAT' && python fusedmoe_benchmark.py" 2>&1 | \
      grep -vE "^Loading|TileLang:"
    MOE_IMPL=template bash -c "cd '$COMPAT' && python perf_slice.py" 2>&1 | \
      grep -vE "^Loading|TileLang:"
  } > "$LOGS/08_official_baseline.log" 2>&1 || true
fi

echo "done; logs in $LOGS"
ls -la "$LOGS"
