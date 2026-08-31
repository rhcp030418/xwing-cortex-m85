"""Build dependency-free vector figures for the new LNCS paper.

Canonical sources are emitted as SVG and EPS using only the Python standard
library. If ps2pdf and pdftocairo are available, publication PDFs and Markdown
PNG previews are generated as well.
"""

from __future__ import annotations

import csv
import html
import math
import shutil
import subprocess
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parent
ASSETS = ROOT / "assets"
DATA = ROOT / "data"
PT_PER_MM = 72.0 / 25.4

BLUE = "#1769AA"
BLUE_LIGHT = "#E8F2FA"
ORANGE = "#D97706"
ORANGE_LIGHT = "#FFF3E0"
GREEN = "#2E7D32"
GREEN_LIGHT = "#EAF5EA"
RED = "#B42318"
RED_LIGHT = "#FCEBE9"
PURPLE = "#6B4FA1"
PURPLE_LIGHT = "#F0EBF8"
GRAY_900 = "#1F2933"
GRAY_700 = "#4B5563"
GRAY_500 = "#7B8794"
GRAY_300 = "#CBD2D9"
GRAY_200 = "#E4E7EB"
GRAY_100 = "#F5F7FA"
WHITE = "#FFFFFF"


def mm(value: float) -> float:
    return value * PT_PER_MM


def rgb(value: str) -> tuple[float, float, float]:
    value = value.lstrip("#")
    return tuple(int(value[i : i + 2], 16) / 255.0 for i in (0, 2, 4))


def ps_escape(value: str) -> str:
    return value.replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)")


