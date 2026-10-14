"""Freeze the resumed work's inputs and prepare two bounded D32 experiments."""
import ast
import hashlib
import json
from pathlib import Path
import shutil


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PREVIOUS = ROOT / "experiments/20261002_next"
BASE = ROOT / "experiments/20261002_d32_v1/nsa.py"


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def once(source, old, new):
    assert source.count(old) == 1, old
    return source.replace(old, new)


def main():
    protected = [ROOT / name for name in ("nsa.py", "submission.py")]
    for directory in ("20261001_final", "20261002_final", "20261002_d32_v1"):
        protected.extend(ROOT / "experiments" / directory / name
                         for name in ("nsa.py", "submission.py"))
    manifest = dict(
        resumed_session="01a0fa57-ebed-7ac2-9cb2-41b5c41c88c3",
        user_confirmed_official_score=87.93,
        target_official_score=88.5,
        source_sha256={str(path.relative_to(ROOT)): digest(path) for path in protected},
    )
    target = HERE / "baseline_manifest.json"
    if target.exists():
        assert json.loads(target.read_text()) == manifest
    else:
        target.write_text(json.dumps(manifest, indent=2) + "\n")

    for name in ("compare_family.py", "bracketed_multiseed.py", "family_cases.json"):
        dest = HERE / name
        if not dest.exists():
            shutil.copyfile(PREVIOUS / name, dest)
    cases_path = HERE / "family_cases.json"
    cases = json.loads(cases_path.read_text())
    for t, b, h, causal in ((193, 1, 1, True), (255, 1, 1, True),
                           (257, 1, 1, True), (511, 1, 1, False),
                           (97, 2, 1, True), (96, 1, 4, True),
                           (127, 1, 2, True), (85, 1, 4, False),
                           (208, 1, 1, True), (224, 1, 1, True),
                           (272, 1, 1, True), (384, 1, 1, True),
                           (496, 1, 1, True), (112, 2, 1, True),
                           (80, 4, 1, True), (160, 2, 1, True),
                           (192, 1, 2, True), (128, 1, 2, True),
                           (64, 1, 4, True)):
        cases[f"finish_d32_b{b}_t{t}_h{h}_c{int(causal)}"] = dict(
            B=b, SEQ_LEN=t, H=h, HQ=h*16, D=32, S=1,
            block_size=16, is_causal=causal)
    cases_path.write_text(json.dumps(cases, indent=2) + "\n")

    source = BASE.read_text()
    reference = HERE / "reference_d32_v1.py"
    if reference.exists():
        assert reference.read_bytes() == BASE.with_name("submission.py").read_bytes()
    else:
        shutil.copyfile(BASE.with_name("submission.py"), reference)
    variants = {
        "compact_low": once(source,
            "    d32_compact = (d32_defaults\n        and 512 < grid < 1024)",
            "    d32_compact = (d32_defaults\n        and (192 < grid < 512 or 512 < grid < 1024))"),
        "wave_low": once(source,
            "                    if wave_single else native_sparse_attention_single_block_emitter_index_guard)",
            "                    if wave_single or 192 < grid < 512\n"
            "                    else native_sparse_attention_single_block_emitter_index_guard)"),
        "compact_aligned": once(source,
            "    d32_compact = (d32_defaults\n        and 512 < grid < 1024)",
            "    d32_compact = (d32_defaults\n"
            "        and ((192 < grid < 512 and seq_len >= 64\n"
            "              and seq_len % block_size == 0) or 512 < grid < 1024))"),
    }
    original = {n.name: ast.dump(n, include_attributes=False)
                for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for name, text in variants.items():
        functions = {n.name: ast.dump(n, include_attributes=False)
                     for n in ast.parse(text).body if isinstance(n, ast.FunctionDef)}
        assert functions.keys() == original.keys()
        assert all(functions[key] == value for key, value in original.items()
                   if key != "_get_kernel")
        path = HERE / f"{name}.py"
        if path.exists():
            assert path.read_text() == text
        else:
            path.write_text(text)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=digest(path)))
    (HERE / "low_grid_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE.relative_to(ROOT)), baseline_sha256=digest(BASE),
        variants=records, scope="Default S1/D32/BS16/G16, 192 < B*H*T < 512 only",
        hypothesis="Compare the protected single-wave schedules after index validation changed.",
    ), indent=2) + "\n")
    print("Protected", len(protected), "sources; prepared", len(variants), "bounded candidates")


if __name__ == "__main__":
    main()
