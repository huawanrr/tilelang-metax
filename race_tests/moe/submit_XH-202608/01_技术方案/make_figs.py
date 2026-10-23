#!/usr/bin/env python3
"""Draw the figures embedded in 技术方案.md / 技术方案PPT.md / README.md.

Every figure is composed with the same vector primitives and the same font
pipeline as make_pdf.py (PyMuPDF built-ins: "china-s" for CJK, Helvetica/Courier
for Latin), then rasterized to PNG at ~2.4x so the PDFs embed crisp bitmaps:

    python make_figs.py            # (re)generate 01_技术方案/figs/*.png

No third-party plotting library and no system font is required.
"""
import math
import os

import pymupdf as fitz

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, "figs")

CJK, BODY, BOLD, MONO = "china-s", "helv", "hebo", "cour"
INK = (0.10, 0.11, 0.13)
ACCENT = (0.11, 0.33, 0.60)
MUTED = (0.40, 0.44, 0.50)
RULE = (0.72, 0.75, 0.80)
RED = (0.72, 0.19, 0.19)
GREEN = (0.14, 0.46, 0.27)
AMBER = (0.78, 0.52, 0.10)
FILL_BLUE = (0.905, 0.935, 0.975)
FILL_GRAY = (0.945, 0.950, 0.958)
FILL_RED = (0.975, 0.905, 0.905)
FILL_GREEN = (0.895, 0.945, 0.905)
FILL_AMBER = (0.995, 0.950, 0.865)
_FONTS = {}

SUBS = (("\u2212", "-"), ("\u21d2", "=>"), ("\u2705", "[OK]"), ("\u1d40", "^T"))


def font(name):
    f = _FONTS.get(name)
    if f is None:
        f = _FONTS[name] = fitz.Font(name)
    return f


def sanitize(s):
    for a, b in SUBS:
        s = s.replace(a, b)
    return s


def runs(s):
    out, cur, flag = [], "", None
    for ch in sanitize(s):
        c = ord(ch) > 0xFF
        if flag is None or c == flag:
            cur, flag = cur + ch, c
        else:
            out.append((cur, flag))
            cur, flag = ch, c
    if cur:
        out.append((cur, flag))
    return out


def tw(s, size, bold=False):
    latin = BOLD if bold else BODY
    return sum(font(CJK if c else latin).glyph_advance(ord(ch)) for t, c in runs(s)
               for ch in t) * size


def text(page, x, y, s, size=11, color=INK, bold=False, center=False,
         right=False, mono=False):
    latin = MONO if mono else (BOLD if bold else BODY)
    if center:
        x -= tw(s, size, bold) / 2
    if right:
        x -= tw(s, size, bold)
    for t, c in runs(s):
        f = CJK if c else latin
        page.insert_text((x, y), t, fontname=f, fontsize=size, color=color)
        x += sum(font(f).glyph_advance(ord(ch)) for ch in t) * size
    return x


def wrap(s, size, maxw, bold=False):
    out, line = [], ""
    for ch in sanitize(s):
        if tw(line + ch, size, bold) > maxw and line:
            out.append(line)
            line = ""
        line += ch
    if line.strip():
        out.append(line)
    return out or [""]


def box(page, r, fill=None, line=RULE, width=1.0, dash=None, radius=0.045):
    if fill:
        page.draw_rect(r, color=None, fill=fill, radius=radius)
    if line:
        page.draw_rect(r, color=line, width=width, radius=radius, dashes=dash)


def arrow(page, p1, p2, color=INK, w=1.6, head=7.5):
    page.draw_line(p1, p2, color=color, width=w)
    ang = math.atan2(p2[1] - p1[1], p2[0] - p1[0])
    pts = [p2,
           (p2[0] - head * math.cos(ang - 0.42), p2[1] - head * math.sin(ang - 0.42)),
           (p2[0] - head * math.cos(ang + 0.42), p2[1] - head * math.sin(ang + 0.42))]
    page.draw_polyline(pts, color=color, fill=color, width=0.4, closePath=True)


def canvas(w, h):
    doc = fitz.open()
    page = doc.new_page(width=w, height=h)
    page.draw_rect(fitz.Rect(0, 0, w, h), color=None, fill=(1, 1, 1))
    return doc, page


def save(doc, page, name, zoom=2.4):
    os.makedirs(OUT, exist_ok=True)
    path = os.path.join(OUT, name)
    page.get_pixmap(matrix=fitz.Matrix(zoom, zoom), alpha=False).save(path)
    print("%-24s %5.1f KiB" % (name, os.path.getsize(path) / 1024))
    doc.close()


