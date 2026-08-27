# EK-RA8M1 칩 내장 온도센서(TSN) 읽기 — 펌웨어 수정/재플래시 없이 J-Link로 레지스터 직접 제어
#
# 사용법: py read_temp_ra8m1.py   (e2 studio 디버그 세션은 닫을 것 — J-Link 단일 클라이언트)
#
# 원리: MSTPCRD로 ADC0(bit16)·TSN(bit22) 클럭 공급 → TSCR.TSEN/TSOE → ADC0 단일 스캔으로
# ADTSDR 읽기 → 공장 보정값 TSCDR(127°C에서의 코드, Vref 3.3V)와 기울기 4.0mV/°C로 환산.
# 주의: 다이 온도라 주변 온도보다 몇 °C 높게 나옴 (코어 부하에 따라 +5~15°C).

import statistics
import sys
import time

import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
DEVICE = "R7FA8M1AH"

ADC0 = 0x40332000      # R_ADC0 (클래식 ADC12)
MSTPCRD = 0x4020300C   # R_MSTP->MSTPCRD
TSCR = 0x40235000      # R_TSN_CTRL (TSEN=bit7, TSOE=bit4)
TSCDR = 0x4011B17C     # 공장 보정: 127°C·3.3V에서의 A/D 코드 (하위 16비트 유효)

SLOPE_V = 0.004        # BSP_FEATURE_TSN_SLOPE = 4000 uV/°C
VREF = 3.3             # EK-RA8M1 AVCC0


def main():
    j = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    j.open()
    j.set_tif(pylink.enums.JLinkInterfaces.SWD)
    j.connect(DEVICE, speed=4000)

    j.memory_write32(MSTPCRD, [j.memory_read32(MSTPCRD, 1)[0] & ~((1 << 16) | (1 << 22))])
    j.memory_write8(TSCR, [0x80])          # TSEN=1
    time.sleep(0.001)                      # 안정화 대기 (스펙 30us)
    j.memory_write8(TSCR, [0x90])          # TSEN|TSOE
    j.memory_write8(ADC0 + 0xDE, [0xFF])   # ADSSTRT: 센서 최소 샘플링 4.15us 충족(최대치)
    j.memory_write16(ADC0 + 0x12, [1 << 8])  # ADEXICR.TSSA: 그룹A 입력 = 온도센서
    j.memory_write16(ADC0 + 0x0E, [0])     # ADCER: 12비트, 우측정렬

    cal = j.memory_read32(TSCDR, 1)[0] & 0xFFFF
    temps = []
    for _ in range(10):
        j.memory_write16(ADC0, [0x8000])   # ADCSR: 단일 스캔 시작
        for _ in range(100):
            if not j.memory_read16(ADC0, 1)[0] & 0x8000:
                break
        else:
            sys.exit("timeout: ADC 변환이 끝나지 않음 (PCLKC 정지?)")
        code = j.memory_read16(ADC0 + 0x1A, 1)[0]  # ADTSDR
        temps.append(127.0 + (code - cal) * VREF / 4096 / SLOPE_V)
    j.close()

    print(f"다이 온도: {statistics.median(temps):.1f} °C  "
          f"(10회 중앙값, 범위 {min(temps):.1f}~{max(temps):.1f}, cal@127°C={cal})")


if __name__ == "__main__":
    main()
