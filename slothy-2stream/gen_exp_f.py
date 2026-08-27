# 실험 F-solver 입력: 스칼라 MAC 체인 × MVE 4-way 라운드 (2026-08-17)
# 코이슈를 솔버에 맡겨 1:1 지퍼(58% 은닉)를 얼마나 넘는지 측정.
# A = umaal 체인(GP 데이터 r0/r1, 무의존 재료 r2/r3) — 실측 파이프 포화 스트림.
# B = MVE 라운드 (베이스 r6,r7,r9,r10,r11 — A와 무경합).
# v2: 입력을 순차 연접 → 1:1 지퍼로 변경. 분할 휴리스틱은 위치 기반 윈도우라
#     연접 입력이면 윈도우가 순수-A/순수-B뿐이라 교차 불가능(1차 시도 실패 원인).
#     지퍼 입력 = 같은 DFG, 윈도우마다 A·B 혼재 → 솔버는 국소 재배치만 하면 됨.
# 사용법(Windows): py gen_exp_f.py
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream")
sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from mve_keccak import remap_bases, round_mve4  # noqa: E402
from stitch_zip import zip_streams  # noqa: E402

OUT = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream\exp_f.s"

MAP = {"r1": "r6", "r2": "r7", "r3": "r9", "r4": "r10", "r5": "r11"}
b = remap_bases(round_mve4(), MAP)
# SLOTHY 파서 정규화: vorr는 dt 필수(모델), vmov.i32는 그대로 OK
b = [ins.replace("vorr ", "vorr.u32 ") for ins in b]
# 스칼라 체인: A = {r0,r1 누산 / r2,r3 재료} — B(r6,r7,r9,r10,r11+Q)와 무경합.
# 같은 레지스터 재사용은 in_out 의존이라 솔버가 직렬화 → "파이프 포화 스트림" 대표.
a = ["\tumaal r0, r1, r2, r3"] * 611
body = zip_streams([[i] for i in a], b)
lines = (["// 실험 F-solver: 스칼라 MAC 체인 × MVE 4-way 라운드 (코이슈, 1:1 지퍼 입력)",
          f"// A={len(a)} scalar, B={len(b)} vector",
          "start:"] + body + ["end:"])
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
print(f"A={len(a)} B={len(b)} total={len(a) + len(b)} -> exp_f.s")