def title(page, s, w, sub=None):
    text(page, w / 2, 27, s, 14.5, ACCENT, bold=True, center=True)
    if sub:
        text(page, w / 2, 45, sub, 10, MUTED, center=True)


# ---------------------------------------------------------------- fig 1: dataflow
def fig_dataflow():
    W, H = 1020, 468
    doc, page = canvas(W, H)

    def inp(x, y, w, head, sub, fill=FILL_BLUE):
        box(page, fitz.Rect(x, y, x + w, y + 46), fill=fill)
        text(page, x + w / 2, y + 19, head, 11, INK, bold=True, center=True)
        text(page, x + w / 2, y + 36, sub, 9, MUTED, center=True)

    inp(30, 88, 148, "stacked_expert_tokens", "fp16, 128 行对齐 padding")
    inp(30, 152, 148, "gate_w / up_w", "(E, I, H) fp16")
    inp(30, 216, 148, "down_w", "(E, H, I) fp16")
    inp(30, 280, 148, "routed_expert_weights", "(V,) fp32")
    inp(30, 348, 148, "group_* 元数据", "sizes / offsets / bx 映射", FILL_GRAY)

    text(page, 225, 78, "stage 1  (按 intermediate 切 N)", 11.5, ACCENT, bold=True)
    box(page, fitz.Rect(222, 88, 470, 132), fill=FILL_BLUE)
    text(page, 234, 108, "main scope   M=128 tile", 10.5, INK, bold=True)
    text(page, 234, 124, "有效行 > 64 的 block", 9, MUTED)
    box(page, fitz.Rect(222, 144, 470, 188), fill=FILL_BLUE, dash="[2 2]")
    text(page, 234, 164, "tail scope   M=64 tile (可选)", 10.5, INK, bold=True)
    text(page, 234, 180, "0 < 有效行 ≤ 64,仅 blocks ≥ 64 时生成", 9, MUTED)
    text(page, 346, 212, "SwiGLU: up · gate · sigmoid(gate)  (寄存器内, fp32 累加)",
         9.5, INK, center=True)
    arrow(page, (350, 188), (350, 226), ACCENT)

    box(page, fitz.Rect(262, 228, 430, 266), fill=FILL_AMBER, line=AMBER, width=1.4)
    text(page, 346, 245, "up_logits (workspace, fp16)", 10.5, INK, bold=True, center=True)
    text(page, 346, 261, "只写有效行,padding 行内容未定义", 8.5, MUTED, center=True)

    text(page, 610, 78, "stage 2  (按 hidden 切 N, 每 block 配对 2 个 n-tile)", 11.5,
         ACCENT, bold=True)
    box(page, fitz.Rect(560, 88, 830, 132), fill=FILL_BLUE)
    text(page, 572, 108, "main scope   M=128 × 2 n-tile", 10.5, INK, bold=True)
    text(page, 572, 124, "有效行 > 64 的 block,down GEMM × 2", 9, MUTED)
    box(page, fitz.Rect(560, 144, 830, 188), fill=FILL_BLUE, dash="[2 2]")
    text(page, 572, 164, "tail scope   M=64 × 2 n-tile (可选)", 10.5, INK, bold=True)
    text(page, 572, 180, "0 < 有效行 ≤ 64", 9, MUTED)
    box(page, fitz.Rect(880, 148, 1000, 194), fill=FILL_GREEN, line=GREEN, width=1.4)
    text(page, 940, 168, "out", 12, INK, bold=True, center=True)
    text(page, 940, 184, "只写有效行", 9, MUTED, center=True)

    arrow(page, (178, 111), (222, 111), ACCENT)
    arrow(page, (178, 172), (222, 122), ACCENT)
    arrow(page, (178, 178), (222, 172), ACCENT)
    page.draw_line((178, 250), (205, 276), color=ACCENT, width=1.6)
    page.draw_line((205, 276), (528, 276), color=ACCENT, width=1.6)
    page.draw_line((528, 276), (528, 182), color=ACCENT, width=1.6)
    arrow(page, (528, 182), (556, 182), ACCENT)
    arrow(page, (430, 240), (556, 112), ACCENT)
    arrow(page, (430, 254), (556, 172), ACCENT)
    arrow(page, (830, 111), (880, 158), GREEN)
    arrow(page, (830, 166), (880, 170), GREEN)
    page.draw_line((178, 303), (500, 303), color=ACCENT, width=1.6)
    page.draw_line((500, 303), (500, 128), color=ACCENT, width=1.6)
    arrow(page, (500, 128), (556, 122), ACCENT)
    arrow(page, (178, 371), (940, 371), MUTED, w=1.0, head=6)
    arrow(page, (940, 371), (940, 198), MUTED, w=1.0, head=6)
    text(page, 559, 364, "每个 scope 运行时读 group_sizes / group_padded_offsets 自算有效行数",
         8.5, MUTED, center=True)

    box(page, fitz.Rect(222, 290, 470, 336), fill=FILL_GRAY)
    text(page, 234, 308, "1 个 @tilelang.jit T.prim_func", 10, INK, bold=True)
    text(page, 240, 325, "Config1/2: 2 次 launch;Config3: 4 次(tail 开)", 9, MUTED)

    text(page, 510, 300, "host 侧:run_kernel → 选 tile 配置 → 查 JIT 缓存 → 连续 launch", 9.5, INK)
    text(page, 510, 318, "无任何 H2D/D2H 同步;中间结果只落一次显存", 9.5, MUTED)
    text(page, 510, 336, "SwiGLU 与路由乘法全部在寄存器/累加器内完成", 9.5, MUTED)

    box(page, fitz.Rect(30, 396, W - 30, 442), fill=FILL_GRAY, line=None)
    text(page, 44, 414, "padding 行契约:", 10, INK, bold=True)
    text(page, 136, 414, "可以读(值不进结果),绝不写 —— 评测的 allclose 覆盖整个 out 张量,", 10, INK)
    text(page, 44, 431, "每一处写回都带 i < actual_rows 谓词;tail/main 两对 scope 的行区间互补不重叠。",
         10, INK)
    save(doc, page, "fig_dataflow.png")


