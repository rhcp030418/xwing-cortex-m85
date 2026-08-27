/* 이 보드(EK-RA8M1 개체)의 ITCM 0x18·0xE0에 쓰기 불능(고착) 8바이트 granule 2개 관찰
 * (2026-08-16: 디버거·CPU 어느 쪽 쓰기도 반영 안 됨, 읽기는 고정 garbage).
 * 링커에서 .itcm_from_flash가 .itcm_code_from_flash보다 먼저 배치되는 것을 이용해
 * 256B 패드로 실제 코드를 0x100 이후로 밀어내 불량 셀을 회피한다.
 * ponytail: 개체 불량 회피용 — 다른 보드에서는 불필요할 수 있음. 불량 granule이 더
 * 발견되면 보드 교환 검토. */
#include <stdint.h>

const uint8_t g_itcm_bad_granule_pad[256]
__attribute__((used, section(".itcm_from_flash"))) = { 0 };
