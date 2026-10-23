#!/usr/bin/env python3
"""Render the two Markdown documents in this directory to PDF.

Uses PyMuPDF's built-in fonts only -- "china-s" (Droid Sans Fallback) for CJK and
Helvetica/Courier for Latin -- so no font file has to be shipped or installed:

    pip install pymupdf
    python make_pdf.py                      # both documents
    python make_pdf.py foo.md [--slides]    # one document

"china-s" is a full-width font: every glyph, Latin included, advances one em.  Latin
text set in it looks l i k e   t h i s, so every string is split into maximal CJK and
non-CJK runs and each run is drawn with its own font (`draw_runs`).

Supported Markdown subset: ATX headings, paragraphs, `-`/`*`/numbered bullets, fenced
code blocks, pipe tables, `---` rules (a slide break in slide mode), images
`![caption](path)` (paths relative to the .md file), and inline `**bold**` /
`` `code` `` / `[text](url)` markers (stripped).
"""
import os
import re
import sys

import pymupdf as fitz

HERE = os.path.dirname(os.path.abspath(__file__))
CJK = "china-s"
BODY = "helv"
BOLD = "hebo"
MONO = "cour"

DOC = dict(page=(595, 842), margin=52, lead=1.5, size=10.5, h=(19, 14.5, 12),
           code=8.6, table=9.0, gap=6.0, slides=False)
SLIDE = dict(page=(960, 540), margin=54, lead=1.55, size=15.5, h=(30, 24, 18),
             code=12, table=13.0, gap=9.0, slides=True)

INK = (0.10, 0.11, 0.13)
ACCENT = (0.11, 0.33, 0.60)
MUTED = (0.42, 0.45, 0.50)
RED = (0.70, 0.18, 0.18)
RULE = (0.78, 0.80, 0.83)
CODEBG = (0.965, 0.968, 0.973)
HEADBG = (0.93, 0.95, 0.97)

# Two measurement traps, both fixed here:
#   * `fitz.get_text_length` disagrees with what the renderer advances for non-ASCII
#     glyphs (a Helvetica-Bold "x" comes out ~10 pt narrow at 24 pt), so widths are
#     summed from `fitz.Font.glyph_advance`, which matches the drawn extent exactly.
#   * the base-14 Latin fonts are drawn with WinAnsiEncoding and cannot show anything
#     outside Latin-1 plus a short list of extras, so arrows, box drawing, Greek, math
#     symbols and CJK all come from the CID-encoded CJK font.  These five have no
#     glyph in *either* and are rewritten.
SUBS = (("\u1d40", "^T"), ("\u2705", "[OK]"), ("\u2212", "-"), ("\u21d2", "=>"),
        ("\u2194", "<->"), ("\u23f1", ""))
_FONTS = {}


def use_cjk(ch):
    """True when `ch` must be drawn with the CJK font to appear at all.

    Latin-1 (which WinAnsiEncoding covers) stays with Helvetica/Courier; dashes,
    quotes, arrows, Greek, math and CJK all come from the CJK font.
    """
    return ord(ch) > 0xFF


def sanitize(text):
    for a, b in SUBS:
        text = text.replace(a, b)
    return text


def inline(text):
    text = re.sub(r"\[([^\]]*)\]\([^)]*\)", r"\1", text)
    return sanitize(text.replace("**", "").replace("`", ""))


def runs(text):
    """Split into maximal (substring, is_cjk) runs."""
    out, cur, flag = [], "", None
    for ch in text:
        c = use_cjk(ch)
        if flag is None or c == flag:
            cur, flag = cur + ch, c
        else:
            out.append((cur, flag))
            cur, flag = ch, c
    if cur:
        out.append((cur, flag))
    return out


def _w(text, font, size):
    fnt = _FONTS.get(font)
    if fnt is None:
        fnt = _FONTS[font] = fitz.Font(font)
    return sum(fnt.glyph_advance(ord(c)) for c in text) * size


def width(text, size, latin=BODY):
    return sum(_w(t, CJK if c else latin, size) for t, c in runs(text))


def draw_runs(page, x, y, text, size, color=INK, latin=BODY):
    for t, c in runs(text):
        font = CJK if c else latin
        page.insert_text((x, y), t, fontname=font, fontsize=size, color=color)
        x += _w(t, font, size)
    return x