@dataclass
class Scene:
    name: str
    width: float
    height: float
    shapes: list[dict[str, Any]] = field(default_factory=list)

    @classmethod
    def in_mm(cls, name: str, width_mm: float, height_mm: float) -> "Scene":
        return cls(name, mm(width_mm), mm(height_mm))

    def rect(
        self,
        x: float,
        y: float,
        w: float,
        h: float,
        fill: str,
        stroke: str,
        stroke_width: float = 0.8,
        radius: float = 4.0,
    ) -> None:
        self.shapes.append(
            {
                "kind": "rect",
                "x": x,
                "y": y,
                "w": w,
                "h": h,
                "fill": fill,
                "stroke": stroke,
                "stroke_width": stroke_width,
                "radius": radius,
            }
        )

    def line(
        self,
        x1: float,
        y1: float,
        x2: float,
        y2: float,
        stroke: str = GRAY_700,
        stroke_width: float = 0.8,
    ) -> None:
        self.shapes.append(
            {
                "kind": "line",
                "x1": x1,
                "y1": y1,
                "x2": x2,
                "y2": y2,
                "stroke": stroke,
                "stroke_width": stroke_width,
            }
        )

    def polygon(self, points: list[tuple[float, float]], fill: str) -> None:
        self.shapes.append({"kind": "polygon", "points": points, "fill": fill})

    def text(
        self,
        x: float,
        y: float,
        value: str,
        size: float = 7.0,
        color: str = GRAY_900,
        bold: bool = False,
        align: str = "left",
    ) -> None:
        self.shapes.append(
            {
                "kind": "text",
                "x": x,
                "y": y,
                "value": value,
                "size": size,
                "color": color,
                "bold": bold,
                "align": align,
            }
        )

    def arrow(
        self,
        x1: float,
        y1: float,
        x2: float,
        y2: float,
        color: str = GRAY_700,
        width: float = 0.9,
        head: float = 5.0,
    ) -> None:
        self.line(x1, y1, x2, y2, color, width)
        angle = math.atan2(y2 - y1, x2 - x1)
        left = angle + math.pi * 0.82
        right = angle - math.pi * 0.82
        self.polygon(
            [
                (x2, y2),
                (x2 + head * math.cos(left), y2 + head * math.sin(left)),
                (x2 + head * math.cos(right), y2 + head * math.sin(right)),
            ],
            color,
        )

    def save_svg(self, path: Path) -> None:
        lines = [
            '<?xml version="1.0" encoding="UTF-8"?>',
            (
                f'<svg xmlns="http://www.w3.org/2000/svg" '
                f'width="{self.width:.3f}pt" height="{self.height:.3f}pt" '
                f'viewBox="0 0 {self.width:.3f} {self.height:.3f}">'
            ),
            "<title>" + html.escape(self.name) + "</title>",
            '<rect width="100%" height="100%" fill="#FFFFFF"/>',
        ]
        for shape in self.shapes:
            kind = shape["kind"]
            if kind == "rect":
                lines.append(
                    (
                        f'<rect x="{shape["x"]:.3f}" y="{shape["y"]:.3f}" '
                        f'width="{shape["w"]:.3f}" height="{shape["h"]:.3f}" '
                        f'rx="{shape["radius"]:.3f}" fill="{shape["fill"]}" '
                        f'stroke="{shape["stroke"]}" stroke-width="{shape["stroke_width"]:.3f}"/>'
                    )
                )
            elif kind == "line":
                lines.append(
                    (
                        f'<line x1="{shape["x1"]:.3f}" y1="{shape["y1"]:.3f}" '
                        f'x2="{shape["x2"]:.3f}" y2="{shape["y2"]:.3f}" '
                        f'stroke="{shape["stroke"]}" stroke-width="{shape["stroke_width"]:.3f}"/>'
                    )
                )
            elif kind == "polygon":
                points = " ".join(f"{x:.3f},{y:.3f}" for x, y in shape["points"])
                lines.append(f'<polygon points="{points}" fill="{shape["fill"]}"/>')
            elif kind == "text":
                anchor = {"left": "start", "center": "middle", "right": "end"}[shape["align"]]
                weight = "700" if shape["bold"] else "400"
                lines.append(
                    (
                        f'<text x="{shape["x"]:.3f}" y="{shape["y"]:.3f}" '
                        f'font-family="Arial, Helvetica, sans-serif" font-size="{shape["size"]:.3f}" '
                        f'font-weight="{weight}" fill="{shape["color"]}" '
                        f'text-anchor="{anchor}">{html.escape(shape["value"])}</text>'
                    )
                )
        lines.append("</svg>")
        path.write_text("\n".join(lines) + "\n", encoding="utf-8")

    def save_eps(self, path: Path) -> None:
        lines = [
            "%!PS-Adobe-3.0 EPSF-3.0",
            f"%%BoundingBox: 0 0 {math.ceil(self.width)} {math.ceil(self.height)}",
            f"%%HiResBoundingBox: 0 0 {self.width:.3f} {self.height:.3f}",
            f"%%Title: {self.name}",
            "%%Creator: dependency-free build_assets.py",
            "%%EndComments",
            "1 setlinejoin 1 setlinecap",
            "1 1 1 setrgbcolor",
            f"newpath 0 0 moveto {self.width:.3f} 0 lineto {self.width:.3f} {self.height:.3f} lineto 0 {self.height:.3f} lineto closepath fill",
        ]
        for shape in self.shapes:
            kind = shape["kind"]
            if kind == "rect":
                x = shape["x"]
                y = self.height - shape["y"] - shape["h"]
                w = shape["w"]
                h = shape["h"]
                fr, fg, fb = rgb(shape["fill"])
                sr, sg, sb = rgb(shape["stroke"])
                lines.extend(
                    [
                        f"{fr:.4f} {fg:.4f} {fb:.4f} setrgbcolor",
                        f"newpath {x:.3f} {y:.3f} moveto {w:.3f} 0 rlineto 0 {h:.3f} rlineto {-w:.3f} 0 rlineto closepath fill",
                        f"{sr:.4f} {sg:.4f} {sb:.4f} setrgbcolor",
                        f"{shape['stroke_width']:.3f} setlinewidth",
                        f"newpath {x:.3f} {y:.3f} moveto {w:.3f} 0 rlineto 0 {h:.3f} rlineto {-w:.3f} 0 rlineto closepath stroke",
                    ]
                )
            elif kind == "line":
                sr, sg, sb = rgb(shape["stroke"])
                lines.extend(
                    [
                        f"{sr:.4f} {sg:.4f} {sb:.4f} setrgbcolor",
                        f"{shape['stroke_width']:.3f} setlinewidth",
                        (
                            f"newpath {shape['x1']:.3f} {self.height - shape['y1']:.3f} moveto "
                            f"{shape['x2']:.3f} {self.height - shape['y2']:.3f} lineto stroke"
                        ),
                    ]
                )
            elif kind == "polygon":
                fr, fg, fb = rgb(shape["fill"])
                points = shape["points"]
                commands = [
                    f"newpath {points[0][0]:.3f} {self.height - points[0][1]:.3f} moveto"
                ]
                commands.extend(
                    f"{x:.3f} {self.height - y:.3f} lineto" for x, y in points[1:]
                )
                commands.append("closepath fill")
                lines.extend([f"{fr:.4f} {fg:.4f} {fb:.4f} setrgbcolor", " ".join(commands)])
            elif kind == "text":
                fr, fg, fb = rgb(shape["color"])
                font = "Helvetica-Bold" if shape["bold"] else "Helvetica"
                align_cmd = ""
                if shape["align"] == "center":
                    align_cmd = "dup stringwidth pop 2 div neg 0 rmoveto"
                elif shape["align"] == "right":
                    align_cmd = "dup stringwidth pop neg 0 rmoveto"
                value = ps_escape(shape["value"])
                lines.extend(
                    [
                        f"{fr:.4f} {fg:.4f} {fb:.4f} setrgbcolor",
                        f"/{font} findfont {shape['size']:.3f} scalefont setfont",
                        (
                            f"{shape['x']:.3f} {self.height - shape['y']:.3f} moveto "
                            f"({value}) {align_cmd} show"
                        ),
                    ]
                )
        lines.extend(["showpage", "%%EOF"])
        path.write_text("\n".join(lines) + "\n", encoding="ascii")

    def save(self) -> None:
        ASSETS.mkdir(parents=True, exist_ok=True)
        self.save_svg(ASSETS / f"{self.name}.svg")
        self.save_eps(ASSETS / f"{self.name}.eps")