# ------------------------------------------------------- fig 2: tile design space
def fig_tile_space():
    W, H = 1020, 448
    doc, page = canvas(W, H)
    title(page, "tile 形状不是扫参扫出来的:两条硬约束圈出唯一最优点",
          W, "横轴 bm,纵轴 bn;蓝线是 LDS 可行边界,虚线是等 flop 双曲线,可行域在蓝线下方")

    x0, y0, pw, ph = 74, 96, 360, 288
    sx = pw / 270.0
    sy = ph / 270.0

    def px(v):
        return x0 + v * sx

    def py(v):
        return y0 + ph - v * sy

    for g in (64, 128, 192, 256):
        page.draw_line((px(g), y0), (px(g), y0 + ph), color=(0.93, 0.94, 0.96), width=0.7)
        page.draw_line((x0, py(g)), (x0 + pw, py(g)), color=(0.93, 0.94, 0.96), width=0.7)
        text(page, px(g), y0 + ph + 14, str(g), 8.5, MUTED, center=True)
        text(page, x0 - 8, py(g) + 3, str(g), 8.5, MUTED, right=True)
    text(page, x0 + pw / 2, y0 + ph + 30, "bm", 10, INK, center=True)
    page.draw_line((x0 - 16, py(0) + 16), (x0 - 16, y0 - 6), color=MUTED, width=0.8)
    text(page, x0 - 22, y0 - 12, "bn", 10, INK, right=True)

    page.draw_polyline([(px(bm), py(min(256, 268 - bm))) for bm in (12, 268)],
                       color=ACCENT, width=2.0)
    pts = [(bm, 16384.0 / bm) for bm in range(64, 257, 4) if 16384.0 / bm <= 268]
    page.draw_polyline([(px(b), py(min(268, n))) for b, n in pts], color=AMBER,
                       width=1.8, dashes="[4 3]")

    r = fitz.Rect(x0, y0, x0 + pw, py(256) + (y0 + ph - py(268)))
    page.draw_rect(fitz.Rect(x0, y0, x0 + pw, py(256)), color=None, fill=FILL_RED)
    text(page, x0 + pw - 10, y0 + 18, "LDS > 32 KiB:每 CU 1 个 block", 9.5, RED,
         right=True)
    text(page, x0 + pw - 10, y0 + 33, "(40 KiB 实测 +65%)", 9, RED, right=True)

    text(page, px(96), py(238), "虚线:bm·bn = 16384(等 flop 面)", 9.5, AMBER, bold=True)
    page.draw_circle(fitz.Point(px(128), py(128)), 6, color=GREEN, width=2.2)
    page.draw_circle(fitz.Point(px(128), py(128)), 1.6, color=GREEN, fill=GREEN)
    text(page, px(140), py(128) - 26, "128 × 128:唯一交点", 10, GREEN, bold=True)
    text(page, px(140), py(128) - 12, "三个指标同时最优", 9, GREEN)

    for k, s in enumerate(["x  256×128:+22%(LDS 48 KiB)",
                           "x  128×64:算术强度上限 91 TF/s",
                           "x  192×64:合并两 block,+1.7~26%"]):
        text(page, px(30), py(26 + k * 17), s, 9.3, RED)

    bx = 470
    box(page, fitz.Rect(bx, 92, W - 34, 200), fill=FILL_BLUE, line=None)
    text(page, bx + 14, 112, "约束 1|LDS ≤ 32 KiB / block", 11, INK, bold=True)
    text(page, bx + 14, 131, "(bm+bn)·bk·2 ≤ 32768,bk=64 ⇒ bm+bn ≤ 256", 10.5, INK, mono=True)
    text(page, bx + 14, 150, "40 KiB 时每 CU 从 2 block 掉到 1,实测 +65%;", 9.5, MUTED)
    text(page, bx + 14, 166, "CU 的 64 KiB LDS 是直接量出来的(占用率探针)", 9.5, MUTED)

    box(page, fitz.Rect(bx, 210, W - 34, 318), fill=FILL_BLUE, line=None)
    text(page, bx + 14, 230, "约束 2|累加器寄存器 ≤ 256 / 线程", 11, INK, bold=True)
    text(page, bx + 14, 249, "gate+up 两个 fp32 累加器 = 2·bm·bn/threads 个", 10.5, INK, mono=True)
    text(page, bx + 14, 268, "128×128 / 256 线程 = 128 个,加 fragment/地址", 9.5, MUTED)
    text(page, bx + 14, 284, "后主 scope 实测 250 —— 已贴近上限", 9.5, MUTED)

    text(page, bx + 14, 344, "在 bm+bn ≤ 256 内,bm·bn ≤ 16384,当且仅当 bm=bn=128;", 10.5, INK)
    text(page, bx + 14, 362, "LDS 读/flop = p/bm + q/bn 的下界与线程数无关", 10.5, INK)
    text(page, bx + 14, 380, "(512 线程实测 12.08 ms 对 256 线程 9.01 ms)。", 10.5, INK)
    text(page, bx + 14, 402, "⇒ 128×128×64 / 256 线程 / Square / 单权重缓冲", 11, GREEN, bold=True)
    text(page, bx + 14, 419, "是设计空间里的精确最优点,不是搜索结果。", 10.5, INK)
    save(doc, page, "fig_tile_space.png")


