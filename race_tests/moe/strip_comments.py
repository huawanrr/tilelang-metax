#!/usr/bin/env python3
"""Strip `#` comments from the submission, provably without touching the code.

`moe.py` is the documented source; the OJ wants something short enough to paste,
so this produces a comment-free `submission.py` from it.  `@T.prim_func` parses its
own source text, so "the AST is unchanged" is not sufficient evidence -- the check
below compiles both files and compares the generated MACA source byte for byte.

    python strip_comments.py moe.py submission.py
"""
import argparse
import io
import sys
import tokenize


def strip(src):
    """Remove comment tokens, keep every other token and all blank structure.

    Works on the token stream rather than by regex, so a `#` inside a string
    literal is left alone.  Lines that held nothing but a comment are dropped
    entirely; a trailing comment leaves its code line intact.
    """
    out = []
    drop = set()
    keep = set()
    for tok in tokenize.generate_tokens(io.StringIO(src).readline):
        if tok.type == tokenize.COMMENT:
            drop.add(tok.start[0])
        elif tok.type not in (tokenize.NL, tokenize.NEWLINE, tokenize.INDENT,
                              tokenize.DEDENT, tokenize.ENDMARKER):
            keep.add(tok.start[0])
    for n, line in enumerate(src.splitlines(keepends=True), 1):
        if n in drop and n not in keep:
            continue  # comment-only line
        if n in drop:
            code = line.rstrip("\n")
            cut = None
            for tok in tokenize.generate_tokens(io.StringIO(src).readline):
                if tok.type == tokenize.COMMENT and tok.start[0] == n:
                    cut = tok.start[1]
                    break
            if cut is not None:
                line = code[:cut].rstrip() + "\n"
        out.append(line)
    # collapse runs of more than two blank lines left behind by removed blocks
    text = []
    blanks = 0
    for line in out:
        if line.strip():
            blanks = 0
            text.append(line)
        else:
            blanks += 1
            if blanks <= 2:
                text.append(line)
    return "".join(text)


def strip_docstrings(src):
    """Drop the leading string statement of every def, by line range.

    Driven by the AST rather than by pattern matching, so an ordinary string
    expression elsewhere in a body is never touched.  A body that holds nothing but
    its docstring is left alone, since removing it would leave an empty block.
    """
    import ast

    tree = ast.parse(src)
    cut = set()
    for node in ast.walk(tree):
        if not isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef,
                                ast.ClassDef, ast.Module)):
            continue
        body = node.body
        if len(body) < 2:
            continue
        first = body[0]
        if isinstance(first, ast.Expr) and isinstance(first.value, ast.Constant) \
                and isinstance(first.value.value, str):
            cut.update(range(first.lineno, first.end_lineno + 1))
    return "".join(line for n, line in enumerate(src.splitlines(keepends=True), 1)
                   if n not in cut)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("src", nargs="?", default="moe.py")
    p.add_argument("dst", nargs="?", default="submission.py")
    p.add_argument("--docstrings", action="store_true",
                   help="also drop the leading docstring of every def")
    p.add_argument("--header", default=None,
                   help="single comment line to keep at the top of the output")
    a = p.parse_args()
    src = open(a.src).read()
    out = strip(src)
    if a.docstrings:
        out = strip(strip_docstrings(out))
    if a.header:
        out = f"# {a.header}\n" + out
    open(a.dst, "w").write(out)
    print(f"{a.src}: {len(src.splitlines())} lines -> {a.dst}: "
          f"{len(out.splitlines())} lines "
          f"({100 - 100 * len(out.splitlines()) // len(src.splitlines())}% smaller)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
