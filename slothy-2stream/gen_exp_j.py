# 실험 J — 최종 통합: 진짜 fiat 필드곱(r10/r11 양보, 스필→r12) × 2-베이스 MVE 라운드.
# 완전 레지스터 분리: 스칼라 r0-r9,r12 / 벡터 r10,r11,Q. 코이슈 vs 순차 3파전 보드 커널.
# 사용법(Windows): py gen_exp_j.py
import re
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream")
from mve_keccak import round_mve4_b2  # noqa: E402

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import zip_streams  # noqa: E402

SP = r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------\87cc9899-01a4-4c61-b1f5-c392fd51dbfe\scratchpad"
DST = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen"


def pair_clumps(ins):
    """Preserve A order while exposing adjacent A pairs to the dual-issue core."""
    out = [ins[i:i + 2] for i in range(0, len(ins), 2)]
    assert [x for clump in out for x in clump] == ins
    return out


def parse_fiat(path, label="fiat_mul_yield2"):
    """GCC fiat 함수 본문 추출 — sp 스필은 그대로 유지(프레임은 래퍼가 관리).
    r12는 fiat의 값 레지스터라 스필 베이스로 못 씀 → sp 상대 유지가 정답."""
    lines = open(path, encoding="utf-8", errors="replace").read().splitlines()
    body, infn, frame = [], False, 0
    for ln in lines:
        if re.match(rf"^{re.escape(label)}:", ln):
            infn = True
            continue
        if not infn:
            continue
        s = ln.strip()
        if not s or s.startswith((".", "@", "//")):
            if s.startswith(".size"):
                break
            continue
        if s.startswith(("push", "pop")):
            continue
        m = re.match(r"(sub|add)\s+sp,\s*(?:sp,\s*)?#(\d+)", s)
        if m:
            if m.group(1) == "sub":
                frame = max(frame, int(m.group(2)))
            continue   # 프레임 조정은 래퍼가 1회 처리
        body.append("\t" + s)
    return body, frame


def wrap(name, setup, body, frame):
    # fiat가 r0-r9·ip(r12)·lr 전부 사용, r10/r11은 MVE → 자유 GP 없음 → 카운터 메모리 상주.
    # 프레임을 frame+8로 잡고 [sp,#frame]에 카운터(fiat 스필은 0..frame-1). 감산 시 r0 임시
    # (r0는 매 iter LOADP가 재설정하므로 카운터 감산 직후 파괴돼도 무해).
    fr = frame + 8
    return ([f"// {name}", f".global {name}", f".type {name}, %function",
             ".thumb_func", ".balign 16", f"{name}:",
             "\tpush {r4-r11, lr}", "\tvpush {d8-d15}",
             f"\tsub sp, sp, #{fr}", f"\tstr r0, [sp, #{frame}]"] + setup +
            [".balign 16", "1:"] + body +
            [f"\tldr r0, [sp, #{frame}]", "\tsubs r0, r0, #1", f"\tstr r0, [sp, #{frame}]",
             "\tbne 1b", f"\tadd sp, sp, #{fr}", "\tvpop {d8-d15}", "\tpop {r4-r11, pc}", ""])


fiat, frame = parse_fiat(DST + r"\fiat_yield2.s")
mve = round_mve4_b2()
print(f"fiat body={len(fiat)} (frame {frame}B) · mve body={len(mve)}")

# 셋업: MVE 베이스 r10=block+508, r11=block+1524 (r12는 fiat 값 레지스터라 안 씀)
COMMON = ["\tmovw r10, #:lower16:g_mve", "\tmovt r10, #:upper16:g_mve", "\tadd r10, r10, #508",
          "\tmovw r11, #:lower16:g_mve", "\tmovt r11, #:upper16:g_mve", "\tadd r11, r11, #1524"]
LOADP = ["\tmovw r0, #:lower16:g_fc_out", "\tmovt r0, #:upper16:g_fc_out",
         "\tmovw r1, #:lower16:g_fc_a", "\tmovt r1, #:upper16:g_fc_a",
         "\tmovw r2, #:lower16:g_fc_b", "\tmovt r2, #:upper16:g_fc_b"]
# 곱 인자 재로드는 스칼라 스트림 앞에 필요 (본문이 r0-r2 파괴)

seq_body = LOADP + fiat + mve                      # 순차: 곱 다음 라운드
zip_body = zip_streams([[i] for i in (LOADP + fiat)], mve)   # 스티칭: 1:1 교차
zip2_body = zip_streams(pair_clumps(LOADP + fiat), mve)       # 실험 R: A 2개씩 인접 배치
# 굵은 교대 = 순차와 동일 구조(한 덩어리씩) — 여기선 seq가 그 역할(대조 명시)

hdr = [".text", ".syntax unified", ".thumb", ""]
out = hdr
out += wrap("expj_seq", COMMON, seq_body, frame)
out += wrap("expj_stitch", COMMON, zip_body, frame)
out += wrap("expj_stitch2", COMMON, zip2_body, frame)

# 실험 K — 4단계 대조군 3종: 같은 일(곱3+라운드3)을 세 배치로.
# 굵은 교대 = 함수 단위 교대(곱,라운드,곱,라운드...) — 스티칭 이득이 명령어 교차 덕임을 분리.
unit_m = LOADP + fiat
seqk = unit_m * 3 + mve * 3                       # MMMRRR
coarsek = (unit_m + mve) * 3                      # MRMRMR
stitchk = zip_streams([[i] for i in unit_m * 3], mve * 3)   # 명령어 지퍼
out += wrap("expk_seq", COMMON, seqk, frame)
out += wrap("expk_coarse", COMMON, coarsek, frame)
out += wrap("expk_stitch", COMMON, stitchk, frame)

# 실험 M — X-Wing encaps 실비율 매크로 유닛: 곱8 : 라운드1
# (encaps: 스칼라곱 2회=곱 ~2,193회 vs 순열 44회=배치라운드 264회 → 8.3:1)
seqm = unit_m * 8 + mve
stitchm = zip_streams([[i] for i in unit_m * 8], mve)
stitchm2 = zip_streams(pair_clumps(unit_m * 8), mve)
out += wrap("expm_seq", COMMON, seqm, frame)
out += wrap("expm_stitch", COMMON, stitchm, frame)
out += wrap("expm_stitch2", COMMON, stitchm2, frame)

# keygen/decaps 비율(스칼라곱 1회 ≈ 곱 1,100 : 라운드 264 ≈ 4:1) 유닛
seqm4 = unit_m * 4 + mve
stitchm4 = zip_streams([[i] for i in unit_m * 4], mve)
stitchm4_2 = zip_streams(pair_clumps(unit_m * 4), mve)
out += wrap("expm4_seq", COMMON, seqm4, frame)
out += wrap("expm4_stitch", COMMON, stitchm4, frame)
out += wrap("expm4_stitch2", COMMON, stitchm4_2, frame)

open(DST + r"\expj_board.s", "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"seq={len(seq_body)} stitch={len(zip_body)} stitch2={len(zip2_body)} "
      f"k3={len(seqk)} m8={len(seqm)} -> expj_board.s")
