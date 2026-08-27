# 플래그 위험 정적 검사: adds(캐리 생산)와 그 소비자 adc 사이에
# 다른 플래그-쓰기(adds/adcs/subs)가 끼어들었는지 스캔 (2026-08-16)
# 사용법: py check_flag_hazard.py <파일.s>
import re
import sys

WRITERS = ("adds", "adcs", "subs")
READERS = ("adc", "adcs")

body = []
for ln in open(sys.argv[1], encoding="utf-8"):
    code = ln.split("//")[0].strip()
    if code and not code.endswith(":"):
        body.append(code)

hazards = 0
pending_reader_expected = False   # 직전 flag-write 이후 아직 reader를 못 만난 상태
last_writer_idx = None
for i, ins in enumerate(body):
    mn = ins.split()[0]
    is_writer = mn in WRITERS
    is_reader = mn in READERS
    if is_reader:
        pending_reader_expected = False
    if is_writer:
        if pending_reader_expected and mn != "adcs":
            pass  # 연속 writer 자체는 (읽는 사람이 없으면) 무해
        # 위험: 이 writer가 '이전 writer의 미소비 캐리'를 덮는 경우 —
        # 입력 프로그램에서는 모든 adds 뒤에 정확히 그 캐리를 읽는 adc가 옴.
        # 출력에서 writer→(다른 writer)→reader 순서면 캐리 오염.
        if pending_reader_expected:
            hazards += 1
            print(f"HAZARD @{i}: '{body[last_writer_idx]}' 캐리가 소비 전에 '{ins}'로 덮임")
            if hazards >= 10:
                break
        pending_reader_expected = True
        last_writer_idx = i

print(f"total hazards(앞 10개만 출력): {hazards}, instructions={len(body)}")