# Code blocks are drawn on a fixed grid instead of with proportional metrics: the
# ASCII diagrams in the documents were authored in a terminal, where a CJK glyph is
# two columns wide and a box-drawing glyph is one.  Courier's advance (0.6 em) is the
# column; each character is placed on that grid with whichever font can show it.
COL = 0.6
WIDE = ((0x1100, 0x115F), (0x2E80, 0xA4CF), (0xAC00, 0xD7A3), (0xF900, 0xFAFF),
        (0xFE30, 0xFE6F), (0xFF00, 0xFF60), (0xFFE0, 0xFFE6))


def cols(ch):
    o = ord(ch)
    return 2 if any(lo <= o <= hi for lo, hi in WIDE) else 1


def code_width(text, size):
    return sum(cols(c) for c in text) * COL * size


def draw_code(page, x, y, text, size):
    for ch in text:
        if not ch.isspace():
            page.insert_text((x, y), ch, fontname=MONO if ord(ch) < 0x80 else CJK,
                             fontsize=size, color=(0.13, 0.16, 0.22))
        x += cols(ch) * COL * size
    return x


def code_wrap(text, size, avail):
    per = max(1, int(avail / (COL * size)))
    out, line, used = [], "", 0
    for ch in text:
        w = cols(ch)
        if used + w > per and line:
            out.append(line)
            line, used = "", 0
        line += ch
        used += w
    return out + ([line] if line.strip() or not out else [])


def wrap(text, size, avail, latin=BODY):
    """Greedy wrap: break at spaces inside Latin, anywhere inside CJK."""
    out, line = [], ""
    for ch in text:
        if width(line + ch, size, latin) > avail and line:
            cut = len(line)
            if not use_cjk(ch) and ch != " ":
                sp = line.rfind(" ")
                if sp > 0 and width(line[sp + 1:], size, latin) < avail * 0.6:
                    cut = sp
            out.append(line[:cut].rstrip())
            line = line[cut:].lstrip() + ch
        else:
            line += ch
    if line.strip():
        out.append(line.rstrip())
    return out or [""]


def blocks(md):
    """Split Markdown into (kind, payload) blocks."""
    out, buf, code, fence = [], [], [], None
    for raw in md.split("\n"):
        line = raw.rstrip()
        if fence is not None:
            if line.startswith("```"):
                out.append(("code", code))
                code, fence = [], None
            else:
                code.append(raw)
            continue
        if line.startswith("```"):
            if buf:
                out.append(("para", " ".join(buf)))
                buf = []
            fence, code = line, []
            continue
        m = re.match(r"^!\[([^\]]*)\]\(([^)]+)\)\s*$", line.strip())
        if m:
            if buf:
                out.append(("para", " ".join(buf)))
                buf = []
            out.append(("img", (m.group(2), m.group(1))))
            continue
        if not line.strip():
            if buf:
                out.append(("para", " ".join(buf)))
                buf = []
            continue
        if line.strip() == "---":
            if buf:
                out.append(("para", " ".join(buf)))
                buf = []
            out.append(("rule", None))
            continue
        m = re.match(r"^(#{1,4})\s+(.*)$", line)
        if m:
            if buf:
                out.append(("para", " ".join(buf)))
                buf = []
            out.append(("h%d" % len(m.group(1)), m.group(2)))
            continue
        if line.lstrip().startswith(("- ", "* ", "> ")) or re.match(r"^\s*\d+\.\s", line):
            if buf:
                out.append(("para", " ".join(buf)))
                buf = []
            indent = (len(line) - len(line.lstrip())) // 2
            out.append(("li", (indent, re.sub(r"^\s*(?:[-*>]|\d+\.)\s+", "", line))))
            continue
        if line.strip().startswith("|"):
            cells = [c.strip() for c in line.strip().strip("|").split("|")]
            if all(re.fullmatch(r":?-{2,}:?", c) for c in cells if c):
                out.append(("trule", None))
            else:
                out.append(("tr", cells))
            continue
        buf.append(line.strip())
    if buf:
        out.append(("para", " ".join(buf)))
    return out