# ------------------------------------------------------------- fig 3: LDS cliff
def fig_lds_cliff():
    W, H = 950, 420
    doc, page = canvas(W, H)
    title(page, "占用率探针:每 CU 只有 64 KiB LDS,32 KiB 是 2-block 驻留的红线",
          W, "stage 1 加一块纯占位 shared buffer,oj2exact 实测(工程笔记 §23.3)")

    data = [("32 KiB", 3.683, GREEN), ("40 KiB", 6.092, RED), ("48 KiB", 6.083, RED),
            ("56 KiB", 6.127, RED), ("64 KiB", 6.119, RED)]
    x0, y0, pw, ph = 90, 92, 560, 250
    ymax = 7.0
    page.draw_line((x0, y0 + ph), (x0 + pw, y0 + ph), color=INK, width=1.2)
    page.draw_line((x0, y0), (x0, y0 + ph), color=INK, width=1.2)
    for gv in (2, 4, 6):
        yy = y0 + ph - gv / ymax * ph
        page.draw_line((x0, yy), (x0 + pw, yy), color=(0.93, 0.94, 0.96), width=0.7)
        text(page, x0 - 8, yy + 3, "%d" % gv, 8.5, MUTED, right=True)
    text(page, x0 - 30, y0 + ph / 2, "ms", 10, INK)
    bw = 62
    for i, (lab, v, c) in enumerate(data):
        bx = x0 + 46 + i * 106
        bh = v / ymax * ph
        page.draw_rect(fitz.Rect(bx, y0 + ph - bh, bx + bw, y0 + ph),
                       color=None, fill=(0.90, 0.93, 0.97) if c is GREEN else FILL_RED)
        page.draw_rect(fitz.Rect(bx, y0 + ph - bh, bx + bw, y0 + ph), color=c, width=1.4)
        text(page, bx + bw / 2, y0 + ph - bh - 8, "%.3f" % v, 10, c, bold=True, center=True)
        text(page, bx + bw / 2, y0 + ph + 16, lab, 10, INK, center=True)
    text(page, x0 + 46 + bw / 2, y0 + ph + 34, "2 block/CU", 9.5, GREEN, bold=True, center=True)
    text(page, x0 + 46 + 106 * 3 + bw / 2, y0 + ph + 34, "1 block/CU(-65%)", 9.5, RED,
         bold=True, center=True)
    xd = x0 + 46 + 106 - 23
    page.draw_line((xd, y0 - 12), (xd, y0 + ph + 2), color=RED, width=1.2, dashes="[4 3]")

    box(page, fitz.Rect(700, 108, W - 30, 236), fill=FILL_BLUE, line=None)
    for i, s in enumerate(["双权重缓冲 = 48 KiB",
                           "=> 落进 1-block 区,+39%",
                           "",
                           "单缓冲 + 寄存器暂存",
                           "= 32 KiB,恰好贴线",
                           "保住 2 block/CU"]):
        if s:
            text(page, 714, 130 + i * 17, s, 10.5,
                 RED if i == 1 else (GREEN if i == 4 else INK),
                 bold=i in (0, 3, 4))
    text(page, 60, 402, "这也是 block_k=128 / 256 行 tile / 512 线程 全部被否的同一根因:它们都把 shared 或寄存器推过悬崖。",
         10, INK)
    save(doc, page, "fig_lds_cliff.png")


