# SLOTHY v81m 모델 확장 패치 v0.1 — 기여 ③(2-스트림 스티칭)의 첫 코드 (2026-08-16)
#
# 추가하는 것: X25519 스트림에 필요한 5개 명령 (v81m 모델에 부재 확인됨)
#   umull, umaal          — 캐리 없는/있는 32x32→64 MAC (플래그 불사용)
#   adds, adcs, adc       — 캐리 플래그 체인 (modifiesFlags/dependsOnFlags로
#                           APSR 생명주기를 솔버 의존성으로 명시 = 로드맵 3단계 항목)
# M85 모델(cortex_m85r1): SCALAR 유닛, umull/umaal 레이턴시 2·스루풋 1, add류 1.
# 멱등: 이미 패치돼 있으면 건너뜀.
#
# 사용법(WSL): python3 patch_slothy_v81m.py [slothy_repo_path]

import sys

REPO = sys.argv[1] if len(sys.argv) > 1 else "/home/cnscjs1395/slothy"
ARCH = REPO + "/slothy/targets/arm_v81m/arch_v81m.py"
M85 = REPO + "/slothy/targets/arm_v81m/cortex_m85r1.py"

ARCH_ADD = '''

# ---- 2-stream stitching extension (X25519 carry arithmetic) ----
# Added by patch_slothy_v81m.py (A주제 기여 ③). Flag lifecycle is modeled via
# modifiesFlags/dependsOnFlags so the solver preserves carry-chain legality.


class umull(MVEInstruction):
    pattern = "umull <RdLo>, <RdHi>, <Rn>, <Rm>"
    inputs = ["Rn", "Rm"]
    outputs = ["RdLo", "RdHi"]


class umaal(MVEInstruction):
    pattern = "umaal <RdLo>, <RdHi>, <Rn>, <Rm>"
    inputs = ["Rn", "Rm"]
    in_outs = ["RdLo", "RdHi"]


class adds(MVEInstruction):
    pattern = "adds <Rd>, <Rn>, <Rm>"
    inputs = ["Rn", "Rm"]
    outputs = ["Rd"]
    modifiesFlags = True


class adcs(MVEInstruction):
    pattern = "adcs <Rd>, <Rn>, <Rm>"
    inputs = ["Rn", "Rm"]
    outputs = ["Rd"]
    modifiesFlags = True
    dependsOnFlags = True


class adc(MVEInstruction):
    pattern = "adc <Rd>, <Rn>, <Rm>"
    inputs = ["Rn", "Rm"]
    outputs = ["Rd"]
    dependsOnFlags = True


class eor_imm(MVEInstruction):
    pattern = "eor <Rd>, <Rn>, <imm>"
    inputs = ["Rn"]
    outputs = ["Rd"]


class umlal(MVEInstruction):
    pattern = "umlal <RdLo>, <RdHi>, <Rn>, <Rm>"
    inputs = ["Rn", "Rm"]
    in_outs = ["RdLo", "RdHi"]


class lsll_imm(MVEInstruction):
    pattern = "lsll <RdLo>, <RdHi>, <imm>"
    in_outs = ["RdLo", "RdHi"]


class lsrl_imm(MVEInstruction):
    pattern = "lsrl <RdLo>, <RdHi>, <imm>"
    in_outs = ["RdLo", "RdHi"]


class lsls_imm(MVEInstruction):
    pattern = "lsls <Rd>, <Rn>, <imm>"
    inputs = ["Rn"]
    outputs = ["Rd"]
    modifiesFlags = True


class movs_imm(MVEInstruction):
    pattern = "movs <Rd>, <imm>"
    outputs = ["Rd"]
    modifiesFlags = True


class bic_imm(MVEInstruction):
    pattern = "bic <Rd>, <Rn>, <imm>"
    inputs = ["Rn"]
    outputs = ["Rd"]


class adc_shifted(MVEInstruction):
    pattern = "adc <Rd>, <Rn>, <Rm>, <barrel> <imm>"
    inputs = ["Rn", "Rm"]
    outputs = ["Rd"]
    dependsOnFlags = True


class lsrs_imm(MVEInstruction):
    pattern = "lsrs <Rd>, <Rn>, <imm>"
    inputs = ["Rn"]
    outputs = ["Rd"]
    modifiesFlags = True


class adds_imm(MVEInstruction):
    pattern = "adds <Rd>, <Rn>, <imm>"
    inputs = ["Rn"]
    outputs = ["Rd"]
    modifiesFlags = True


class adcs_imm(MVEInstruction):
    pattern = "adcs <Rd>, <Rn>, <imm>"
    inputs = ["Rn"]
    outputs = ["Rd"]
    modifiesFlags = True
    dependsOnFlags = True


class adc_imm(MVEInstruction):
    pattern = "adc <Rd>, <Rn>, <imm>"
    inputs = ["Rn"]
    outputs = ["Rd"]
    dependsOnFlags = True
'''

