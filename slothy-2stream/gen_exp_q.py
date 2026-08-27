# 실험 Q — 노출 223 cyc 의 오차 0 분해: B 에서 vstrw 만 끄고 나머지를 전부 고정한다.
#
# 배경(40차 ②‴ 산술 정정 포함):
#   실험 J 지퍼의 노출은 223.0 cyc 였다. 40차는 이를 "ⓐ vstrw 차단 242 vs ⓑ 스칼라 로드
#   157 의 중첩"으로 읽었으나 그 비교는 **단위가 다르다** — 242 는 '스칼라가 못 들어가는 B
#   사이클 수'이고 223 은 '슬롯을 못 얻은 A 명령 수'다. B 단독이 752 사이클인데 A 는 499
#   명령뿐이라, vstrw 가 242 사이클을 막아도 남는 슬롯이 510 개 >= 499 → **ⓐ 단독으로는
#   노출이 0 이어야 한다**. 따라서 223 은 ⓐ 로 설명되지 않는다.
#   또한 A 는 단독 499 명령 / 310.0 cyc = **1.61 IPC 로 자기들끼리 듀얼이슈**한다. 1:1 지퍼
#   에서는 A 명령마다 B 명령이 끼므로 이 자기-듀얼이슈가 통째로 사라진다.
#
# 판정식 (사전 등록 — 측정 후 변경 금지):
#   노출' := zip' - B'_solo - loop      (J 와 동일한 정의)
#   (1) 노출' <= 20        -> ⓐ(vstrw 차단)가 223 의 사실상 전부. ⓑ 기여 무시 가능
#   (2) 140 <= 노출' <= 175 -> ⓑ(스칼라 로드 157) 단독으로 설명. ⓐ 기여는 중첩되어 0
#   (3) 노출' > 175        -> ⓐ·ⓑ 어느 쪽도 아닌 제3 항 = A 자기-듀얼이슈 상실이 지배.
#                             이 경우 223 은 '차단'이 아니라 '슬롯 부족'으로 재해석해야 한다
#   부수 검산: B'_solo 가 B_solo(752.0)에서 크게 벗어나면 치환이 B 내부 스톨을 바꾼 것이므로
#             노출' 비교 전에 그 편차를 먼저 보고한다.
#
# 설계 선택: **(a) 측정 전용 커널**을 택했다. 이유 —
#   (b) 기능 등가 변형은 중간 스토어를 실제로 없애므로 **명령 수가 줄어든다**. 명령 수가
#   줄면 A 가 쓸 수 있는 슬롯 예산 자체가 바뀌어 단일 변수 통제가 깨진다. 40차 ②′ 의
#   N×P 교차 대조가 결론을 낼 수 있었던 것은 '길이·단독비용 고정, 명령 클래스만 변경'
#   이었기 때문이고, 여기서도 같은 규율을 따른다. 등가성 검증 비용을 아끼려는 것이 아니라
#   (a) 가 방법론적으로 더 옳다. 기능 등가가 아니므로 **KAT 대상이 아님**을 명시한다.
#
# 치환: vstrw.u32 qS, [base,#off]  ->  vorr qS, qS, qS   (MVE 항등 연산)
#   veor qS,qS,qS 가 아니라 vorr 를 쓴 이유: vorr 는 값을 보존하므로 하류 명령이 읽는
#   데이터가 그대로다. 소스 qS 를 읽고 qS 를 쓰는 의존 구조도 vstrw 와 같은 자리에 남는다.
#
# 커널 3개(슬롯 89~91): B' 단독 · A×B' 지퍼 · A;B' 순차(검산용).
# 사용법(Windows): py gen_exp_q.py
import re
import gen_exp_j as J   # 주의: import 시 expj_board.s 가 재생성된다(결정적 — diff 로 검증)
from stitch_zip import zip_streams

DST = J.DST
fiat, frame = J.fiat, J.frame
unit_m = J.LOADP + fiat                 # A 스트림 — J 와 완전 동일

RE_VST = re.compile(r"^\s*vstrw\.u32 (q\d+), \[")
mve_ns, n_sub = [], 0
for ins in J.mve:
    m = RE_VST.match(ins)
    if m:
        mve_ns.append("	vorr {0}, {0}, {0}".format(m.group(1)))
        n_sub += 1
    else:
        mve_ns.append(ins)

assert len(mve_ns) == len(J.mve), "명령 수 불변이 이 실험의 전제다"
assert n_sub == 121, ("vstrw 치환 개수", n_sub)
assert not any("vstrw" in i for i in mve_ns), "vstrw 잔존"
assert sum(1 for i in mve_ns if "vldrw" in i) == 181, "vldrw 는 건드리지 않는다"

out = [".text", ".syntax unified", ".thumb", "",
       "// 실험 Q: vstrw 없는 B' (gen_exp_q.py 생성) — 측정 전용, 기능 등가 아님"]
out += J.wrap("expq_b", J.COMMON, mve_ns, frame)
out += J.wrap("expq_stitch", J.COMMON,
              zip_streams([[i] for i in unit_m], mve_ns), frame)
out += J.wrap("expq_stitch2", J.COMMON,
              zip_streams(J.pair_clumps(unit_m), mve_ns), frame)
out += J.wrap("expq_seq", J.COMMON, unit_m + mve_ns, frame)

open(DST + r"\expq_board.s", "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print("A=%d  B'=%d (vstrw %d -> vorr, vldrw 181 유지)  -> expq_board.s"
      % (len(unit_m), len(mve_ns), n_sub))