# --------------------------------------------------- fig 4: k-step timeline
def fig_kstep():
    W, H = 1020, 430
    doc, page = canvas(W, H)
    title(page, "一个 k-step 的四种窗口:寄存器暂存把 DRAM 往返藏进 GEMM 后面",
          W, "stage 1 主 scope,单权重缓冲;barrier 数两版相同(4 个/ k-step)")

    def timeline(y, name, segs, note):
        text(page, 40, y + 4, name, 11, INK, bold=True)
        x = 40
        for lines, w, kind in segs:
            fill = {"copy": FILL_BLUE, "bar": None, "gemm": FILL_GREEN,
                    "dram": FILL_RED, "reg": FILL_AMBER, "lds": FILL_AMBER}[kind]
            edge = {"dram": RED, "reg": AMBER, "lds": AMBER}.get(kind, RULE)
            if kind != "bar":
                box(page, fitz.Rect(x, y + 14, x + w, y + 62), fill=fill, line=edge,
                    width=1.4 if kind in ("dram", "reg", "lds") else 1.0)
                n = len(lines)
                for k, ln in enumerate(lines):
                    text(page, x + w / 2, y + 32 + (k - (n - 1) / 2.0) * 13 + 4, ln,
                         8.6, INK, center=True)
            else:
                page.draw_line((x, y + 6), (x, y + 72), color=INK, width=2.0)
                text(page, x, y + 84, "barrier", 8, MUTED, center=True)
            x += w
        if note:
            text(page, x + 14, y + 34, note[0], 10, note[1], bold=True)
            for k, ln in enumerate(note[2]):
                text(page, x + 14, y + 50 + k * 15, ln, 9, MUTED)

    timeline(96, "v41  无暂存",
             [(["copy A", "16 KiB"], 96, "copy"), (["copy gate", "16 KiB"], 96, "copy"),
              ([""], 8, "bar"), (["gemm gate"], 128, "gemm"), ([""], 8, "bar"),
              (["copy up_w → shared", "DRAM 往返暴露"], 150, "dram"), ([""], 8, "bar"),
              (["gemm up"], 110, "gemm"), ([""], 8, "bar")],
             ("慢", RED, ["DRAM 延迟无计算可藏,", "每次 k-step 都在临界路径上"]))

    timeline(232, "v42  暂存",
             [(["copy A", "16 KiB"], 84, "copy"), (["copy gate", "16 KiB"], 84, "copy"),
              (["copy up_w", "→ w_stage", "寄存器"], 96, "reg"), ([""], 8, "bar"),
              (["gemm gate", "(盖住 up 读延迟)"], 132, "gemm"), ([""], 8, "bar"),
              (["w_stage → shared", "(仅 LDS 写)"], 106, "lds"), ([""], 8, "bar"),
              (["gemm up"], 90, "gemm"), ([""], 8, "bar")],
             ("快 7%", GREEN, ["stage 1 main:4.364 → 4.056 ms", "寄存器 +16 VGPR(234 → 250)"]))

    box(page, fitz.Rect(40, 340, W - 40, 404), fill=FILL_GRAY, line=None)
    for i, s in enumerate([
            "为什么不用双缓冲:48 KiB ⇒ 每 CU 1 block(+65%,见 LDS 悬崖);为什么不用异步拷贝:规则禁止,且本 build >128 线程静默算错;",
            "只剩寄存器有余量。读提前到 barrier 之前发出,「写在读之后」的不变量不变 => 构造上安全,不依赖测试运气。",
    ]):
        text(page, 56, 360 + i * 19, s, 10, INK)
    save(doc, page, "fig_kstep.png")