M85_IMPORT = ("from slothy.targets.arm_v81m.arch_v81m import "
              "umull, umaal, adds, adcs, adc, adds_imm, adcs_imm, adc_imm, eor_imm, "
              "umlal, lsll_imm, lsrl_imm, lsls_imm, movs_imm, lsrs_imm, adc_shifted, bic_imm  # 2-stream ext\n")

M85_UNITS = """    eor_imm: ExecutionUnit.SCALAR,
    umlal: ExecutionUnit.SCALAR,
    lsll_imm: ExecutionUnit.SCALAR,
    lsrl_imm: ExecutionUnit.SCALAR,
    lsls_imm: ExecutionUnit.SCALAR,
    movs_imm: ExecutionUnit.SCALAR,
    lsrs_imm: ExecutionUnit.SCALAR,
    adc_shifted: ExecutionUnit.SCALAR,
    bic_imm: ExecutionUnit.SCALAR,
    umull: ExecutionUnit.SCALAR,
    umaal: ExecutionUnit.SCALAR,
    adds: ExecutionUnit.SCALAR,
    adds_imm: ExecutionUnit.SCALAR,
    adcs_imm: ExecutionUnit.SCALAR,
    adc_imm: ExecutionUnit.SCALAR,
    adcs: ExecutionUnit.SCALAR,
    adc: ExecutionUnit.SCALAR,
"""

M85_TP = """    (umull, umaal, umlal): 1,
    (adds, adcs, adc, adds_imm, adcs_imm, adc_imm, eor_imm, adc_shifted, bic_imm): 1,
    (lsll_imm, lsrl_imm, lsls_imm, movs_imm, lsrs_imm): 1,
"""

M85_LAT = """    (umull, umaal, umlal): 2,
    (adds, adcs, adc, adds_imm, adcs_imm, adc_imm, eor_imm, adc_shifted, bic_imm): 1,
    (lsll_imm, lsrl_imm, lsls_imm, movs_imm, lsrs_imm): 1,
"""


def patch(path, marker, transform):
    src = open(path, encoding="utf-8").read()
    if marker in src:
        print(f"skip (already patched): {path}")
        return
    open(path, "w", encoding="utf-8").write(transform(src))
    print(f"patched: {path}")


# 주의: arch_v81m.py 끝의 `Instruction.all_subclass_leaves = ...`가 파서용 클래스
# 목록을 캐시하므로, 새 클래스는 반드시 그 '앞'에 삽입해야 한다 (뒤에 붙이면 파서 미등록).
CACHE_LINE = "Instruction.all_subclass_leaves = all_subclass_leaves(Instruction)"
BLOCK_START = "# >>> 2-stream-ext >>>"
BLOCK_END = "# <<< 2-stream-ext <<<\n"


def arch_transform(s):
    # 이전 삽입(끝에 붙었든, 마커 블록이든) 제거 → 캐시 라인 앞에 재삽입 (멱등)
    b = s.find(BLOCK_START)
    if b != -1:
        e = s.find(BLOCK_END, b)
        s = s[:b] + s[e + len(BLOCK_END):]
    legacy = s.find("# ---- 2-stream stitching extension")
    if legacy != -1 and legacy > s.find(CACHE_LINE):   # 구버전: 파일 끝 잘못 삽입분
        s = s[:legacy].rstrip() + "\n"
    assert CACHE_LINE in s
    return s.replace(CACHE_LINE,
                     BLOCK_START + ARCH_ADD + "\n" + BLOCK_END + "\n" + CACHE_LINE)


src_now = open(ARCH, encoding="utf-8").read()
open(ARCH, "w", encoding="utf-8").write(arch_transform(src_now))
print(f"patched: {ARCH}")

def m85_transform(s):
    lines = s.splitlines(keepends=True)
    out, done_imp = [], False
    for ln in lines:
        out.append(ln)
        if not done_imp and ln.startswith("from slothy.targets.arm_v81m.arch_v81m import"):
            # 기존 멀티라인 import 블록 앞이 아닌, 첫 import문 '이전'에 별도 문장 삽입 불가 →
            # import 블록 시작 직전에 우리 한 줄 import를 둔다
            out.insert(-1, M85_IMPORT)
            done_imp = True
        elif ln.startswith("execution_units = {"):
            out.append(M85_UNITS)
        elif ln.startswith("inverse_throughput = {"):
            out.append(M85_TP)
        elif ln.startswith("default_latencies = {"):
            out.append(M85_LAT)
    return "".join(out)

patch(M85, "umaal: ExecutionUnit.SCALAR", m85_transform)


