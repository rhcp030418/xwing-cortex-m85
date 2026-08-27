# EK-RA8M1 자동 회수: J-Link로 굽고 → 실행 → RAM 로그 버퍼를 읽어 출력
#
# 사용법 (Windows, e2 studio는 반드시 닫은 상태 — J-Link는 단일 클라이언트):
#   py harvest_ra8m1.py
#
# 동작: blinky.srec 플래시 → 리셋·실행 → harness_done 폴링 → log_buf 덤프.
# UART/RTT 불필요 (harness.c가 RAM에 로그를 쌓고, 여기서 심볼 주소로 읽는다).
# 심볼 주소는 매번 ELF에서 nm으로 다시 뽑으므로 코드가 바뀌어도 그대로 재사용.

import subprocess
import sys
import time
import re

import pylink

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

WS = r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug"
ELF = WS + r"\blinky.elf"
SREC = WS + r"\blinky.srec"
NM = r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe"
DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
DEVICE = "R7FA8M1AH"  # J-Link 디바이스명은 패키지 접미사(ECBD) 없음

SYMS = ("harness_done", "harness_fails", "log_len", "log_buf", "rep_cyc")
REP_N = 100
SLOT_N = 193


def sym_addrs():
    addrs = {}
    for line in subprocess.check_output([NM, ELF], text=True).splitlines():
        parts = line.split()
        if len(parts) == 3 and parts[2] in SYMS:
            addrs[parts[2]] = int(parts[0], 16)
    missing = set(SYMS) - set(addrs)
    if missing:
        sys.exit(f"ELF에 심볼 없음: {missing} (빌드가 하네스를 포함했는지 확인)")
    return addrs


