/* Experiment AP: ML-KEM 비-Keccak 내부 재귀속 probe.
 *
 * 모든 bucket 은 Keccak 을 뺀 값이다. expAO 의 g_keccak_perm_cyc 누산기를 재사용해
 * 창 안에서 실제로 든 permutation cycle 을 그대로 차감하므로, Z2 가 했던
 * "perms x 5,526 을 빼는" 간접 보정이 필요 없다.
 *
 * ap_enable=0 이면 분기 하나 말고는 기존 경로와 같다.
 * expAO 의 g_keccak_prof_enable 도 함께 1 이어야 차감이 성립한다.
 */
#ifndef AP_PROBE_H
#define AP_PROBE_H

#include <stdint.h>

#define AP_NBUCKET 10

#define AP_B_NTT     0
#define AP_B_INVNTT  1
#define AP_B_MATACC  2
#define AP_B_BASEMUL 3
#define AP_B_NOISE   4
#define AP_B_PACK    5
#define AP_B_ARITH   6
#define AP_B_VERIFY  7
#define AP_B_XOF_ABSORB  8   /* expAQ: matacc 내부 세분 */
#define AP_B_XOF_SQUEEZE 9

extern volatile uint32_t ap_enable;
extern volatile uint32_t ap_cyc[AP_NBUCKET];
extern volatile uint32_t ap_calls[AP_NBUCKET];
extern volatile uint32_t g_keccak_perm_cyc;

#define AP_CYCCNT (*(volatile uint32_t *) 0xE0001004u)

/* 값을 돌려주지 않는 함수용 */
#define AP_WRAP(B, CALL) do {                                        \
    if (ap_enable) {                                                 \
        uint32_t _apt = AP_CYCCNT;                                   \
        uint32_t _apk = g_keccak_perm_cyc;                           \
        CALL;                                                        \
        ap_cyc[B] += (AP_CYCCNT - _apt) - (g_keccak_perm_cyc - _apk); \
        ap_calls[B]++;                                               \
    } else {                                                         \
        CALL;                                                        \
    }                                                                \
} while (0)

/* 값을 돌려주는 함수용 */
#define AP_WRAP_RET(B, TYPE, CALL) __extension__ ({                  \
    TYPE _apr;                                                       \
    if (ap_enable) {                                                 \
        uint32_t _apt = AP_CYCCNT;                                   \
        uint32_t _apk = g_keccak_perm_cyc;                           \
        _apr = (CALL);                                               \
        ap_cyc[B] += (AP_CYCCNT - _apt) - (g_keccak_perm_cyc - _apk); \
        ap_calls[B]++;                                               \
    } else {                                                         \
        _apr = (CALL);                                               \
    }                                                                \
    _apr;                                                            \
})

#endif /* AP_PROBE_H */