# ---- v0.2: 스칼라 듀얼이슈 모델링 ----
# 상류 모델은 issue_rate=1 (MVE 벡터 중심이라 스칼라 듀얼이슈 미구현).
# 보드 실측(IPC 1.99, 2026-08-16)과 배치 → 이슈 폭 2 + 제2 스칼라 슬롯 추가.
# 근사: ALU류는 두 슬롯 중 아무 데나, MAC(umull/umaal/mul)·LSU는 기존 유닛 유지.
# ⚠ 페어링 세부(TRM)는 미보정 — 보드 실측이 최종 진실, 모델은 스케줄 탐색용.
DUAL_MARK = "# 2-stream ext: scalar dual-issue"
DUAL_BLOCK = f"""
{DUAL_MARK}
_scalar_alu_alt = [
    nop, mov_imm, mvn_imm, mov, add, add_shifted, log_and, log_and_shifted,
    orr, orr_shifted, eor, eor_shifted, bic, bic_shifted, ror, ror_imm,
    ror_short, cmp_reg, cmp_imm, sub, add_imm, orr_imm, sub_imm,
    adds, adcs, adc, adds_imm, adcs_imm, adc_imm, eor_imm,
    lsls_imm, movs_imm, lsrs_imm, adc_shifted, bic_imm,
]
for _c in _scalar_alu_alt:
    execution_units[_c] = [ExecutionUnit.SCALAR, ExecutionUnit.SCALAR2]
"""


def dual_transform(s):
    assert "issue_rate = 1" in s
    s = s.replace("issue_rate = 1", "issue_rate = 2  # 2-stream ext (was 1)")
    s = s.replace("    SCALAR = (0,)", "    SCALAR = (0,)\n    SCALAR2 = (7,)")
    anchor = "inverse_throughput = {"
    s = s.replace(anchor, DUAL_BLOCK + "\n" + anchor)
    return s


patch(M85, DUAL_MARK, dual_transform)


# ---- v0.3: MAC 누산기 포워딩 (MVE 페어링 모델 1차) ----
# 실리콘 근거(2026-08-17 실험 F): 의존 umaal 체인 611명령 = 611cyc → 누산기(in_out)
# 의존은 레이턴시 1로 포워딩. Rn/Rm 피연산자 의존은 기본 2 유지.
# 이게 없으면 솔버가 MAC 체인을 2cyc/instr로 과대평가 → 코이슈 균형을 잘못 잡음.
FWD_MARK = "# 2-stream ext v0.3: MAC accumulator forwarding"
FWD_BLOCK = f"""
    {FWD_MARK}
    # (silicon: 611 dependent umaal = 611 cyc, M85 2026-08-17)
    if instclass_src in [umaal, umlal, umull] and instclass_dst in [umaal, umlal]:
        _srcs = src.args_out + src.args_in_out
        if any(r in dst.args_in_out for r in _srcs) and \\
                not any(r in dst.args_in for r in _srcs):
            return 1
"""


def fwd_transform(s):
    anchor = "    #\n    # Check for latency exceptions\n    #\n"
    assert anchor in s
    return s.replace(anchor, anchor + FWD_BLOCK, 1)


patch(M85, FWD_MARK, fwd_transform)


# ---- v0.4: 벡터 스토어의 스칼라 슬롯 점유 (페어링 스펙트럼 실측) ----
# 실리콘 근거(실험 N, 2026-08-17): umaal×vstrw 지퍼 1,839 = 1,222+617(완전 차단)
# vs veor/vldrw/rot 지퍼는 99% 은닉. → vstrw는 STORE + SCALAR 슬롯 동시 점유.
# (SCALAR2·ALU와의 페어링은 미측정 — umaal(SCALAR)만 실증. exp_f의 노출
#  242cyc = vstrw 121개×2 정확 일치.)
V04_MARK = "# 2-stream ext v0.4: vector store blocks scalar slot"
V04_BLOCK = f"""
{V04_MARK}
for _c in [vstrw, vstrw_no_imm, vstrw_with_writeback, vstrw_with_post,
           vstrb, vstrb_no_imm, vstrb_with_writeback, vstrb_with_post]:
    execution_units[_c] = [[ExecutionUnit.STORE, ExecutionUnit.SCALAR]]
"""


def v04_transform(s):
    anchor = "inverse_throughput = {"
    return s.replace(anchor, V04_BLOCK + "\n" + anchor, 1)


patch(M85, V04_MARK, v04_transform)
print("done")


