# 실험 J-solo — J의 A/B 스트림 단독 비용 분해 (2026-08-21)
#
# 목적: J의 은닉률 분모 min(A,B)를 실측한다. 지금까지 J는 seq/stitch 두 값만 있어
#       절감 87.0 cyc 은 알아도 그것이 "짧은 쪽의 몇 %"인지가 추정치였다.
#       실험 P(2026-08-21)가 스칼라 로드의 완전 노출을 확정했으므로, 분모만 실측되면
#       J의 27%를 스필 로드 개수로 닫을 수 있다.
#
# 커널 3개(슬롯 86~88): A 단독 · B 단독 · 빈 루프(래퍼 오버헤드 = 정확 차감용).
# gen_exp_j.py 의 parse_fiat/wrap/COMMON/LOADP 를 그대로 재사용 — 래퍼가 같아야
# 오버헤드가 같고, 같아야 차감이 성립한다.
#
# 사용법(Windows): py gen_exp_j_solo.py
import gen_exp_j as J   # 주의: import 시 expj_board.s 가 재생성된다(결정적 — diff로 검증)

DST = J.DST
fiat, frame, mve = J.fiat, J.frame, J.mve
unit_m = J.LOADP + fiat

out = [".text", ".syntax unified", ".thumb", "",
       "// 실험 J-solo: A/B 단독 + 빈 루프 (gen_exp_j_solo.py 생성)"]
out += J.wrap("expj_a", J.COMMON, unit_m, frame)     # A 스트림 = LOADP + fiat 필드곱
out += J.wrap("expj_b", J.COMMON, mve, frame)        # B 스트림 = 2-베이스 MVE 라운드
out += J.wrap("expj_loop", J.COMMON, [], frame)      # 본문 0 = 래퍼 루프 비용

open(DST + r"\expjsolo_board.s", "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"A={len(unit_m)} B={len(mve)} loop=0  -> expjsolo_board.s")
