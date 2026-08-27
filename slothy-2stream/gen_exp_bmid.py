# 실험 B-mid 입력 생성: 스필-프리 중간 스케일 (A 56명령 × B 100명령 = 156)
# A = exp_a의 곱+캐리 패턴 8그룹 (r2/r3 누산으로 그룹 간 체인 — 실제 곱의 직렬성 모사)
# B = 진짜 Keccak θ 전체 패스 (stitch_zip.theta_stream, r8=포인터)
# 사용법(Windows): py gen_exp_bmid.py
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import theta_stream  # noqa: E402

OUT = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream\exp_bmid.s"

GROUP = ["        umull r0, r1, r4, r5",
         "        umaal r0, r1, r4, r6",
         "        adds r2, r2, r0",
         "        adcs r3, r3, r1",
         "        umull r0, r1, r5, r6",
         "        adds r2, r2, r0",
         "        adc r3, r3, r1"]

a = []
for _ in range(8):
    a += GROUP

b = theta_stream()   # r8 ptr, r9/r10 data — A(r0-r6)와 분리

lines = (["// 실험 B-mid: 곱 패턴 8그룹 + Keccak theta 전체 — 순차 연접 (156명령)",
          "start:"] + a + b + ["end:"])
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
print(f"A={len(a)} B={len(b)} total={len(a) + len(b)} -> exp_bmid.s")