def main():
    a = sym_addrs()
    jlink = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jlink.open()
    jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jlink.connect(DEVICE, speed=4000)
    print(f"connected: {jlink.core_name()}")

    jlink.reset(halt=True)
    jlink.exec_command("SetSkipProgOnCRCMatch = 0")   # RAMCode CRC 타임아웃 회피 (2026-08-16)
    jlink.exec_command("SetVerifyDownload = 0")
    jlink.flash_file(SREC, 0x0)
    jlink.reset(ms=10, halt=False)  # 리셋 후 자유 실행

    for _ in range(800):  # 실험 U 23슬롯 추가: 최대 80초 대기
        time.sleep(0.1)
        if jlink.memory_read32(a["harness_done"], 1)[0] == 1:
            break
    else:
        sys.exit("timeout: harness_done이 1이 안 됨 (하드폴트 가능성 — 디버거로 확인)")

    n = min(jlink.memory_read32(a["log_len"], 1)[0], 8191)
    log = bytes(jlink.memory_read8(a["log_buf"], n)).decode("utf-8", "replace")
    fails = jlink.memory_read32(a["harness_fails"], 1)[0]
    reps = jlink.memory_read32(a["rep_cyc"], SLOT_N * REP_N)
    jlink.close()

    print(log)

    # 계획서 §6.2: N=100 중앙값 채택, 최소/최대 병기 (calib = 측정 오버헤드, 차감용)
    calib = sorted(reps[2 * REP_N:3 * REP_N])[REP_N // 2]
    meds = {}
    for idx, name in ((0, "keccak-f1600"), (1, "x25519-scalarmult"),
                      (3, "mlkem768-keygen"), (4, "mlkem768-encaps"),
                      (5, "mlkem768-decaps"), (6, "combiner-sha3-134B"),
                      (7, "stitch-A-mulchain"), (8, "stitch-B-logicchain"),
                      (9, "stitch-S-interleaved"),
                      (10, "stitch-Bm-memchain"), (11, "stitch-Sm-interleaved-mem"),
                      (12, "mul256-full-x100"), (13, "mul256-budget-x100"),
                      (14, "mul256-flat-x100"), (15, "theta-frag-x100"),
                      (16, "stitched-x100"),
                      (17, "round-frag-x100"), (18, "stitched-round-x100"),
                      (19, "mul256-flat6-x100"), (20, "round6-frag-x100"),
                      (21, "stitched-round6-x100"), (22, "stitched-k2-x100"),
                      (23, "slothy-seq-x1000"), (24, "slothy-opt-x1000"),
                      (25, "bmid-seq-x1000"), (26, "bmid-zip-x1000"),
                      (27, "bmid-slothy-x1000"),
                      (28, "bfull-seq-x1000"), (29, "bfull-zip-x1000"),
                      (30, "bfull-slothy-x1000"),
                      (31, "expc-seq-x1000"), (32, "expc-slothy-x1000"),
                      (33, "expd-seq-x1000"), (34, "expd-slothy-x1000"),
                      (35, "expe-seq-x1000"), (36, "expe-slothy-x1000"),
                      (37, "mve4-round-x1000"),
                      (38, "coissue-A-x1000"), (39, "coissue-zip-x1000"),
                      (40, "coissue-slothy-x1000"),
                      (41, "mve3-round-x1000"), (42, "coissue3-zip-x1000"),
                      (43, "glue-roundtrip-x1000"),
                      (44, "fiat-base-x100"), (45, "fiat-yield3-x100"),
                      (46, "mve2-round-x1000"), (47, "coissue2-zip-x1000"),
                      (48, "fiat-yield2-x100"),
                      (49, "expj-seq-x1000"), (50, "expj-stitch-x1000"),
                      (51, "expk-seq-x1000"), (52, "expk-coarse-x1000"),
                      (53, "expk-stitch-x1000"),
                      (54, "expl-ntt-x1000"), (55, "expl-zip-x1000"),
                      (56, "expl-sntt-x1000"), (57, "expl-szip-x1000"),
                      (58, "expj-stitch-alt-x1000"),
                      (59, "expm-seq-x1000"), (60, "expm-stitch-x1000"),
                      (61, "expm4-seq-x1000"), (62, "expm4-stitch-x1000"),
                      (63, "pairn-veor-x1000"), (64, "pairn-veor-zip-x1000"),
                      (65, "pairn-ldr-x1000"), (66, "pairn-ldr-zip-x1000"),
                      (67, "pairn-str-x1000"), (68, "pairn-str-zip-x1000"),
                      (69, "pairn-rot-x1000"), (70, "pairn-rot-zip-x1000"),
                      (71, "coissue-slothy2-x1000"),
                      (72, "pairn2-ldr-x1000"), (73, "pairn2-str-x1000"),
                      (74, "pairn2-rot-x1000"),
                      (75, "pairn-lsmix-x1000"), (76, "pairn-lsmix-zip-x1000"),
                      (77, "pairp-vec-x1000"),
                      (78, "pairp-s0-x1000"), (79, "pairp-s0-zip-x1000"),
                      (80, "pairp-s1-x1000"), (81, "pairp-s1-zip-x1000"),
                      (82, "pairp-s2-x1000"), (83, "pairp-s2-zip-x1000"),
                      (84, "pairp-s3-x1000"), (85, "pairp-s3-zip-x1000"),
                      (86, "expj-a-x1000"), (87, "expj-b-x1000"),
                      (88, "expj-loop-x1000"),
                      (89, "expq-b-x1000"), (90, "expq-stitch-x1000"),
                      (91, "expq-seq-x1000"),
                      (92, "expj-stitch2-x1000"),
                      (93, "expq-stitch2-x1000"),
                      (94, "expm-stitch2-x1000"),
                      (95, "expm4-stitch2-x1000"),
                      (96, "expt-fiat-x1000"), (97, "expt-b0-x1000"),
                      (98, "expt-seq-x1000"), (99, "expt-stitch-x1000"),
                      (100, "expt-m8-seq-x1000"), (101, "expt-m8-stitch-x1000"),
                      (102, "expt-m4-seq-x1000"), (103, "expt-m4-stitch-x1000"),
                      (104, "expu-y10-x1000"), (105, "expu-y11-x1000"),
                      (106, "expu-lo10-b1-x1000"),
                      (107, "expu-lo10-seq-x1000"), (108, "expu-lo10-stitch-x1000"),
                      (109, "expu-lo10-m4-seq-x1000"), (110, "expu-lo10-m4-stitch-x1000"),
                      (111, "expu-lo10-m8-seq-x1000"), (112, "expu-lo10-m8-stitch-x1000"),
                      (113, "expu-lo11-b1-x1000"),
                      (114, "expu-lo11-seq-x1000"), (115, "expu-lo11-stitch-x1000"),
                      (116, "expu-lo11-m4-seq-x1000"), (117, "expu-lo11-m4-stitch-x1000"),
                      (118, "expu-lo11-m8-seq-x1000"), (119, "expu-lo11-m8-stitch-x1000"),
                      (120, "expu-hi11-b1-x1000"),
                      (121, "expu-hi11-seq-x1000"), (122, "expu-hi11-stitch-x1000"),
                      (123, "expu-hi11-m4-seq-x1000"), (124, "expu-hi11-m4-stitch-x1000"),
                      (125, "expu-hi11-m8-seq-x1000"), (126, "expu-hi11-m8-stitch-x1000"),
                      (127, "expv-ntt-x1000"), (128, "expv-invntt-x1000"),
                      (129, "expw-fwd-l1222-x1000"),
                      (130, "expw-fwd-l1222-vld4-x1000"),
                      (131, "expw-fwd-l232-size-x1000"),
                      (132, "expw-fwd-l232-speed-x1000"),
                      (134, "expw-rev4-x1000"),
                      (135, "expw-inv-m85-wip-x1000"),
                      (136, "expx-mlkem-keygen"),
                      (137, "expx-mlkem-encaps"),
                      (138, "expx-mlkem-decaps"),
                      (139, "expx-ba-candidate-keygen"),
                      (140, "expx-ba-candidate-encaps"),
                      (141, "expx-ba-candidate-decaps"),
                      (142, "expx-ba-baseline-keygen"),
                      (143, "expx-ba-baseline-encaps"),
                      (144, "expx-ba-baseline-decaps"),
                      (145, "expy-ab-baseline-keygen"),
                      (146, "expy-ab-baseline-encaps"),
                      (147, "expy-ab-baseline-decaps"),
                      (148, "expy-ab-candidate-keygen"),
                      (149, "expy-ab-candidate-encaps"),
                      (150, "expy-ab-candidate-decaps"),
                      (151, "expy-ba-candidate-keygen"),
                      (152, "expy-ba-candidate-encaps"),
                      (153, "expy-ba-candidate-decaps"),
                      (154, "expy-ba-baseline-keygen"),
                      (155, "expy-ba-baseline-encaps"),
                      (156, "expy-ba-baseline-decaps"),
                      (157, "expz-ab-baseline-keygen"),
                      (158, "expz-ab-baseline-encaps"),
                      (159, "expz-ab-baseline-decaps"),
                      (160, "expz-ab-candidate-keygen"),
                      (161, "expz-ab-candidate-encaps"),
                      (162, "expz-ab-candidate-decaps"),
                      (163, "expz-ba-candidate-keygen"),
                      (164, "expz-ba-candidate-encaps"),
                      (165, "expz-ba-candidate-decaps"),
                      (166, "expz-ba-baseline-keygen"),
                      (167, "expz-ba-baseline-encaps"),
                      (168, "expz-ba-baseline-decaps"),
                      (169, "expaa-ab-baseline-keygen"),
                      (170, "expaa-ab-baseline-encaps"),
                      (171, "expaa-ab-baseline-decaps"),
                      (172, "expaa-ab-candidate-keygen"),
                      (173, "expaa-ab-candidate-encaps"),
                      (174, "expaa-ab-candidate-decaps"),
                      (175, "expaa-ba-candidate-keygen"),
                      (176, "expaa-ba-candidate-encaps"),
                      (177, "expaa-ba-candidate-decaps"),
                      (178, "expaa-ba-baseline-keygen"),
                      (179, "expaa-ba-baseline-encaps"),
                      (180, "expaa-ba-baseline-decaps"),
                      (181, "expab-ab-baseline-keygen"),
                      (182, "expab-ab-baseline-encaps"),
                      (183, "expab-ab-baseline-decaps"),
                      (184, "expab-ab-candidate-keygen"),
                      (185, "expab-ab-candidate-encaps"),
                      (186, "expab-ab-candidate-decaps"),
                      (187, "expab-ba-candidate-keygen"),
                      (188, "expab-ba-candidate-encaps"),
                      (189, "expab-ba-candidate-decaps"),
                      (190, "expab-ba-baseline-keygen"),
                      (191, "expab-ba-baseline-encaps"),
                      (192, "expab-ba-baseline-decaps")):
        vals = sorted(reps[idx * REP_N:(idx + 1) * REP_N])
        med = vals[REP_N // 2]
        meds[name] = med - calib
        print(f"[N={REP_N}] {name}: median={med} (calib {calib} 차감시 {med - calib})"
              f"  min={vals[0]}  max={vals[-1]}")


    # 실험 P — DTCM 뱅크 스펙트럼: 뱅크에 따라 zip 사이클이 변하는가?
    v = meds.get("pairp-vec-x1000")
    if v:
        print("")
        print("[exp P] DTCM 뱅크 스펙트럼 (MVE 단독 vec=%d)" % v)
        hid = []
        for b in range(4):
            a_, z = meds.get(f"pairp-s{b}-x1000"), meds.get(f"pairp-s{b}-zip-x1000")
            if not (a_ and z):
                continue
            h = (a_ + v - z) / min(a_, v) * 100   # 짧은 스트림의 몇 %를 은닉했나
            hid.append(h)
            print(f"  bank {b}: scalar={a_} zip={z}  순차합={a_ + v}  은닉 {h:.1f}%")
        if len(hid) == 4:
            spread = max(hid) - min(hid)
            print(f"  -> 은닉률 폭 {spread:.1f}%p  "
                  + ("뱅크 충돌이 원인의 일부 (레이아웃으로 회수 가능)"
                     if spread >= 3 else "평평 = 순수 LSU 경합 (음성 결과)"))

    # 실험 J-solo — 은닉률 분모 min(A,B) 실측 + 노출 사이클 분해
    ja, jb, jl = (meds.get("expj-a-x1000"), meds.get("expj-b-x1000"),
                  meds.get("expj-loop-x1000"))
    js, jz = meds.get("expj-seq-x1000"), meds.get("expj-stitch-x1000")
    if ja and jb and js and jz:
        jl = jl or 0
        a0, b0 = ja - jl, jb - jl          # 래퍼 루프 비용 차감 = 순수 스트림 비용
        seq_pred = a0 + b0 + jl            # 두 본문 + 루프 1회분
        saved = js - jz
        print("")
        print(f"[exp J-solo] A(fiat+LOADP)={a0/1000:.1f} B(MVE라운드)={b0/1000:.1f} "
              f"래퍼루프={jl/1000:.1f} cyc/iter")
        print(f"  순차 예측={seq_pred/1000:.1f} vs 실측 expj_seq={js/1000:.1f} "
              f"(오차 {(js - seq_pred)/1000:+.1f} cyc = 검산)")
        print(f"  절감={saved/1000:.1f}  은닉={saved / min(a0, b0) * 100:.1f}% "
              f"(분모 min(A,B)={min(a0, b0)/1000:.1f})")
        print(f"  노출={(min(a0, b0) - saved)/1000:.1f} cyc "
              f"= 짧은 쪽에서 숨지 못한 사이클")

    # 실험 Q — vstrw 없는 B' 로 노출 223 분해 (사전 등록 판정식, 측정 후 변경 금지)
    qb, qz, qs = (meds.get("expq-b-x1000"), meds.get("expq-stitch-x1000"),
                  meds.get("expq-seq-x1000"))
    if qb and qz and ja and jb:
        jl = jl or 0
        a0 = ja - jl
        qb0 = qb - jl
        # 노출 정의는 J 와 문자 그대로 같게: min(A,B) - 절감. (qb/jb 는 래퍼 루프를
        # 이미 1회 포함하므로 jl 을 또 빼면 안 된다 — 2026-08-21 산술 정정)
        saved_q = (qs - qz) if qs else 0
        expo_q = (min(a0, qb0) - saved_q) / 1000.0
        expo_j = (min(a0, jb - jl) - (js - jz)) / 1000.0 if (js and jz) else float("nan")
        print("")
        print("[exp Q] vstrw-free B' (측정 전용, 기능 등가 아님 -> KAT 대상 아님)")
        print(f"  B'_solo={qb0/1000:.1f} vs B_solo={(jb - jl)/1000:.1f} "
              f"(치환 편차 {(qb - jb)/1000:+.1f} cyc)")
        if qs:
            print(f"  순차 예측={(a0 + qb0 + jl)/1000:.1f} vs 실측 expq_seq={qs/1000:.1f} "
                  f"(오차 {(qs - a0 - qb0 - jl)/1000:+.1f} cyc = 검산)")
        print(f"  zip'={qz/1000:.1f} 절감'={saved_q/1000:.1f}  ->  노출'={expo_q:.1f} cyc "
              f"(J 노출={expo_j:.1f})")
        print(f"  교차검산: zip'-B'_raw={(qz - qb)/1000:.1f} (노출'과 일치해야 함)")
        print(f"  => ⓐ vstrw 차단 기여 = {expo_j - expo_q:.1f} cyc "
              f"(121개 x {(expo_j - expo_q)/121:.2f} cyc/개, 33차 모델은 x2.00 예측)")
        print(f"  => 잔여 = {expo_q:.1f} cyc  vs  ⓑ 예측(스칼라 로드 157개) = 157")
        if expo_q <= 20:
            v = "(1) 채택: ⓐ vstrw 차단이 223 의 사실상 전부"
        elif 140 <= expo_q <= 175:
            v = "(2) 채택: ⓑ 스칼라 로드 157 단독으로 설명 — ⓐ 기여는 중첩되어 0"
        elif expo_q > 175:
            v = "(3) 채택: 제3 항 지배 — A 자기-듀얼이슈(1.61 IPC) 상실 = '차단' 아닌 '슬롯 부족'"
        else:
            v = "사전 등록 어느 가지에도 안 들어감 (20 < 노출' < 140) — 미분류로 기록할 것"
        print("  판정: " + v)

    # 실험 R — A 명령을 두 개씩 인접 배치해 자기 듀얼이슈 상실 가설을 검증한다.
    j2, q2 = meds.get("expj-stitch2-x1000"), meds.get("expq-stitch2-x1000")
    if j2 and q2 and js and jz and qb and qs and qz and ja:
        jl = jl or 0
        a0 = ja - jl
        expo_q1 = min(a0, qb - jl) - (qs - qz)
        expo_q2 = min(a0, qb - jl) - (qs - q2)
        recovered = expo_q1 - expo_q2
        frac = recovered / expo_q1
        if frac >= 0.5:
            verdict = "강한 지지: 잔여 노출의 절반 이상 회수"
        elif frac >= 0.1:
            verdict = "부분 지지: 잔여 노출의 10~50% 회수"
        elif frac > -0.1:
            verdict = "효과 없음: 변화가 잔여 노출의 ±10% 이내"
        else:
            verdict = "반증/악화: 노출이 10% 이상 증가"
        print("")
        print("[exp R] A-pair zipper (A 두 명령 인접, A/B 명령 수와 순서 불변)")
        print(f"  J: 1:1={jz/1000:.1f} -> pair={j2/1000:.1f} cyc/iter "
              f"(추가 절감={(jz-j2)/1000:.1f})")
        print(f"  Q: 1:1 노출={expo_q1/1000:.1f} -> pair 노출={expo_q2/1000:.1f} cyc "
              f"(회수={recovered/1000:.1f}, {frac*100:.1f}%)")
        print("  사전등록 판정: " + verdict)

    # 실험 S — 실제 8:1/4:1 매크로 비율에서도 A-pair 배치가 이득인지 확인한다.
    m8p, m4p = meds.get("expm-stitch2-x1000"), meds.get("expm4-stitch2-x1000")
    if m8p and m4p:
        print("")
        print("[exp S] 실제 비율 A-pair zipper")
        for label, old, new in (("8:1 encaps", meds.get("expm-stitch-x1000"), m8p),
                                ("4:1 keygen/decaps", meds.get("expm4-stitch-x1000"), m4p)):
            delta = (old - new) / old * 100
            verdict = "개선" if delta >= 1 else ("악화" if delta <= -1 else "실질 차이 없음")
            print(f"  {label}: 기존={old/1000:.1f} pair={new/1000:.1f} cyc "
                  f"(변화={delta:+.2f}%) -> {verdict}")

    # 실험 T — b0 + GP 무양보 fiat: 단독 세금, 교차 이득, 기존 b2+yield2 대비를 분리한다.
    tf, tb = meds.get("expt-fiat-x1000"), meds.get("expt-b0-x1000")
    if tf and tb:
        print("")
        print("[exp T] b0 + GP 무양보 fiat (-fno-tree-slp-vectorize, -ffixed 없음)")
        fb = meds.get("fiat-base-x100", 0) / 100
        m2 = meds.get("mve2-round-x1000", 0) / 1000
        print(f"  단독 fiat={tf/1000:.1f} vs 일반 base={fb:.1f} cyc "
              f"(SLP 제거 비용={(tf/1000-fb)/fb*100:+.2f}%)")
        print(f"  단독 b0={tb/1000:.1f} vs 기존 b2={m2:.1f} cyc "
              f"(개더/scatter 비용={(tb/1000-m2)/m2*100:+.2f}%)")
        rows = (
            ("1:1", "expt-seq-x1000", "expt-stitch-x1000", "expj-stitch-x1000"),
            ("8:1", "expt-m8-seq-x1000", "expt-m8-stitch-x1000", "expm-stitch-x1000"),
            ("4:1", "expt-m4-seq-x1000", "expt-m4-stitch-x1000", "expm4-stitch-x1000"),
        )
        for label, sk, zk, oldk in rows:
            seq, zipped, old = meds.get(sk), meds.get(zk), meds.get(oldk)
            if not (seq and zipped and old):
                continue
            stitch_gain = (seq - zipped) / seq * 100
            vs_old = (old - zipped) / old * 100
            if vs_old >= 5:
                verdict = "강한 개선"
            elif vs_old >= 1:
                verdict = "작은 개선"
            elif vs_old > -1:
                verdict = "실질 차이 없음"
            else:
                verdict = "악화"
            print(f"  {label}: seq={seq/1000:.1f} stitch={zipped/1000:.1f} "
                  f"(교차 이득={stitch_gain:.2f}%) | 기존={old/1000:.1f}, "
                  f"대비={vs_old:+.2f}% -> {verdict}")

    # 실험 U — yield1 세금과 one-GP b1 부분 gather 손실을 같은 펌웨어에서 비교.
    uy10, uy11 = meds.get("expu-y10-x1000"), meds.get("expu-y11-x1000")
    if uy10 and uy11:
        print("")
        print("[exp U] yield1 + one-GP b1 feasibility gate")
        print(f"  scalar: r10-fixed={uy10/1000:.3f}, r11-fixed={uy11/1000:.3f} cyc "
              f"(no-yield T={meds.get('expt-fiat-x1000', 0)/1000:.3f}, "
              f"yield2={meds.get('fiat-yield2-x100', 0)/100:.3f})")
        for tag, description in (("lo10", "r10 fixed, low contiguous"),
                                 ("lo11", "r11 fixed, low contiguous"),
                                 ("hi11", "r11 fixed, high contiguous")):
            solo = meds.get(f"expu-{tag}-b1-x1000")
            if solo:
                print(f"  {description}: MVE solo={solo/1000:.3f} cyc")
            rows = (
                ("1:1", f"expu-{tag}-seq-x1000", f"expu-{tag}-stitch-x1000",
                 None),
                ("4:1", f"expu-{tag}-m4-seq-x1000", f"expu-{tag}-m4-stitch-x1000",
                 "expm4-stitch-x1000"),
                ("8:1", f"expu-{tag}-m8-seq-x1000", f"expu-{tag}-m8-stitch-x1000",
                 None),
            )
            for ratio, seq_key, stitch_key, old_key in rows:
                seq, stitched = meds.get(seq_key), meds.get(stitch_key)
                if ratio == "1:1":
                    candidates = [meds.get("expj-stitch-x1000"),
                                  meds.get("expj-stitch2-x1000")]
                    candidates = [value for value in candidates if value]
                    old = min(candidates) if candidates else None
                elif ratio == "8:1":
                    candidates = [meds.get("expm-stitch-x1000"),
                                  meds.get("expt-m8-stitch-x1000")]
                    candidates = [value for value in candidates if value]
                    old = min(candidates) if candidates else None
                else:
                    old = meds.get(old_key)
                if not (seq and stitched and old):
                    continue
                own_gain = (seq - stitched) / seq * 100
                vs_best = (old - stitched) / old * 100
                verdict = ("강한 개선" if vs_best >= 3 else
                           ("부분 개선" if vs_best > 0 else "악화"))
                print(f"    {ratio}: seq={seq/1000:.3f} stitch={stitched/1000:.3f} "
                      f"(내부 {own_gain:.2f}%) | 현재 최선={old/1000:.3f}, "
                      f"대비={vs_best:+.2f}% -> {verdict}")

    # 실험 V — 현재 ML-KEM NTT/invNTT 비용과 최적화의 절대 상한.
    vf, vi = meds.get("expv-ntt-x1000"), meds.get("expv-invntt-x1000")
    if vf and vi:
        fwd, inv = vf / 1000, vi / 1000
        totals = {
            "keygen": (6 * fwd + 3 * inv, 5000),
            "encaps": (3 * fwd + 4 * inv, 20000),
            "decaps": (6 * fwd + 5 * inv, 15000),
        }
        print("")
        print("[exp V] current ML-KEM NTT attribution")
        print(f"  forward NTT={fwd:.3f} cyc, inverse NTT={inv:.3f} cyc")
        for op, (upper, gate) in totals.items():
            verdict = "gate theoretically reachable" if upper >= gate else "NTT-only gate impossible"
            print(f"  {op}: current NTT total={upper:.3f} cyc, "
                  f"zero-cost upper bound={upper:.3f} vs gate={gate} -> {verdict}")

    # 실험 W — pinned pqmx/SLOTHY MVE NTT를 바로 이 보드의 ITCM에서 측정.
    candidates = (
        ("1+2+2+2", "expw-fwd-l1222-x1000"),
        ("1+2+2+2 vld4", "expw-fwd-l1222-vld4-x1000"),
        ("2+3+2 size", "expw-fwd-l232-size-x1000"),
        ("2+3+2 speed", "expw-fwd-l232-speed-x1000"),
    )
    measured = [(label, meds.get(key) / 1000) for label, key in candidates if meds.get(key)]
    if vf and vi and measured:
        current_fwd, current_inv = vf / 1000, vi / 1000
        conversion = meds.get("expw-rev4-x1000", 0) / 1000
        inverse = meds.get("expw-inv-m85-wip-x1000", 0) / 1000
        best_label, best_fwd = min(measured, key=lambda item: item[1])
        print("")
        print("[exp W] pqmx/SLOTHY NTT on EK-RA8M1 (ITCM)")
        for label, value in measured:
            gain = (current_fwd - value) / current_fwd * 100
            print(f"  forward {label}: {value:.3f} cyc, current 대비 {gain:.2f}% faster")
        print(f"  explicit rev4 conversion: {conversion:.3f} cyc")
        print("  inverse M55 comparator: unavailable — upstream overlap-writeback "
              "LDRD caused RA8M1 UNDEFINSTR at 0x96c0")
        print(f"  inverse M85 WIP schedule: {inverse:.3f} cyc")
        print(f"  best forward={best_label} {best_fwd:.3f} cyc; "
              f"one rev4 포함={best_fwd + conversion:.3f} cyc")

        match = re.search(
            r"expw mismatch: (\d+) m55-unavailable=(\d+) "
            r"m85-inv-mm=(\d+) m85-roundtrip-mm=(\d+)", log
        )
        correctness_ok = False
        if match:
            correctness_ok = (match.group(1), match.group(3), match.group(4)) == ("0", "0", "0")
            print(f"  correctness: forward mismatch={match.group(1)}, "
                  f"M55 unavailable={match.group(2)}, M85 inverse-mm={match.group(3)}, "
                  f"M85 roundtrip-mm={match.group(4)}")

        print("  scope: direct-call, one aligned DTCM buffer transformed repeatedly; "
              "ML-KEM caller/glue not integrated")
        if inverse and correctness_ok:
            primitive_savings = {
                "keygen": (6 * (current_fwd - best_fwd) + 3 * (current_inv - inverse), 5000),
                "encaps": (3 * (current_fwd - best_fwd) + 4 * (current_inv - inverse), 20000),
                "decaps": (6 * (current_fwd - best_fwd) + 5 * (current_inv - inverse), 15000),
            }
            print("  primitive-only projection (caller/order glue 미포함):")
            for op, (saved, gate) in primitive_savings.items():
                verdict = "gate pass" if saved >= gate else "gate miss"
                print(f"    {op}: saved={saved:.3f} cyc vs gate={gate} -> {verdict}")
        elif inverse:
            print("  primitive-only projection suppressed: correctness gate did not pass")

    # 실험 X — forward+rev4를 실제 poly_ntt에 연결한 full ML-KEM same-firmware A/B.
    expx_match = re.search(
        r"expX bytes-mm: (\d+) smoke-fails=(\d+) "
        r"align-base-bits=(\d+) align-candidate-bits=(\d+)", log
    )
    expx_timing_match = re.search(
        r"expX timing-mm: (\d+) stack-fails=(\d+) stack-used=(\d+)", log
    )
    expx_values_ab = {
        "keygen": (meds.get("mlkem768-keygen"), meds.get("expx-mlkem-keygen")),
        "encaps": (meds.get("mlkem768-encaps"), meds.get("expx-mlkem-encaps")),
        "decaps": (meds.get("mlkem768-decaps"), meds.get("expx-mlkem-decaps")),
    }
    expx_values_ba = {
        "keygen": (meds.get("expx-ba-baseline-keygen"), meds.get("expx-ba-candidate-keygen")),
        "encaps": (meds.get("expx-ba-baseline-encaps"), meds.get("expx-ba-candidate-encaps")),
        "decaps": (meds.get("expx-ba-baseline-decaps"), meds.get("expx-ba-candidate-decaps")),
    }
    expx_values_ready = all(
        value is not None
        for pairs in (expx_values_ab, expx_values_ba)
        for pair in pairs.values()
        for value in pair
    )
    if expx_match:
        correctness_ok = (expx_match.group(1) == "0" and expx_match.group(2) == "0"
                          and expx_timing_match is not None
                          and expx_timing_match.group(1) == "0"
                          and expx_timing_match.group(2) == "0")
        print("")
        print("[exp X] pqmx forward+rev4 full ML-KEM same-function ABBA")
        print(f"  correctness: byte-mm={expx_match.group(1)}, smoke-fails={expx_match.group(2)}, "
              f"alignment bitsets base/candidate={expx_match.group(3)}/{expx_match.group(4)}")
        if expx_timing_match:
            print(f"  timing workload: byte-mm={expx_timing_match.group(1)}, "
                  f"stack-fails={expx_timing_match.group(2)}, "
                  f"stack-highwater={expx_timing_match.group(3)} B")
        if correctness_ok and expx_values_ready:
            gates = {"keygen": 8000, "encaps": 4000, "decaps": 8000}
            for op in ("keygen", "encaps", "decaps"):
                base_ab, candidate_ab = expx_values_ab[op]
                base_ba, candidate_ba = expx_values_ba[op]
                saved_ab = base_ab - candidate_ab
                saved_ba = base_ba - candidate_ba
                conservative = min(saved_ab, saved_ba)
                verdict = "gate pass" if conservative >= gates[op] else "gate miss"
                print(f"  {op}: AB saved={saved_ab:.3f}, BA saved={saved_ba:.3f}, "
                      f"conservative={conservative:.3f} cyc vs gate={gates[op]} -> {verdict}")
        else:
            print("  performance rejected: byte/workload/stack correctness gate failed")

    # Experiment Y -- keep X forward fixed and replace only the inverse NTT.
    expy_match = re.search(
        r"expY bytes-mm: (\d+) smoke-fails=(\d+) oracle-mm=(\d+) "
        r"oracle-canary=(\d+) align-base-bits=(\d+) align-candidate-bits=(\d+) "
        r"input-min=(-?\d+) input-max=(-?\d+) output-min=(-?\d+) output-max=(-?\d+)",
        log,
    )
    expy_timing_match = re.search(
        r"expY timing-mm: (\d+) stack-fails=(\d+) stack-used=(\d+)", log
    )
    expy_values_ab = {
        "keygen": (meds.get("expy-ab-baseline-keygen"), meds.get("expy-ab-candidate-keygen")),
        "encaps": (meds.get("expy-ab-baseline-encaps"), meds.get("expy-ab-candidate-encaps")),
        "decaps": (meds.get("expy-ab-baseline-decaps"), meds.get("expy-ab-candidate-decaps")),
    }
    expy_values_ba = {
        "keygen": (meds.get("expy-ba-baseline-keygen"), meds.get("expy-ba-candidate-keygen")),
        "encaps": (meds.get("expy-ba-baseline-encaps"), meds.get("expy-ba-candidate-encaps")),
        "decaps": (meds.get("expy-ba-baseline-decaps"), meds.get("expy-ba-candidate-decaps")),
    }
    expy_values_ready = all(
        value is not None
        for pairs in (expy_values_ab, expy_values_ba)
        for pair in pairs.values()
        for value in pair
    )
    if expy_match:
        correctness_ok = (all(expy_match.group(i) == "0" for i in range(1, 5))
                          and expy_timing_match is not None
                          and expy_timing_match.group(1) == "0"
                          and expy_timing_match.group(2) == "0")
        print("")
        print("[exp Y] pqmx inverse full ML-KEM same-function ABBA")
        print(f"  correctness: byte-mm={expy_match.group(1)}, "
              f"smoke-fails={expy_match.group(2)}, oracle-mm={expy_match.group(3)}, "
              f"oracle-canary={expy_match.group(4)}")
        print(f"  alignment bitsets base/candidate={expy_match.group(5)}/{expy_match.group(6)}, "
              f"input-range=[{expy_match.group(7)},{expy_match.group(8)}], "
              f"output-range=[{expy_match.group(9)},{expy_match.group(10)}]")
        if expy_timing_match:
            print(f"  timing workload: byte-mm={expy_timing_match.group(1)}, "
                  f"stack-fails={expy_timing_match.group(2)}, "
                  f"stack-highwater={expy_timing_match.group(3)} B")
        if correctness_ok and expy_values_ready:
            gates = {"keygen": 6000, "encaps": 8000, "decaps": 10000}
            for op in ("keygen", "encaps", "decaps"):
                base_ab, candidate_ab = expy_values_ab[op]
                base_ba, candidate_ba = expy_values_ba[op]
                saved_ab = base_ab - candidate_ab
                saved_ba = base_ba - candidate_ba
                conservative = min(saved_ab, saved_ba)
                verdict = "gate pass" if conservative >= gates[op] else "gate miss"
                print(f"  {op}: AB saved={saved_ab:.3f}, BA saved={saved_ba:.3f}, "
                      f"conservative={conservative:.3f} cyc vs gate={gates[op]} -> {verdict}")
        else:
            print("  performance rejected: byte/workload/stack correctness gate failed")

    # Experiment Z -- switch X forward and Y inverse together.
    expz_match = re.search(
        r"expZ bytes-mm: (\d+) smoke-fails=(\d+) "
        r"fwd-align-base=(\d+) fwd-align-candidate=(\d+) "
        r"inv-align-base=(\d+) inv-align-candidate=(\d+)", log
    )
    expz_timing_match = re.search(
        r"expZ timing-mm: (\d+) stack-fails=(\d+) stack-used=(\d+)", log
    )
    expz_values_ab = {
        "keygen": (meds.get("expz-ab-baseline-keygen"), meds.get("expz-ab-candidate-keygen")),
        "encaps": (meds.get("expz-ab-baseline-encaps"), meds.get("expz-ab-candidate-encaps")),
        "decaps": (meds.get("expz-ab-baseline-decaps"), meds.get("expz-ab-candidate-decaps")),
    }
    expz_values_ba = {
        "keygen": (meds.get("expz-ba-baseline-keygen"), meds.get("expz-ba-candidate-keygen")),
        "encaps": (meds.get("expz-ba-baseline-encaps"), meds.get("expz-ba-candidate-encaps")),
        "decaps": (meds.get("expz-ba-baseline-decaps"), meds.get("expz-ba-candidate-decaps")),
    }
    expz_values_ready = all(
        value is not None
        for pairs in (expz_values_ab, expz_values_ba)
        for pair in pairs.values()
        for value in pair
    )
    if expz_match:
        correctness_ok = (expz_match.group(1) == "0" and expz_match.group(2) == "0"
                          and expz_timing_match is not None
                          and expz_timing_match.group(1) == "0"
                          and expz_timing_match.group(2) == "0")
        print("")
        print("[exp Z1] X+Y combined full ML-KEM same-function ABBA")
        print(f"  correctness: byte-mm={expz_match.group(1)}, "
              f"smoke-fails={expz_match.group(2)}")
        print(f"  alignment forward base/candidate={expz_match.group(3)}/{expz_match.group(4)}, "
              f"inverse base/candidate={expz_match.group(5)}/{expz_match.group(6)}")
        if expz_timing_match:
            print(f"  timing workload: byte-mm={expz_timing_match.group(1)}, "
                  f"stack-fails={expz_timing_match.group(2)}, "
                  f"stack-highwater={expz_timing_match.group(3)} B")
        if correctness_ok and expz_values_ready:
            isolated = {"keygen": 18772, "encaps": 16177, "decaps": 24204}
            for op in ("keygen", "encaps", "decaps"):
                base_ab, candidate_ab = expz_values_ab[op]
                base_ba, candidate_ba = expz_values_ba[op]
                saved_ab = base_ab - candidate_ab
                saved_ba = base_ba - candidate_ba
                conservative = min(saved_ab, saved_ba)
                preservation = conservative / isolated[op]
                verdict = ("strong pass" if preservation >= 0.90 else
                           ("partial pass" if preservation >= 0.70 else "fail"))
                print(f"  {op}: AB saved={saved_ab:.3f}, BA saved={saved_ba:.3f}, "
                      f"conservative={conservative:.3f} cyc, "
                      f"isolated-sum preservation={preservation*100:.2f}% -> {verdict}")
        else:
            print("  performance rejected: byte/workload/stack correctness gate failed")

    # 합성 스티칭 분석: S vs A+B vs max(A,B)
    a, b, s = (meds.get("stitch-A-mulchain"), meds.get("stitch-B-logicchain"),
               meds.get("stitch-S-interleaved"))
    if a and b and s:
        saved = a + b - s
        recover = saved / min(a, b) * 100
        print(f"\n[stitch micro] A={a} B={b} S={s}  |  A+B={a + b}  max={max(a, b)}"
              f"\n  절감 {saved} cyc = 짧은 스트림의 {recover:.0f}% 회수"
              f"  (이상적 100% = S가 max(A,B)에 도달)")
    mf, mb = meds.get("mul256-full-x100"), meds.get("mul256-budget-x100")
    if mf and mb:
        print(f"[A-tax] mul256 full={mf / 100:.0f} budget(r8-r11 예약)={mb / 100:.0f} cyc/회"
              f"  → 세금 {(mb - mf) / mf * 100:+.1f}%")
    fl, th, st = (meds.get("mul256-flat-x100"), meds.get("theta-frag-x100"),
                  meds.get("stitched-x100"))
    if fl and th and st:
        seq = fl + th
        print(f"[REAL STITCH] mul={fl / 100:.0f} theta={th / 100:.0f} 순차합={seq / 100:.0f}"
              f" 스티치={st / 100:.0f} cyc/회  → 절감 {(seq - st) / 100:.0f} cyc"
              f" = theta의 {(seq - st) / th * 100:.0f}% 은닉")
    rf, sr = meds.get("round-frag-x100"), meds.get("stitched-round-x100")
    if fl and rf and sr:
        seq = fl + rf
        print(f"[FULL ROUND ] mul={fl / 100:.0f} round={rf / 100:.0f} 순차합={seq / 100:.0f}"
              f" 스티치={sr / 100:.0f} cyc/회  → 절감 {(seq - sr) / 100:.0f} cyc"
              f" = 교차 구간 기준 은닉률 {(seq - sr) / min(fl, rf) * 100:.0f}%")
    f6, r6, s6 = (meds.get("mul256-flat6-x100"), meds.get("round6-frag-x100"),
                  meds.get("stitched-round6-x100"))
    if f6 and r6 and s6:
        seq = f6 + r6
        print(f"[SWEEP r6   ] mul6={f6 / 100:.0f} round6={r6 / 100:.0f} 순차합={seq / 100:.0f}"
              f" 스티치={s6 / 100:.0f} cyc/회  → 절감 {(seq - s6) / 100:.0f} cyc")
    ss, so = meds.get("slothy-seq-x1000"), meds.get("slothy-opt-x1000")
    if ss and so:
        print(f"[SLOTHY expA] 원본순서={ss / 1000:.2f} 솔버스케줄={so / 1000:.2f} cyc/iter"
              f"  (모델 예측: 본문 9 + 루프 — 17명령)")
    bs, bz, bo = (meds.get("bmid-seq-x1000"), meds.get("bmid-zip-x1000"),
                  meds.get("bmid-slothy-x1000"))
    if bs and bz and bo:
        print(f"[BMID 3파전  ] 순차={bs / 1000:.2f} 지퍼={bz / 1000:.2f}"
              f" 솔버={bo / 1000:.2f} cyc/iter (모델 예측: 본문 82 + 루프 ~4)")
    fs, fz, fo = (meds.get("bfull-seq-x1000"), meds.get("bfull-zip-x1000"),
                  meds.get("bfull-slothy-x1000"))
    if fs:
        line = f"[BFULL      ] 순차={fs / 1000:.1f}"
        if fo:
            line += f" 솔버={fo / 1000:.1f}"
        print(line + " cyc/iter (지퍼 기준값: flat6 기반 681cyc — 로드맵 8차)")
    cs, co = meds.get("expc-seq-x1000"), meds.get("expc-slothy-x1000")
    if cs:
        line = f"[EXPC fiat  ] 순차={cs / 1000:.1f}"
        if co:
            line += f" 솔버={co / 1000:.1f}"
        print(line + " cyc/iter (진짜 fiat 필드 곱 × round6)")
    ds, do_ = meds.get("expd-seq-x1000"), meds.get("expd-slothy-x1000")
    if ds:
        line = f"[EXPD interleaved] 순차={ds / 1000:.1f}"
        if do_:
            line += f" 솔버={do_ / 1000:.1f}"
        print(line + " cyc/iter (fiat × 비트-인터리브 라운드)")
    es, eo = meds.get("expe-seq-x1000"), meds.get("expe-slothy-x1000")
    if es:
        line = f"[EXPE 4:1코어] 순차={es / 1000:.1f}"
        if eo:
            line += f" 솔버={eo / 1000:.1f}"
        print(line + " cyc/iter (곱x4+라운드 — X-Wing 실비율)")
    mv = meds.get("mve4-round-x1000")
    if mv:
        print(f"[PLAN-B MVE ] 4-way 라운드={mv / 1000:.1f} cyc/iter = 상태당 {mv / 4000:.1f} cyc"
              f" (스칼라 round6i 단독 ~350 대비)")
    ca, cz = meds.get("coissue-A-x1000"), meds.get("coissue-zip-x1000")
    if ca and cz and mv:
        seq = ca + mv
        print(f"[CO-ISSUE F ] A(스칼라)={ca / 1000:.1f} B(MVE)={mv / 1000:.1f}"
              f" 순차합={seq / 1000:.1f} 교차={cz / 1000:.1f} cyc/iter"
              f"  → 절감 {(seq - cz) / 1000:.1f} = 짧은쪽의 {(seq - cz) / min(ca, mv) * 100:.0f}% 은닉")
    cso = meds.get("coissue-slothy-x1000")
    if ca and cz and mv and cso:
        seq = ca + mv
        print(f"[F-SOLVER   ] 지퍼={cz / 1000:.1f} 솔버={cso / 1000:.1f} cyc/iter"
              f"  → 지퍼 대비 {(cz - cso) / cz * 100:+.1f}%"
              f", 은닉률 {(seq - cso) / min(ca, mv) * 100:.0f}% (지퍼 {(seq - cz) / min(ca, mv) * 100:.0f}%)")
    cs2 = meds.get("coissue-slothy2-x1000")
    if ca and mv and cs2:
        seq = ca + mv
        print(f"[F-SOLVER v04] 솔버(v0.4)={cs2 / 1000:.1f} cyc/iter"
              f"  → v0.3 대비 {(cso - cs2) / cso * 100:+.1f}%, 지퍼 대비 {(cz - cs2) / cz * 100:+.1f}%"
              f", 은닉률 {(seq - cs2) / min(ca, mv) * 100:.0f}%"
              f" (구조 하한: 스칼라 611 + 스토어 242 = 853)")
    m3, c3 = meds.get("mve3-round-x1000"), meds.get("coissue3-zip-x1000")
    if m3 and c3 and ca:
        seq3 = ca + m3
        print(f"[EXP-G b3   ] MVE3단독={m3 / 1000:.1f}(5베이스판 {mv / 1000:.1f})"
              f" 코이슈={c3 / 1000:.1f} vs 순차합={seq3 / 1000:.1f}"
              f" → 은닉 {(seq3 - c3) / min(ca, m3) * 100:.0f}% (3-베이스 예산 검증)")
    gl = meds.get("glue-roundtrip-x1000")   # 실제 단일 왕복(x1 실행)
    if gl and mv:
        mve_per_batch = 24 * mv / 1000      # 배치당 순열 일량(24라운드×상태묶음)
        print(f"[EXP-H glue ] pack+unpack 왕복={gl:.0f} cyc/배치 = 배치 순열({mve_per_batch:.0f})"
              f" 대비 {gl / mve_per_batch * 100:.1f}% (naive 스칼라 전치 상한 — vld4/absorb 융합 시 ~0)")
    fb, fy = meds.get("fiat-base-x100"), meds.get("fiat-yield3-x100")
    if fb and fy:
        print(f"[EXP-I 양보 ] fiat 곱 base={fb / 100:.1f} yield3(r10/11/12 양보)={fy / 100:.1f}"
              f" cyc/회 → 세금 {(fy - fb) / fb * 100:+.1f}% (정답 불변, MVE 베이스 3개 확보)")
    m2, c2, fy2 = (meds.get("mve2-round-x1000"), meds.get("coissue2-zip-x1000"),
                   meds.get("fiat-yield2-x100"))
    if m2 and c2 and fy2 and fb and ca:
        seq2 = ca + m2
        print(f"[V0.4 b2    ] MVE2단독={m2 / 1000:.1f}(3베이스 {meds.get('mve3-round-x1000', 0) / 1000:.1f})"
              f" 코이슈은닉={(seq2 - c2) / min(ca, m2) * 100:.0f}%")
        print(f"[V0.4 양보2 ] fiat yield2={fy2 / 100:.1f} vs base={fb / 100:.1f}"
              f" → 세금 {(fy2 - fb) / fb * 100:+.1f}% (yield3는 +13.5%)")
    ks, kc, kt = (meds.get("expk-seq-x1000"), meds.get("expk-coarse-x1000"),
                  meds.get("expk-stitch-x1000"))
    if ks and kc and kt:
        print(f"[EXP-K 3파전] 순차={ks / 1000:.0f} 굵은교대={kc / 1000:.0f}"
              f" 스티칭={kt / 1000:.0f} cyc (곱3+라운드3)"
              f" → 스티칭 이득: vs순차 {(ks - kt) / ks * 100:.1f}%"
              f" vs교대 {(kc - kt) / kc * 100:.1f}% (교차 덕 분리 입증)")
    ln_, lz = meds.get("expl-ntt-x1000"), meds.get("expl-zip-x1000")
    if ln_ and lz and ca:
        seql = ca + ln_
        hid_ntt = (seql - lz) / min(ca, ln_) * 100
        print(f"[EXP-L NTT ] A(umaal)={ca / 1000:.1f} B(NTT형)={ln_ / 1000:.1f}"
              f" 순차합={seql / 1000:.1f} 교차={lz / 1000:.1f}"
              f" → 은닉 {hid_ntt:.0f}% (Keccak짝 58% 대비 — 곱셈기 쟁탈전 판정)")
    sn, sz = meds.get("expl-sntt-x1000"), meds.get("expl-szip-x1000")
    if sn and sz and ca:
        seqs = ca + sn
        print(f"[EXP-L 스칼라] A(umaal)={ca / 1000:.1f} B(smull)={sn / 1000:.1f}"
              f" 순차합={seqs / 1000:.1f} 교차={sz / 1000:.1f}"
              f" → 은닉 {(seqs - sz) / min(ca, sn) * 100:.0f}%"
              f" (스칼라×스칼라 = 같은 MAC 파이프 쟁탈)")
    jalt = meds.get("expj-stitch-alt-x1000")
    if jalt and meds.get("expj-stitch-x1000"):
        d = jalt - meds["expj-stitch-x1000"]
        print(f"[상수시간   ] expj_stitch 입력 2벌 median Δ={d} cyc"
              f" ({'PASS: 입력 무관' if abs(d) <= 2 else 'FAIL: 입력 의존 의심'})")
    ms, mt = meds.get("expm-seq-x1000"), meds.get("expm-stitch-x1000")
    if ms and mt:
        # encaps 투영: 유닛(곱8+라운드1) × 264배치라운드 + 잔여 곱 81회(비율 8.3의 끝수)
        fy2c = meds.get("fiat-yield2-x100", 32400) / 100
        enc_seq = ms / 1000 * 264 + 81 * fy2c
        enc_st = mt / 1000 * 264 + 81 * fy2c
        print(f"[EXP-M 실비율] 유닛(곱8+라운드1): 순차={ms / 1000:.0f} 스티칭={mt / 1000:.0f}"
              f" (−{(ms - mt) / ms * 100:.1f}%)")
        print(f"[encaps 투영] 순차={enc_seq / 1000:.0f}k 스티칭={enc_st / 1000:.0f}k"
              f" → 절감 {(enc_seq - enc_st) / enc_seq * 100:.1f}% (측정 유닛 기반)")
    m4s, m4t = meds.get("expm4-seq-x1000"), meds.get("expm4-stitch-x1000")
    if m4s and m4t:
        # keygen은 43순열=258유닛+잔여68, decaps는 44순열=264유닛+잔여44.
        # 둘을 264+44로 공용 계산하면 keygen 투영에 decaps 호출 수가 섞인다.
        fy2c = meds.get("fiat-yield2-x100", 32400) / 100
        kg_seq = m4s / 1000 * 258 + 68 * fy2c
        kg_st = m4t / 1000 * 258 + 68 * fy2c
        dc_seq = m4s / 1000 * 264 + 44 * fy2c
        dc_st = m4t / 1000 * 264 + 44 * fy2c
        print(f"[EXP-M4 4:1 ] 유닛(곱4+라운드1): 순차={m4s / 1000:.0f} 스티칭={m4t / 1000:.0f}"
              f" (−{(m4s - m4t) / m4s * 100:.1f}%)")
        print(f"[keygen 투영] 순차={kg_seq / 1000:.0f}k 스티칭={kg_st / 1000:.0f}k"
              f" → 절감 {(kg_seq - kg_st) / kg_seq * 100:.1f}%")
        print(f"[decaps 투영] 순차={dc_seq / 1000:.0f}k 스티칭={dc_st / 1000:.0f}k"
              f" → 절감 {(dc_seq - dc_st) / dc_seq * 100:.1f}%")
    js, jt = meds.get("expj-seq-x1000"), meds.get("expj-stitch-x1000")
    if js and jt:
        print(f"[EXP-J 통합 ] 순차={js / 1000:.0f} 스티칭={jt / 1000:.0f} cyc"
              f" → 절감 {(js - jt) / js * 100:.1f}% (진짜 fiat 곱 × MVE 라운드, 정답 ✓)")
    k2 = meds.get("stitched-k2-x100")
    if f6 and r6 and k2:
        seq2 = 2 * f6 + r6
        print(f"[SWEEP k=2  ] 순차합(2mul+round6)={seq2 / 100:.0f} 스티치={k2 / 100:.0f} cyc/회"
              f"  → 절감 {(seq2 - k2) / 100:.0f} cyc = round6의 {(seq2 - k2) / r6 * 100:.0f}% 은닉")
    bm, sm = meds.get("stitch-Bm-memchain"), meds.get("stitch-Sm-interleaved-mem")
    if a and bm and sm:
        saved = a + bm - sm
        recover = saved / min(a, bm) * 100
        print(f"[stitch mem  ] A={a} B'={bm} S'={sm}  |  A+B'={a + bm}  max={max(a, bm)}"
              f"\n  절감 {saved} cyc = 짧은 스트림의 {recover:.0f}% 회수 (메모리 상주 B')")

    # 실험 N — 페어링 스펙트럼: 클래스별 코이슈 노출량 (모델 v0.4 입력)
    if meds.get("pairn-veor-x1000") and ca:
        print("\n[실험 N 페어링 스펙트럼] umaal 611 × MVE 클래스 611 (1:1 지퍼)")
        for key in ("veor", "ldr", "str", "rot"):
            solo = meds.get(f"pairn-{key}-x1000")
            z = meds.get(f"pairn-{key}-zip-x1000")
            if not (solo and z):
                continue
            seq = ca + solo
            expo = z - max(ca, solo)
            print(f"  {key:4s}: 단독={solo / 1000:7.1f} 지퍼={z / 1000:7.1f}"
                  f" 순차합={seq / 1000:7.1f} → 은닉 {(seq - z) / min(ca, solo) * 100:3.0f}%"
                  f", 노출 {expo / 1000:.1f} cyc")

    # 실험 N2 — 2:1 비율(umaal 1222 × 클래스 611): 사이클당 스칼라 수용량 판별
    if meds.get("pairn2-ldr-x1000"):
        print("[실험 N2 수용량] umaal 1222 × 클래스 611 (기준: 1/cyc→~1228 · 0.5/cyc→~1833 · 차단→~2444)")
        for key in ("ldr", "str", "rot"):
            z = meds.get(f"pairn2-{key}-x1000")
            if z:
                print(f"  {key:4s}: {z / 1000:7.1f}")
        ls, lz = meds.get("pairn-lsmix-x1000"), meds.get("pairn-lsmix-zip-x1000")
        if ls and lz:
            print(f"  lsmix(로드/스토어 교대): 단독={ls / 1000:.1f} 지퍼={lz / 1000:.1f}"
                  f" (스토어 306개 차단만이면 지퍼 ≈ 단독+스칼라잔여)")

    print(f"harness_fails = {fails}")
    sys.exit(1 if fails else 0)


if __name__ == "__main__":
    main()
