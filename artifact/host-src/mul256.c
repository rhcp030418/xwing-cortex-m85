/* 파일럿 실험 3: A-세금 측정용 대표 MAC 워크로드 — 8x8 32비트 스쿨북 곱(product scanning).
 * 같은 소스를 ①일반 ②-ffixed-r8..r11(스트림 B 몫 4개 예약)로 두 번 컴파일해 비교한다.
 * 벤치 전용: 분기(acc_hi++)가 데이터 의존이라 상수시간 아님 — 세금 비율 측정에는 무관.
 */
#include <stdint.h>

void MULNAME(uint32_t r[16], const uint32_t a[8], const uint32_t b[8])
{
    uint64_t acc = 0;
    uint32_t acc_hi = 0;

    for (int k = 0; k < 15; k++) {
        int lo = k > 7 ? k - 7 : 0;
        int hi = k < 8 ? k : 7;
        for (int i = lo; i <= hi; i++) {
            uint64_t p = (uint64_t)a[i] * b[k - i];
            acc += p;
            if (acc < p) acc_hi++;
        }
        r[k] = (uint32_t)acc;
        acc = (acc >> 32) | ((uint64_t)acc_hi << 32);
        acc_hi = 0;
    }
    r[15] = (uint32_t)acc;
}
