"""Check known submission restrictions and the NSA entry point without importing it."""
import ast
import importlib.util
from pathlib import Path
import sys

ROOT=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('common_submission_check',ROOT.parent/'moe/check_submission.py')
common=importlib.util.module_from_spec(spec)
spec.loader.exec_module(common)
EXPECTED=['q','k','v','block_indices','output','B','seq_len','H','HQ','D','S','block_size','is_causal','scale']
FORBIDDEN={'import_source','call_extern','async_copy','maca_async_copy','ptx_cp_async',
           'maca_memcpy_async','alloc_maca_barrier','maca_barrier_arrive_and_wait','tma_copy',
           'matmul','mm','bmm','einsum','softmax'}

def check(path):
    problems=[p for p in common.check(path) if not p.startswith('run_kernel signature is ')]
    tree=ast.parse(Path(path).read_text())
    fn=next((n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='run_kernel'),None)
    if fn is not None and [a.arg for a in fn.args.args]!=EXPECTED:
        problems.append('NSA run_kernel signature mismatch')
    for node in ast.walk(tree):
        if isinstance(node,ast.ClassDef):
            problems.append(f'line {node.lineno}: Class definitions are not allowed in user code')
        if isinstance(node,ast.Attribute) and isinstance(node.ctx,(ast.Store,ast.Del)):
            problems.append(f'line {node.lineno}: attribute writes/deletes are unsupported by the submission write guard: {ast.unparse(node)}')
        if isinstance(node,ast.Call):
            name=node.func.attr if isinstance(node.func,ast.Attribute) else (node.func.id if isinstance(node.func,ast.Name) else '')
            if name in FORBIDDEN:
                problems.append(f'line {node.lineno}: prohibited call {name}')
            if name in {'setattr','delattr'}:
                problems.append(f'line {node.lineno}: attribute mutation is unsupported by the submission write guard: {name}')
        if isinstance(node,ast.Constant) and isinstance(node.value,str):
            if any(token in node.value for token in ('tl.maca_memcpy_async','tl.maca_barrier_arrive_and_wait','tir.ptx_cp_async')):
                problems.append(f'line {node.lineno}: prohibited low-level async intrinsic')
    return problems

failed=False
for path in sys.argv[1:] or [str(ROOT/'nsa.py'),str(ROOT/'submission.py')]:
    issues=check(path)
    failed |= bool(issues)
    print(path, 'PASS' if not issues else '\n'.join(issues))
sys.exit(1 if failed else 0)