# ---------------------------------------------------------- fig 5: journey
def fig_journey():
    W, H = 960, 430
    doc, page = canvas(W, H)
    title(page, "优化历程:两次结构级收益把「纯 TileLang 化」的成本补回并反超",
          W, "本地 oj*exact 三配置,40 次迭代(完整记录见工程笔记)")

    vers = ["v22", "v36-38", "v40", "v41", "v42"]
    data = {"Config1": [2.80, 3.05, 3.05, 2.761, 2.678],
            "Config2": [4.99, 5.46, 5.45, 4.975, 4.734],
            "Config3": [9.14, 10.39, 10.39, 9.510, 8.905]}
    cols = {"Config1": (0.26, 0.52, 0.80), "Config2": AMBER, "Config3": (0.55, 0.28, 0.62)}
    x0, y0, pw, ph = 92, 92, 560, 264
    ymin, ymax = 2.0, 11.0

    def px(i):
        return x0 + pw * i / 4

    def py(v):
        return y0 + ph - (v - ymin) / (ymax - ymin) * ph

    for gv in range(3, 12, 2):
        page.draw_line((x0, py(gv)), (x0 + pw, py(gv)), color=(0.93, 0.94, 0.96), width=0.7)
        text(page, x0 - 8, py(gv) + 3, str(gv), 8.5, MUTED, right=True)
    page.draw_line((x0, y0 + ph), (x0 + pw, y0 + ph), color=INK, width=1.2)
    page.draw_line((x0, y0), (x0, y0 + ph), color=INK, width=1.2)
    for i, v in enumerate(vers):
        text(page, px(i), y0 + ph + 16, v, 10, INK, center=True, bold=i == 4)
    text(page, x0 + pw / 2, y0 + ph + 34, "版本", 9.5, MUTED, center=True)
    text(page, x0 - 34, y0 - 6, "ms", 9.5, MUTED)

    for name, ys in data.items():
        page.draw_polyline([(px(i), py(v)) for i, v in enumerate(ys)], color=cols[name],
                           width=2.0)
        for i, v in enumerate(ys):
            page.draw_circle(fitz.Point(px(i), py(v)), 3.0, color=cols[name],
                             fill=(1, 1, 1), width=1.6)
        text(page, px(4) + 10, py(ys[4]) + 3, "%s %.3f" % (name, ys[4]), 9.5, cols[name],
             bold=True)

    def anno(i, lines, color=ACCENT):
        page.draw_line((px(i), y0 - 2), (px(i), y0 - 36), color=color, width=0.9)
        n = len(lines)
        for k, ln in enumerate(lines):
            text(page, px(i), y0 - 16 - (n - 1 - k) * 13, ln, 8.8, color, center=True)

    anno(1, ["删不合规旁路,纯 TileLang 化(+16%)"])
    anno(3, ["swizzle 布局 -9%"])
    anno(4, ["寄存器暂存 -4~6%"])

    box(page, fitz.Rect(700, 120, W - 30, 300), fill=FILL_GRAY, line=None)
    for i, s in enumerate([
            "v36-38 一段变慢不是退化:",
            "按赛题要求删掉两条不合规",
            "旁路(动态改写 GEMM lowering、",
            "PyTorch 承担部分数学),换成",
            "纯 TileLang 语法先付成本;",
            "v41 swizzle 与 v42 暂存用",
            "纯语法级手段补回并反超。",
    ]):
        text(page, 714, 140 + i * 17, s, 9.8, INK if i else ACCENT, bold=(i == 0))
    text(page, 60, 412, "相对 v22:Config1 -4.4% / Config2 -5.1% / Config3 -2.6%;相对 starter kit 模板(同环境端到端):1.9-2.4 倍。",
         10, INK)
    save(doc, page, "fig_journey.png")


