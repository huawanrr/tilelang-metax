"""Check the reported scatter's injectivity without disabling race checking."""
import ast
import itertools
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]

def pack_ast(path):
    tree = ast.parse(path.read_text())
    node = next(n for n in tree.body if isinstance(n, ast.FunctionDef)
                and n.name == 'native_sparse_attention_pack_kv')
    return ast.dump(node, include_attributes=False)

assert pack_ast(ROOT/'nsa.py') == pack_ast(ROOT/'experiments/20260927_next/selected.py')
assert pack_ast(ROOT/'nsa.py') == pack_ast(Path(__file__).with_name('rejected_current.py'))
rows = []
for bs, dim in itertools.product((16, 32, 64), (32, 64, 128)):
    k_addresses = set()
    v_addresses = set()
    for j, d in itertools.product(range(bs), range(dim)):
        k = (d//32, j//16, (d%32//8)*16+j%16, d%8)
        v = (j//16, d//32, (j%16//4)*16+d%16, (d%32//16)*4+j%4)
        assert k not in k_addresses and v not in v_addresses
        k_addresses.add(k); v_addresses.add(v)
        # Independent inverse: every destination identifies exactly one input.
        assert (k[1]*16+k[2]%16, k[0]*32+(k[2]//16)*8+k[3]) == (j, d)
        assert (v[0]*16+(v[2]//16)*4+v[3]%4, v[1]*32+(v[3]//4)*16+v[2]%16) == (j, d)
    assert k_addresses == set(itertools.product(range(dim//32),range(bs//16),range(64),range(8)))
    assert v_addresses == set(itertools.product(range(bs//16),range(dim//32),range(64),range(8)))
    rows.append(dict(block_size=bs, dim=dim, addresses=bs*dim, status='PASS'))

Path(__file__).with_name('packing_addresses.json').write_text(json.dumps(dict(
    checks=rows, pack_kernel_unchanged=True,
    cta_ownership='Each CTA has a unique (batch, block, head) output prefix.',
    scope='Logical address bijection; runtime correctness is checked separately.',
    race_check_disabled=False), indent=2)+'\n')
print('PASS: nine packing layouts, exact inverse and coverage; pack kernel unchanged')
