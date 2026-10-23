#!/usr/bin/env bash
# Time one variant per process, each with its own TileLang cache directory.
# The k_pack override is invisible to the cache key (it happens inside
# GemmMMA.lower, after the prim_func the cache hashes), so sharing a cache
# directory between a patched and an unpatched run silently serves the wrong
# kernel back -- the trap that produced two wrong conclusions earlier.
set -u
CASES=${CASES:-oj1exact,oj2exact,oj3exact}
ITERS=${ITERS:-30}
for name in "$@"; do
  echo "##### $name"
  TILELANG_CACHE_DIR=$HOME/.tilelang/cache_v42_$name \
    python local_bench.py --module /tmp/var_$name.py --only "$CASES" \
      --iters "$ITERS" --no-torch-baseline 2>&1 \
    | grep -E "^=== |correctness|time:|padding rows|FAIL|Error|Traceback"
done