def wrap(value: str, max_chars: int) -> list[str]:
    words = value.split()
    out: list[str] = []
    line = ""
    for word in words:
        trial = word if not line else f"{line} {word}"
        if len(trial) <= max_chars:
            line = trial
        else:
            if line:
                out.append(line)
            line = word
    if line:
        out.append(line)
    return out


def box(
    scene: Scene,
    x: float,
    y: float,
    w: float,
    h: float,
    label: str,
    fill: str,
    stroke: str,
    size: float = 6.5,
    bold: bool = False,
    sublabel: str | None = None,
    max_chars: int = 22,
) -> None:
    scene.rect(x, y, w, h, fill, stroke, 0.8, 4.0)
    lines = wrap(label, max_chars)
    if sublabel:
        lines.append(sublabel)
    leading = size + 1.0
    start = y + h / 2 - (len(lines) - 1) * leading / 2 + size * 0.33
    for idx, line in enumerate(lines):
        is_sub = sublabel is not None and idx == len(lines) - 1
        scene.text(
            x + w / 2,
            start + idx * leading,
            line,
            size - 0.8 if is_sub else size,
            GRAY_700 if is_sub else GRAY_900,
            bold and not is_sub,
            "center",
        )


def scene_title(scene: Scene, value: str, subtitle: str) -> None:
    scene.text(scene.width / 2, mm(6.5), value, 9.0, GRAY_900, True, "center")
    scene.text(scene.width / 2, mm(10.0), subtitle, 5.7, GRAY_700, False, "center")