# ---- v0.5: 벡터 베이스 개더/스캐터 (b1 경로) ----
# 실제 U 조각(fiat_mul_u4_p0)은 `vldrw.u32 Qd, [Qn, #imm]` / `vstrw.u32 Qd, [Qn, #imm]`
# 형태를 쓴다(q7 = 개더 베이스). 상류 모델에는 스칼라 베이스 + 벡터 오프셋
# (vldrw_gather) 만 있고 이 순수 벡터 베이스 형태가 없어 파서가 거부한다.
# 자원 배정은 상류 vldrw_gather(LOAD)와 v0.4 규칙(스토어는 스칼라 슬롯 차단)을 따른다.
# ⚠ 개더/스캐터의 실제 처리율·지연은 이 보드에서 미측정 — 모델 근사이며 판정은 보드가 한다.
V05_ARCH_MARK = "# >>> 2-stream-ext-v05 >>>"
V05_ARCH = f'''
{V05_ARCH_MARK}


class vldrw_gather_base(MVEInstruction):
    pattern = "vldrw.<dt> <Qd>, [<Qn>, <imm>]"
    inputs = ["Qn"]
    outputs = ["Qd"]


class vstrw_scatter_base(MVEInstruction):
    pattern = "vstrw.<dt> <Qd>, [<Qn>, <imm>]"
    inputs = ["Qd", "Qn"]


# <<< 2-stream-ext-v05 <<<
'''


def v05_arch_transform(s):
    assert CACHE_LINE in s
    return s.replace(CACHE_LINE, V05_ARCH + "\n" + CACHE_LINE)


patch(ARCH, V05_ARCH_MARK, v05_arch_transform)

V05_M85_MARK = "# 2-stream ext v0.5: vector-base gather/scatter"
V05_M85 = f"""
{V05_M85_MARK}
from slothy.targets.arm_v81m.arch_v81m import (vldrw_gather_base,
                                               vstrw_scatter_base)
execution_units[vldrw_gather_base] = ExecutionUnit.LOAD
execution_units[vstrw_scatter_base] = [[ExecutionUnit.STORE, ExecutionUnit.SCALAR]]
inverse_throughput[vldrw_gather_base] = 2
inverse_throughput[vstrw_scatter_base] = 2
default_latencies[vldrw_gather_base] = 3
default_latencies[vstrw_scatter_base] = 1
"""


def v05_m85_transform(s):
    anchor = "\nclass Target"
    if anchor in s:
        return s.replace(anchor, "\n" + V05_M85 + anchor, 1)
    return s.rstrip() + "\n" + V05_M85


patch(M85, V05_M85_MARK, v05_m85_transform)
print("v0.5 done")


# ---- v0.6: v0.5 개더/스캐터를 메모리 명령으로 등록 ----
# v0.5 는 파서만 통과시켰고 클래스를 arch 의 is_load_store_instruction /
# is_vector_load / is_vector_store 목록에 넣지 않았다. 그 결과 SLOTHY 가 이 명령들을
# 메모리 접근으로 보지 않아 같은 Keccak 상태 워드에 대한 적재/저장을 자유롭게 재배치했고,
# 보드에서 상태 32바이트가 틀렸다(expCS run1, mismatch=6400).
# 상류 목록은 메서드 본문에 하드코딩돼 있으므로 서브클래스에서 메서드를 재정의한다.
V06_MARK = "# >>> 2-stream-ext-v06 >>>"
V06_ARCH = f'''
{V06_MARK}


def _v06_gather_make(cls, src):
    obj = MVEInstruction.build(cls, src)
    obj.increment = None
    obj.pre_index = obj.immediate
    obj.addr = obj.args_in[0]
    return obj


def _v06_scatter_make(cls, src):
    obj = MVEInstruction.build(cls, src)
    obj.increment = None
    obj.pre_index = obj.immediate
    obj.addr = obj.args_in[1]
    return obj


vldrw_gather_base.make = classmethod(_v06_gather_make)
vstrw_scatter_base.make = classmethod(_v06_scatter_make)
vldrw_gather_base.is_load_store_instruction = lambda self: True
vstrw_scatter_base.is_load_store_instruction = lambda self: True
vldrw_gather_base.is_vector_load = lambda self: True
vstrw_scatter_base.is_vector_load = lambda self: False
vldrw_gather_base.is_vector_store = lambda self: False
vstrw_scatter_base.is_vector_store = lambda self: True
vldrw_gather_base.is_load = lambda self: True
vstrw_scatter_base.is_load = lambda self: False
vldrw_gather_base.is_scalar_load = lambda self: False
vstrw_scatter_base.is_scalar_load = lambda self: False


# <<< 2-stream-ext-v06 <<<
'''


def v06_transform(s):
    assert CACHE_LINE in s
    return s.replace(CACHE_LINE, V06_ARCH + "\n" + CACHE_LINE)


patch(ARCH, V06_MARK, v06_transform)
print("v0.6 done")