# ------------------------------------------------------------ fig 6: results
def fig_results():
    W, H = 1020, 430
    doc, page = canvas(W, H)
    title(page, "性能结果:三个评测配置与 starter kit 模板的同环境对照", W,
          "左:本机 25% sGPU 切片,40 次迭代(02_日志与结果/04);右:组委会 harness 端到端(02_日志与结果/07/08)")

    x0, y0, ph = 84, 118, 200
    conf = [("Config1", 2.678, "85.4 TF/s", "81.7 分"),
            ("Config2", 4.730, "84.6 TF/s", "80.7 分"),
            ("Config3", 8.907, "89.9 TF/s", "80.7 分")]
    ymax = 10.0
    bw = 96
    page.draw_line((x0, y0 + ph), (x0 + 380, y0 + ph), color=INK, width=1.2)
    page.draw_line((x0, y0), (x0, y0 + ph), color=INK, width=1.2)
    for gv in (2, 4, 6, 8, 10):
        yy = y0 + ph - gv / ymax * ph
        page.draw_line((x0, yy), (x0 + 380, yy), color=(0.93, 0.94, 0.96), width=0.7)
        text(page, x0 - 8, yy + 3, str(gv), 8.5, MUTED, right=True)
    for i, (name, v, tf, sc) in enumerate(conf):
        bx = x0 + 50 + i * 116
        bh = v / ymax * ph
        page.draw_rect(fitz.Rect(bx, y0 + ph - bh, bx + bw, y0 + ph), color=None,
                       fill=FILL_BLUE)
        page.draw_rect(fitz.Rect(bx, y0 + ph - bh, bx + bw, y0 + ph), color=ACCENT, width=1.4)
        text(page, bx + bw / 2, y0 + ph - bh - 22, "%.3f ms" % v, 11, INK, bold=True,
             center=True)
        text(page, bx + bw / 2, y0 + ph - bh - 7, sc, 9.5, ACCENT, bold=True, center=True)
        text(page, bx + bw / 2, y0 + ph + 16, name, 10.5, INK, center=True)
        text(page, bx + bw / 2, y0 + ph + 32, tf, 9, MUTED, center=True)
    text(page, x0 + 190, y0 + ph + 54, "题目基线:66 ms / 50 分;有效吞吐按 valid tokens 计",
         9.5, MUTED, center=True)
    text(page, x0 - 30, y0 - 8, "ms", 9.5, MUTED)

    rx = 560
    data = [("7168/2048, 8 exp, topk4", 117.29, 48.38, "2.42x"),
            ("3584/1024, 4 exp, topk2", 18.40, 9.62, "1.91x")]
    text(page, rx, y0 - 8, "同一台机器、同一组配置,只切换实现", 10, INK, bold=True)
    for i, (lab, t0, t1, sp) in enumerate(data):
        by = y0 + 22 + i * 92
        page.draw_rect(fitz.Rect(rx, by, rx + 340 * (t0 / 130.0), by + 22),
                       color=None, fill=FILL_RED)
        page.draw_rect(fitz.Rect(rx, by, rx + 340 * (t0 / 130.0), by + 22), color=RED,
                       width=1.0)
        text(page, rx + 340 * (t0 / 130.0) + 8, by + 16, "模板 %.2f ms" % t0, 9.5, RED)
        page.draw_rect(fitz.Rect(rx, by + 32, rx + 340 * (t1 / 130.0), by + 54),
                       color=None, fill=FILL_GREEN)
        page.draw_rect(fitz.Rect(rx, by + 32, rx + 340 * (t1 / 130.0), by + 54), color=GREEN,
                       width=1.2)
        text(page, rx + 340 * (t1 / 130.0) + 8, by + 48, "本方案 %.2f ms" % t1, 9.5, GREEN,
             bold=True)
        text(page, rx, by + 74, lab, 9.5, INK)
        text(page, rx + 220, by + 74, "加速 %s" % sp, 10.5, GREEN, bold=True)
    text(page, rx, y0 + ph + 32, "该口径含 harness 自身的权重 clone(~700 MB)与 host 打包,", 9.5, MUTED)
    text(page, rx, y0 + ph + 48, "kernel 本身的差距更大。", 9.5, MUTED)
    save(doc, page, "fig_results.png")