class Renderer:
    def __init__(self, theme, title, base=None):
        self.t = theme
        self.title = title
        self.base = base or os.getcwd()
        self.doc = fitz.open()
        self.page = None
        self.y = 0.0
        self.new_page()

    def new_page(self):
        self.page = self.doc.new_page(width=self.t["page"][0], height=self.t["page"][1])
        self.y = self.t["margin"]
        if not self.t["slides"] and self.doc.page_count > 1:
            draw_runs(self.page, self.t["margin"], self.t["margin"] - 16, self.title,
                      8, MUTED)
        return self.page

    @property
    def avail(self):
        return self.t["page"][0] - 2 * self.t["margin"]

    def fresh(self):
        return self.y <= self.t["margin"] + 1

    def room(self, need):
        if self.y + need > self.t["page"][1] - self.t["margin"] - 10:
            self.new_page()

    def line(self, text, size, color=INK, indent=0.0, lead=None, latin=BODY):
        lead = lead or self.t["lead"]
        for piece in wrap(text, size, self.avail - indent, latin):
            self.room(size * lead)
            draw_runs(self.page, self.t["margin"] + indent, self.y + size, piece,
                      size, color, latin)
            self.y += size * lead

    def heading(self, level, text):
        size = self.t["h"][min(level, 3) - 1]
        self.y += self.t["gap"] * (1.7 if level == 1 else 1.15)
        self.room(size * 2.2)
        self.line(inline(text), size, color=ACCENT if level <= 2 else INK,
                  lead=1.3, latin=BOLD)
        if level <= 2:
            self.page.draw_line((self.t["margin"], self.y + 1),
                                (self.t["page"][0] - self.t["margin"], self.y + 1),
                                color=RULE, width=0.6)
            self.y += 7
        self.y += self.t["gap"] * 0.35

    def para(self, text):
        self.line(inline(text), self.t["size"])
        self.y += self.t["gap"] * 0.5

    def bullet(self, indent, text):
        size = self.t["size"]
        pad = 11 + indent * 15
        first = True
        for piece in wrap(inline(text), size, self.avail - pad - 4):
            self.room(size * self.t["lead"])
            if first:
                draw_runs(self.page, self.t["margin"] + indent * 15, self.y + size,
                          "•", size, ACCENT)
            draw_runs(self.page, self.t["margin"] + pad, self.y + size, piece, size)
            self.y += size * self.t["lead"]
            first = False
        self.y += self.t["gap"] * 0.2

    def code(self, lines):
        size = self.t["code"]
        lines = [sanitize(l.replace("\t", "    ")) for l in lines]
        widest = max([code_width(l, size) for l in lines] or [0])
        if widest > self.avail - 18:                  # keep ASCII diagrams on one line
            size = max(5.2, size * (self.avail - 18) / widest)
        rows = []
        for raw in lines:
            rows.extend(code_wrap(raw, size, self.avail - 18))
        self.room(min(len(rows) * size * 1.34 + 12,
                      self.t["page"][1] - 2 * self.t["margin"]))
        top = self.y
        for row in rows:
            if self.y + size * 1.34 > self.t["page"][1] - self.t["margin"] - 10:
                self.page.draw_rect(fitz.Rect(self.t["margin"], top,
                                              self.t["page"][0] - self.t["margin"],
                                              self.y + 5),
                                    color=None, fill=CODEBG, overlay=False)
                self.new_page()
                top = self.y
            draw_code(self.page, self.t["margin"] + 9, self.y + size + 4, row, size)
            self.y += size * 1.34
        self.page.draw_rect(fitz.Rect(self.t["margin"], top,
                                      self.t["page"][0] - self.t["margin"], self.y + 5),
                            color=None, fill=CODEBG, overlay=False)
        self.y += 5 + self.t["gap"] * 0.6

    def img(self, src, caption):
        path = src if os.path.isabs(src) else os.path.join(self.base, src)
        if not os.path.exists(path):
            self.line("[missing image: %s]" % src, 9, RED)
            return
        pix = fitz.Pixmap(path)
        avail = self.avail
        w, h = float(avail), avail * pix.height / pix.width
        maxh = (self.t["page"][1] - 2 * self.t["margin"]) * (0.60 if self.t["slides"] else 0.88)
        if h > maxh:
            w, h = maxh * pix.width / pix.height, maxh
        self.room(h + 14)
        xoff = (avail - w) / 2
        self.page.insert_image(fitz.Rect(self.t["margin"] + xoff, self.y,
                                         self.t["margin"] + xoff + w, self.y + h),
                               pixmap=pix)
        self.y += h + 5
        if caption:
            cap = inline(caption)
            self.room(12)
            draw_runs(self.page, self.t["margin"] + (avail - width(cap, 8.5)) / 2,
                      self.y + 9, cap, 8.5, MUTED)
            self.y += 15
        self.y += self.t["gap"] * 0.4

    def table(self, rows):
        size = self.t["table"]
        ncol = max(len(r) for r in rows)
        cells = [[inline(c) for c in r] + [""] * (ncol - len(r)) for r in rows]
        raw = [max(width(r[c], size) for r in cells) + 13 for c in range(ncol)]
        scale = min(1.0, (self.avail - 4) / sum(raw))
        w = [x * scale for x in raw]
        for i, row in enumerate(cells):
            parts = [wrap(row[c], size, w[c] - 11) for c in range(ncol)]
            high = max(len(p) for p in parts) * size * 1.32 + 6
            self.room(high + 4)
            if i == 0:
                self.page.draw_rect(fitz.Rect(self.t["margin"], self.y,
                                              self.t["margin"] + sum(w), self.y + high),
                                    color=None, fill=HEADBG, overlay=False)
            x = self.t["margin"]
            for c in range(ncol):
                for k, piece in enumerate(parts[c]):
                    draw_runs(self.page, x + 6, self.y + size + 2 + k * size * 1.32,
                              piece, size, INK if i else (0.06, 0.20, 0.40),
                              BODY if i else BOLD)
                x += w[c]
            self.y += high
            self.page.draw_line((self.t["margin"], self.y),
                                (self.t["margin"] + sum(w), self.y), color=RULE, width=0.5)
        self.y += self.t["gap"] * 0.9

    def rule(self):
        if self.t["slides"]:
            if not self.fresh():
                self.new_page()
            return
        self.y += self.t["gap"] * 0.8
        self.page.draw_line((self.t["margin"], self.y),
                            (self.t["page"][0] - self.t["margin"], self.y),
                            color=RULE, width=0.8)
        self.y += self.t["gap"] * 1.1

    def numbers(self):
        total = self.doc.page_count
        for i, page in enumerate(self.doc):
            if self.t["slides"]:
                draw_runs(page, self.t["page"][0] - self.t["margin"] - 42,
                          self.t["page"][1] - 24, "%d / %d" % (i + 1, total), 11, MUTED)
            else:
                draw_runs(page, self.t["page"][0] / 2 - 8, self.t["page"][1] - 30,
                          "%d" % (i + 1), 9, MUTED)


