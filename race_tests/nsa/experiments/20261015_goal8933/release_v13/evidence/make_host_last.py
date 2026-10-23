"""Probe a last-configuration compiled-callable lookup within the existing cache."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
source=(HERE/'baseline.py').read_text()
fn=next(n for n in ast.parse(source).body if isinstance(n,ast.FunctionDef) and n.name=='run_kernel')
old=ast.get_source_segment(source,fn)
new=copy.deepcopy(fn)
assert isinstance(new.body[2],ast.Try) and isinstance(new.body[3],ast.If)
lookup=new.body[2:4]
hit=ast.parse('''
last = _KERNEL_CACHE.get('last_public_configuration')
if last is not None and key == last[0]:
    kernel = last[1]
else:
    pass
''').body
hit[1].orelse=lookup+ast.parse("_KERNEL_CACHE['last_public_configuration'] = (key, kernel)").body
new.body[2:4]=hit
result=source.replace(old,ast.unparse(ast.fix_missing_locations(new)),1)
compile(result,'host_last.py','exec')
with (HERE/'host_last.py').open('x') as f:f.write(result)
with (HERE/'host_last_manifest.json').open('x') as f:
    json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
        sha256=hashlib.sha256(result.encode()).hexdigest(),changed_function='run_kernel',
        stored_values='Normalized scalar configuration tuple and compiled callable only; entry removed with _KERNEL_CACHE.clear().'),f,indent=2)
    f.write('\n')
print('Generated host_last.py')
