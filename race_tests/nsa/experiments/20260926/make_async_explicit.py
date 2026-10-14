"""Use TileLang's built-in MACA copy with linear physical destination per wave."""
from pathlib import Path
import ast
root=Path('experiments/20260926')
for name in ['async_k','async_kv_reuse','async_kv_split','async_online_k','async_online_kv']:
 s=(root/(name+'_aligned.py')).read_text()
 lines=[]
 for line in s.splitlines():
  if 'T.maca_async_copy(' not in line:
   lines.append(line)
   continue
  indent=line[:len(line)-len(line.lstrip())]
  is_k='T.maca_async_copy(K[' in line
  src='K' if is_k else 'V'
  shared=line.split('], ')[1].split(',')[0] if '], ' in line else line.split('],')[1].strip().split(',')[0]
  lines.extend(indent+x for x in [
   'for cp in T.serial(BS * BK // 512):',
   '    cr = cp * (512 // BK) + T.get_thread_binding() // (BK // 8)',
   '    cc = ((T.get_thread_binding() % (BK // 8)) ^ ((cr // max(1, 64 // BK)) % min(16 // max(1, 64 // BK), BK // 8))) * 8',
   '    T.call_intrin(T.float16, tilelang.tvm.ir.Op.get("tl.maca_memcpy_async"),',
   f'        T.access_ptr({shared}[cr, cc], "w", 8),',
   f'        T.access_ptr({src}[i_b, i_s + cr, i_h, cc], "r", 8),',
   '        16, bar[0], annotations={"barrier_type": tilelang.tvm.tir.StringImm("b128vectype")})',
  ])
 code='\n'.join(lines)+'\n'
 ast.parse(code)
 (root/(name+'_explicit.py')).write_text(code)