def render(md_path, pdf_path, slides):
    with open(md_path, encoding="utf-8") as fh:
        items = blocks(fh.read())
    title = next((p for k, p in items if k == "h1"), os.path.basename(md_path))
    r = Renderer(SLIDE if slides else DOC, inline(title), os.path.dirname(md_path))
    pending = []

    def flush():
        if pending:
            r.table(list(pending))
            pending.clear()

    for kind, payload in items:
        if kind not in ("tr", "trule"):
            flush()
        if kind == "h1":
            if slides:
                r.y = r.t["page"][1] * 0.30
                r.line(inline(payload), 32, color=ACCENT, lead=1.4, latin=BOLD)
                r.y += 12
            else:
                r.heading(1, payload)
        elif kind in ("h2", "h3", "h4"):
            if slides and kind == "h2":
                if not r.fresh():
                    r.new_page()
                r.line(inline(payload), r.t["h"][1], color=ACCENT, lead=1.3, latin=BOLD)
                r.page.draw_line((r.t["margin"], r.y + 2),
                                 (r.t["page"][0] - r.t["margin"], r.y + 2),
                                 color=ACCENT, width=1.2)
                r.y += 18
            else:
                r.heading(int(kind[1]), payload)
        elif kind == "para":
            r.para(payload)
        elif kind == "li":
            r.bullet(*payload)
        elif kind == "code":
            r.code(payload)
        elif kind == "img":
            r.img(*payload)
        elif kind == "tr":
            pending.append(payload)
        elif kind == "rule":
            r.rule()
    flush()
    r.numbers()
    r.doc.save(pdf_path, deflate=True)
    return r.doc.page_count


def main():
    jobs = [("技术方案.md", "技术方案.pdf", False),
            ("技术方案PPT.md", "技术方案PPT.pdf", True)]
    if len(sys.argv) > 1 and not sys.argv[1].startswith("-"):
        jobs = [(sys.argv[1], os.path.splitext(sys.argv[1])[0] + ".pdf",
                 "--slides" in sys.argv)]
    for src, dst, slides in jobs:
        src_path = src if os.path.isabs(src) else os.path.join(HERE, src)
        dst_path = dst if os.path.isabs(dst) else os.path.join(HERE, dst)
        pages = render(src_path, dst_path, slides)
        print("%-22s -> %-22s %2d pages, %.1f KiB"
              % (os.path.basename(src_path), os.path.basename(dst_path), pages,
                 os.path.getsize(dst_path) / 1024))


if __name__ == "__main__":
    main()