def fig01() -> Scene:
    s = Scene.in_mm("fig01_xwing_optimization_map", 122, 78)
    scene_title(
        s,
        "Where the eight retained optimizations act",
        "KG = key generation; E = encapsulation; W/C = warm/cold decapsulation",
    )
    left = mm(4)
    lane_x = mm(22)
    comb_x = mm(95)
    ml_y = mm(20)
    x_y = mm(41)

    s.text(left + mm(7), mm(16), "X-Wing API", 7.0, GRAY_900, True, "center")
    box(s, left, mm(20), mm(14), mm(9), "KG / E / W / C", GRAY_100, GRAY_500, 5.7, True, max_chars=12)

    s.text(lane_x, mm(16), "ML-KEM lane", 6.2, BLUE, True)
    box(s, lane_x, ml_y, mm(16), mm(9), "ML-KEM-768", BLUE_LIGHT, BLUE, 6.2, True, max_chars=15)
    box(s, lane_x + mm(19), ml_y, mm(23), mm(9), "[1] MVE NTT + current-order store", BLUE_LIGHT, BLUE, 5.5, max_chars=18)
    box(s, lane_x + mm(45), ml_y, mm(23), mm(9), "[2] 11 MVE data-format transformations", BLUE_LIGHT, BLUE, 5.3, max_chars=18)
    s.arrow(left + mm(14), ml_y + mm(4.5), lane_x, ml_y + mm(4.5), BLUE)
    s.arrow(lane_x + mm(16), ml_y + mm(4.5), lane_x + mm(19), ml_y + mm(4.5), BLUE)
    s.arrow(lane_x + mm(42), ml_y + mm(4.5), lane_x + mm(45), ml_y + mm(4.5), BLUE)

    s.text(lane_x, mm(37), "X25519 lane", 6.2, ORANGE, True)
    box(s, lane_x, x_y, mm(16), mm(12), "X25519", ORANGE_LIGHT, ORANGE, 6.3, True)
    box(s, lane_x + mm(19), x_y - mm(2), mm(22), mm(8), "[3] Fixed-base comb", ORANGE_LIGHT, ORANGE, 5.6, sublabel="KG / E / C", max_chars=20)
    box(s, lane_x + mm(19), x_y + mm(8), mm(22), mm(8), "[7] MVE cswap", ORANGE_LIGHT, ORANGE, 5.8, sublabel="E / W / C", max_chars=20)
    box(s, lane_x + mm(44), x_y - mm(2), mm(24), mm(8), "[4,5] Field mul/sqr schedule", ORANGE_LIGHT, ORANGE, 5.3, sublabel="all X25519", max_chars=20)
    box(s, lane_x + mm(44), x_y + mm(8), mm(24), mm(8), "[8] Paired inversion", PURPLE_LIGHT, PURPLE, 5.7, sublabel="E only", max_chars=20)
    s.line(left + mm(14), ml_y + mm(4.5), left + mm(14), x_y + mm(6), GRAY_700, 0.8)
    s.arrow(left + mm(14), x_y + mm(6), lane_x, x_y + mm(6), ORANGE)
    s.arrow(lane_x + mm(16), x_y + mm(4), lane_x + mm(19), x_y + mm(2), ORANGE)
    s.arrow(lane_x + mm(16), x_y + mm(8), lane_x + mm(19), x_y + mm(12), ORANGE)
    s.arrow(lane_x + mm(41), x_y + mm(2), lane_x + mm(44), x_y + mm(2), ORANGE)
    s.arrow(lane_x + mm(41), x_y + mm(12), lane_x + mm(44), x_y + mm(12), PURPLE)
    s.arrow(lane_x + mm(56), x_y + mm(6), lane_x + mm(56), x_y + mm(8), PURPLE, 0.8, 4.0)

    box(
        s,
        lane_x,
        mm(62),
        mm(68),
        mm(8),
        "[6] Alignment-aware memcpy / memset across common glue",
        GREEN_LIGHT,
        GREEN,
        5.8,
        max_chars=50,
    )

    box(s, comb_x, mm(29), mm(22), mm(13), "SHA3-256 combiner", GRAY_100, GRAY_700, 6.0, True)
    box(s, comb_x, mm(48), mm(22), mm(9), "32-byte shared secret", GREEN_LIGHT, GREEN, 5.8, True)
    s.arrow(lane_x + mm(68), ml_y + mm(4.5), comb_x, mm(33), BLUE)
    s.arrow(lane_x + mm(68), x_y + mm(6), comb_x, mm(38), ORANGE)
    s.arrow(lane_x + mm(68), x_y + mm(12), comb_x, mm(41), PURPLE)
    s.arrow(comb_x + mm(11), mm(42), comb_x + mm(11), mm(48), GREEN)
    return s