# --------------------------------------------------------------- fig 7: tail
def fig_tail():
    W, H = 1020, 428
    doc, page = canvas(W, H)
    title(page, "倾斜路由与运行时薄块分流:不读 host、不假设分布", W,
          "左:评测配置的块布局(灰 = padding 行);右:每个 block 的运行时自判定")

    ex = 60
    ey = 104
    lay = [("expert 0", 128, 64), ("expert 1", 128, 20), ("expert 2", 128),
           ("expert 3", 96, 32), ("expert 4", 128, 64), ("expert 5", 128)]
    text(page, ex, ey - 16, "block 数 = 1.5 × expert 数(三个评测配置均如此)", 10, INK, bold=True)
    yy = ey
    for name, *blocks in lay:
        bx = ex
        text(page, ex - 8, yy + 26, name, 9.5, MUTED, right=True)
        for j, nrow in enumerate(blocks):
            full = min(128, nrow)
            wdt = 128
            page.draw_rect(fitz.Rect(bx, yy, bx + wdt, yy + 34), color=None, fill=FILL_GRAY)
            page.draw_rect(fitz.Rect(bx, yy, bx + wdt * nrow / 128.0, yy + 34), color=None,
                           fill=FILL_BLUE)
            page.draw_rect(fitz.Rect(bx, yy, bx + wdt, yy + 34), color=RULE, width=0.9)
            text(page, bx + wdt / 2, yy + 21, str(nrow), 9.5,
                 INK if nrow > 64 else AMBER, bold=True, center=True)
            bx += wdt + 10
        yy += 44
    text(page, ex, yy + 6, "蓝 = 有效行,灰 = padding;第二个 block 往往只有 16-64 行有效。", 9.5, MUTED)
    text(page, ex, yy + 24, "用 128 行 tile 硬算它们,Config1/2 有 35% 的行是 padding。", 9.5, MUTED)

    dx = 560
    text(page, dx, 92, "每个 block 进入调度时(device 端,零 host 同步):", 10, INK, bold=True)
    box(page, fitz.Rect(dx, 104, W - 40, 140), fill=FILL_BLUE, line=None)
    text(page, dx + 14, 126, "actual_rows = clamp(group_size - (bx·128 - padded_start), 0, tile_m)",
         9.3, INK, mono=True)
    for k, (cond, act, col, fill) in enumerate([
            ("actual_rows > tail_rows", "main scope(M128,配对)", ACCENT, FILL_BLUE),
            ("0 < actual_rows ≤ tail_rows", "tail scope(M64,配对)", GREEN, FILL_GREEN),
            ("actual_rows = 0", "整个 CTA 退出,不读不写", RED, FILL_RED)]):
        by = 158 + k * 62
        arrow(page, (dx + 60, 140 if k == 0 else by - 16), (dx + 60, by), MUTED, w=1.1, head=6)
        box(page, fitz.Rect(dx, by, dx + 240, by + 40), fill=fill, line=None)
        text(page, dx + 12, by + 17, cond, 9.3, INK, mono=True)
        text(page, dx + 12, by + 33, "→ " + act, 10, col, bold=True)
    box(page, fitz.Rect(dx, 352, W - 40, 396), fill=FILL_AMBER, line=AMBER)
    for k, s in enumerate([
            "tail_rows 由纯 shape 规则给出(不读 group_sizes、无 D2H):",
            "blocks ≥ 64 且 blocks < 2·E 且 4·(blocks-E) ≥ blocks ⇒ 64,否则 0"]):
        text(page, dx + 12, 369 + k * 17, s, 9.3, INK, bold=(k == 0))
    save(doc, page, "fig_tail.png")


# ------------------------------------------------------------------ fig 8: regs
def fig_regs():
    W, H = 1040, 400
    doc, page = canvas(W, H)
    title(page, "寄存器水位:所有 scope 保持 ≤ 256 / 线程,全部 2 block/CU", W,
          "mcTracer 实测;每 CU 2 block × 256 线程的上限 = 131072 / 512 = 256")

    rows = [("stage 1 main(M128)", 250, AMBER), ("stage 2 main(C1)", 236, GREEN),
            ("stage 2 main(C2/3)", 238, GREEN), ("stage 1 tail(M64)", 170, GREEN),
            ("stage 2 tail(M64)", 154, GREEN)]
    x0, y0 = 210, 96
    scale = 2.05
    for i, (name, v, c) in enumerate(rows):
        by = y0 + i * 44
        page.draw_rect(fitz.Rect(x0, by, x0 + v * scale, by + 24), color=None,
                       fill=FILL_AMBER if c is AMBER else FILL_GREEN)
        page.draw_rect(fitz.Rect(x0, by, x0 + v * scale, by + 24), color=c, width=1.2)
        text(page, x0 - 10, by + 17, name, 9.8, INK, right=True)
        text(page, x0 + v * scale - 7, by + 17, str(v), 10, c, bold=True, right=True)
    xc = x0 + 256 * scale
    page.draw_line((xc, y0 - 18), (xc, y0 + 44 * 5), color=RED, width=1.8, dashes="[4 3]")
    text(page, xc + 10, y0 - 4, "256 = 每线程上限", 10, RED, bold=True)
    for k, s in enumerate(["再 +16 VGPR(暂存一块 tile)",
                           "即翻越:每 CU 掉到 1 block,",
                           "实测 +8%。",
                           "",
                           "stage2_unroll = 1 的作用就是",
                           "腾出这 6 个寄存器 —— 两个",
                           "旋钮通过寄存器预算耦合。"]):
        text(page, xc + 10, y0 + 40 + k * 17, s, 9.8, RED if k < 3 else INK,
             bold=(k == 0))
    save(doc, page, "fig_regs.png")


if __name__ == "__main__":
    fig_dataflow()
    fig_tile_space()
    fig_lds_cliff()
    fig_kstep()
    fig_tail()
    fig_regs()
    fig_journey()
    fig_results()
