"""Use TileLang's compile_flags API to compare built-in compiler schedulers."""
import ast

from make_probes import BASE, HERE


def with_flags(source, flags):
    tree = ast.parse(source)
    lines = source.splitlines(keepends=True)
    offsets, total = [], 0
    for line in lines:
        offsets.append(total)
        total += len(line)
    edits = []
    for n in tree.body:
        if not isinstance(n, ast.FunctionDef):
            continue
        for d in n.decorator_list:
            call = d if isinstance(d, ast.Call) else None
            target = call.func if call else d
            if not (isinstance(target, ast.Attribute) and isinstance(target.value, ast.Name)
                    and target.value.id == 'tilelang' and target.attr == 'jit'):
                continue
            if call:
                assert not any(k.arg == 'compile_flags' for k in call.keywords)
                at = offsets[target.end_lineno - 1] + target.end_col_offset + 1
                edits.append((at, at, f'compile_flags={flags!r}, '))
            else:
                at = offsets[d.end_lineno - 1] + d.end_col_offset
                edits.append((at, at, f'(compile_flags={flags!r})'))
    for a, b, text in sorted(edits, reverse=True):
        source = source[:a] + text + source[b:]
    ast.parse(source)
    return source


if __name__ == '__main__':
    for name in ('maxocc', 'minreg', 'ilp', 'listall'):
        p = HERE / f'compiler_{name}.py'
        if p.exists():
            raise FileExistsError(p)
        p.write_text(with_flags(BASE, ['-mllvm', f'--misched=metaxgpu-{name}']))
        print(p.name)