def fig02() -> Scene:
    s = Scene.in_mm("fig02_adoption_pipeline", 122, 55)
    scene_title(
        s,
        "A candidate becomes a result only after end-to-end gates",
        "Intermediate percentages remain diagnostic; the headline comes from one reference-to-final-integrated comparison",
    )
    y = mm(18)
    xs = [4, 27, 51, 76, 101]
    widths = [18, 19, 20, 20, 17]
    labels = [
        ("Candidate", "one change"),
        ("Micro gate", "KAT + local cycles"),
        ("Real consumer", "full API path"),
        ("Cumulative ELF", "interaction check"),
        ("Reference / Final integrated", "final headline"),
    ]
    colors = [
        (GRAY_100, GRAY_500),
        (BLUE_LIGHT, BLUE),
        (ORANGE_LIGHT, ORANGE),
        (PURPLE_LIGHT, PURPLE),
        (GREEN_LIGHT, GREEN),
    ]
    for idx, ((label, sublabel), color) in enumerate(zip(labels, colors)):
        x = mm(xs[idx])
        bw = mm(widths[idx])
        box(s, x, y, bw, mm(13), label, color[0], color[1], 6.1, True, sublabel, 16)
        if idx < len(labels) - 1:
            s.arrow(x + bw, y + mm(6.5), mm(xs[idx + 1]), y + mm(6.5))
    for idx in (1, 2, 3):
        cx = mm(xs[idx] + widths[idx] / 2)
        s.line(cx, y + mm(13), cx, mm(38), RED, 0.8)
        s.arrow(cx, mm(38), cx, mm(41), RED, 0.8, 4.0)
    box(s, mm(36), mm(41), mm(51), mm(7), "Reject, preserve logs, and never add its cycles", RED_LIGHT, RED, 5.7, max_chars=50)
    return s


def fig03() -> Scene:
    s = Scene.in_mm("fig03_paired_inversion", 122, 64)
    scene_title(
        s,
        "Two X25519 endpoints make paired inversion possible",
        "The final integrated encapsulation path replaces two expensive inversions with one zero-safe inversion",
    )
    s.text(mm(30), mm(16), "Reference: independent inversions", 6.8, RED, True, "center")
    box(s, mm(4), mm(21), mm(14), mm(8), "d1", GRAY_100, GRAY_500, 6.3, True)
    box(s, mm(4), mm(35), mm(14), mm(8), "d2", GRAY_100, GRAY_500, 6.3, True)
    box(s, mm(23), mm(21), mm(17), mm(8), "invert", RED_LIGHT, RED, 6.0, True)
    box(s, mm(23), mm(35), mm(17), mm(8), "invert", RED_LIGHT, RED, 6.0, True)
    box(s, mm(45), mm(21), mm(12), mm(8), "d1^-1", GRAY_100, GRAY_500, 5.9)
    box(s, mm(45), mm(35), mm(12), mm(8), "d2^-1", GRAY_100, GRAY_500, 5.9)
    s.arrow(mm(18), mm(25), mm(23), mm(25), RED)
    s.arrow(mm(18), mm(39), mm(23), mm(39), RED)
    s.arrow(mm(40), mm(25), mm(45), mm(25), RED)
    s.arrow(mm(40), mm(39), mm(45), mm(39), RED)
    box(s, mm(13), mm(49), mm(35), mm(8), "Cost: 2 inversions", RED_LIGHT, RED, 6.1, True)

    s.line(mm(61), mm(13), mm(61), mm(57), GRAY_300, 0.8)
    s.text(mm(92), mm(16), "Final integrated: zero-safe paired inversion", 6.8, GREEN, True, "center")
    box(s, mm(65), mm(21), mm(13), mm(8), "d1", GRAY_100, GRAY_500, 6.3, True)
    box(s, mm(65), mm(35), mm(13), mm(8), "d2", GRAY_100, GRAY_500, 6.3, True)
    box(s, mm(82), mm(25), mm(16), mm(14), "zero test + replace 0 by 1", PURPLE_LIGHT, PURPLE, 5.3, max_chars=12)
    box(s, mm(102), mm(25), mm(16), mm(14), "t = (d1*d2)^-1", GREEN_LIGHT, GREEN, 5.5, True, max_chars=14)
    s.arrow(mm(78), mm(25), mm(82), mm(29), PURPLE)
    s.arrow(mm(78), mm(39), mm(82), mm(35), PURPLE)
    s.arrow(mm(98), mm(32), mm(102), mm(32), GREEN)
    box(s, mm(69), mm(49), mm(45), mm(8), "Recover both inverses; restore zero masks", GREEN_LIGHT, GREEN, 5.6, True, max_chars=44)
    s.arrow(mm(110), mm(39), mm(110), mm(49), GREEN)
    return s


def load_final() -> list[dict[str, str]]:
    with (DATA / "final_performance.tsv").open("r", encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t"))


def fig04() -> Scene:
    rows = load_final()
    s = Scene.in_mm("fig04_final_performance", 122, 70)
    scene_title(
        s,
        "Final same-ELF Reference-Integrated comparison",
        "Reference is normalized to 100%; blue bars show the cycle cost remaining in Integrated",
    )
    plot_x = mm(33)
    plot_w = mm(82)
    top = mm(19)
    gap = mm(10.5)
    labels = ["Key generation", "Encapsulation", "Decapsulation (warm)", "Decapsulation (cold)"]
    for tick in range(0, 101, 20):
        x = plot_x + plot_w * tick / 100
        s.line(x, mm(15), x, mm(58), GRAY_200, 0.5)
        s.text(x, mm(62), str(tick), 5.4, GRAY_700, False, "center")
    s.text(plot_x + plot_w / 2, mm(67), "Normalized cycle cost (%)", 5.8, GRAY_700, False, "center")
    for idx, row in enumerate(rows):
        y = top + idx * gap
        saved = float(row["conservative_improvement_pct"])
        remaining = 100.0 - saved
        s.text(plot_x - mm(2), y + mm(3.7), labels[idx], 6.0, GRAY_900, False, "right")
        s.rect(plot_x, y, plot_w, mm(5.5), GRAY_100, GRAY_300, 0.7, 3.0)
        s.rect(plot_x, y, plot_w * remaining / 100.0, mm(5.5), BLUE, BLUE, 0.0, 3.0)
        s.text(plot_x + mm(2), y + mm(3.7), f"Integrated {remaining:.2f}%", 5.6, WHITE, True)
        saved_center = plot_x + plot_w * (remaining + saved / 2.0) / 100.0
        s.text(saved_center, y + mm(3.7), f"-{saved:.2f}%", 5.5, GRAY_700, True, "center")
    return s


def convert_outputs() -> None:
    mgs = shutil.which("mgs")
    ps2pdf = shutil.which("ps2pdf") or shutil.which("ps2pdf14")
    pdftocairo = shutil.which("pdftocairo")
    if mgs:
        for eps in sorted(ASSETS.glob("fig*.eps")):
            pdf = eps.with_suffix(".pdf")
            eps_rel = eps.relative_to(ROOT)
            pdf_rel = pdf.relative_to(ROOT)
            subprocess.run(
                [
                    mgs,
                    "-dSAFER",
                    "-dBATCH",
                    "-dNOPAUSE",
                    "-sDEVICE=pdfwrite",
                    "-dCompatibilityLevel=1.4",
                    "-dEPSCrop",
                    f"-sOutputFile={pdf_rel}",
                    str(eps_rel),
                ],
                cwd=ROOT,
                check=True,
            )
    elif ps2pdf:
        for eps in sorted(ASSETS.glob("fig*.eps")):
            pdf = eps.with_suffix(".pdf")
            subprocess.run(
                [ps2pdf, "-dEPSCrop", str(eps.relative_to(ROOT)), str(pdf.relative_to(ROOT))],
                cwd=ROOT,
                check=True,
            )
    if mgs:
        for pdf in sorted(ASSETS.glob("fig*.pdf")):
            png = pdf.with_suffix(".png")
            subprocess.run(
                [
                    mgs,
                    "-dSAFER",
                    "-dBATCH",
                    "-dNOPAUSE",
                    "-sDEVICE=png16m",
                    "-r180",
                    "-dTextAlphaBits=4",
                    "-dGraphicsAlphaBits=4",
                    f"-sOutputFile={png.relative_to(ROOT)}",
                    str(pdf.relative_to(ROOT)),
                ],
                cwd=ROOT,
                check=True,
            )
    elif pdftocairo:
        for pdf in sorted(ASSETS.glob("fig*.pdf")):
            stem = pdf.with_suffix("")
            subprocess.run(
                [
                    pdftocairo,
                    "-png",
                    "-singlefile",
                    "-r",
                    "180",
                    str(pdf.relative_to(ROOT)),
                    str(stem.relative_to(ROOT)),
                ],
                cwd=ROOT,
                check=True,
            )


def main() -> None:
    ASSETS.mkdir(parents=True, exist_ok=True)
    for scene in (fig01(), fig02(), fig03(), fig04()):
        scene.save()
    convert_outputs()


if __name__ == "__main__":
    main()
