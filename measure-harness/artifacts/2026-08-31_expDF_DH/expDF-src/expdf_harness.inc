/* expDF only: four same-image correctness/performance micro-gates. */

#include <arm_mve.h>

#define EXPDF_TEXT __attribute__((noinline, section(".itcm_code_from_flash")))
#define EXPDF_DTCM __attribute__((aligned(16), section(".dtcm")))
#define EXPDF_Q 3329u

extern void KeccakF1600_StateExtractBytes(uint64_t *state, unsigned char *data,
                                          unsigned int offset, unsigned int length);
extern void expdf_fe_pair_independent(uint32_t out[16], const uint32_t in[32]);
extern void expdf_fe_pair_batch(uint32_t out[16], const uint32_t in[32]);

static volatile uint32_t expdf_sink;

static void expdf_timer_start(void)
{
    __DSB();
    __ISB();
    DWT->CYCCNT = 0u;
    __DSB();
    __ISB();
}

static uint32_t expdf_timer_stop(void)
{
    __DSB();
    __ISB();
    return DWT->CYCCNT;
}

static uint32_t expdf_median(const volatile uint32_t values[REP_N])
{
    uint32_t sorted[REP_N];
    for (uint32_t i = 0u; i < REP_N; i++) sorted[i] = values[i];
    for (uint32_t i = 1u; i < REP_N; i++) {
        uint32_t x = sorted[i];
        uint32_t j = i;
        while (j != 0u && sorted[j - 1u] > x) {
            sorted[j] = sorted[j - 1u];
            j--;
        }
        sorted[j] = x;
    }
    return (sorted[REP_N / 2u - 1u] + sorted[REP_N / 2u]) / 2u;
}

static void expdf_print_pair(const char *name, uint32_t scale)
{
    uart_puts("expDF "); uart_puts(name);
    uart_puts(" A="); uart_put_u32(expdf_median(rep_cyc[0]));
    uart_puts(" B="); uart_put_u32(expdf_median(rep_cyc[1]));
    uart_puts(" scale="); uart_put_u32(scale);
    uart_puts("\n");
}

/* ---------------- DF1: scalar/MVE conditional swap ---------------- */

static uint32_t expdf_cs_a[16] EXPDF_DTCM;
static uint32_t expdf_cs_b[16] EXPDF_DTCM;

EXPDF_TEXT __attribute__((optimize("no-tree-vectorize")))
static void expdf_cswap_scalar(uint32_t a[16], uint32_t b[16], uint32_t mask)
{
    for (uint32_t i = 0u; i < 16u; i++) {
        uint32_t t = (a[i] ^ b[i]) & mask;
        a[i] ^= t;
        b[i] ^= t;
    }
}

EXPDF_TEXT static void expdf_cswap_mve(uint32_t a[16], uint32_t b[16],
                                       uint32_t mask)
{
    const uint32x4_t m = vdupq_n_u32(mask);
    for (uint32_t i = 0u; i < 16u; i += 4u) {
        uint32x4_t x = vld1q_u32(a + i);
        uint32x4_t y = vld1q_u32(b + i);
        uint32x4_t t = vandq_u32(veorq_u32(x, y), m);
        vst1q_u32(a + i, veorq_u32(x, t));
        vst1q_u32(b + i, veorq_u32(y, t));
    }
}

static void expdf_cswap_prepare(void)
{
    for (uint32_t i = 0u; i < 16u; i++) {
        expdf_cs_a[i] = 0x10203040u ^ (i * 0x01010101u);
        expdf_cs_b[i] = 0xf1e2d3c4u ^ (i * 0x11111111u);
    }
}

EXPDF_TEXT static void expdf_cswap_scalar_256(void)
{
    for (uint32_t i = 0u; i < 256u; i++)
        expdf_cswap_scalar(expdf_cs_a, expdf_cs_b, (uint32_t) (0u - (i & 1u)));
    expdf_sink ^= expdf_cs_a[0] ^ expdf_cs_b[15];
}

EXPDF_TEXT static void expdf_cswap_mve_256(void)
{
    for (uint32_t i = 0u; i < 256u; i++)
        expdf_cswap_mve(expdf_cs_a, expdf_cs_b, (uint32_t) (0u - (i & 1u)));
    expdf_sink ^= expdf_cs_a[0] ^ expdf_cs_b[15];
}

static uint32_t expdf_cswap_check(void)
{
    uint32_t ref_a[16], ref_b[16], got_a[16], got_b[16];
    uint32_t mm = 0u;
    for (uint32_t k = 0u; k < 2u; k++) {
        for (uint32_t i = 0u; i < 16u; i++) {
            ref_a[i] = got_a[i] = 0x12340000u + 17u * i;
            ref_b[i] = got_b[i] = 0xabcd0000u + 31u * i;
        }
        expdf_cswap_scalar(ref_a, ref_b, k ? 0xffffffffu : 0u);
        expdf_cswap_mve(got_a, got_b, k ? 0xffffffffu : 0u);
        mm += (uint32_t) (memcmp(ref_a, got_a, sizeof(ref_a)) != 0);
        mm += (uint32_t) (memcmp(ref_b, got_b, sizeof(ref_b)) != 0);
    }
    return mm;
}

static void expdf_cswap_measure(void)
{
    for (uint32_t r = 0u; r < REP_N; r++) {
        if ((r & 1u) == 0u) {
            expdf_cswap_prepare(); expdf_timer_start(); expdf_cswap_scalar_256(); rep_cyc[0][r] = expdf_timer_stop();
            expdf_cswap_prepare(); expdf_timer_start(); expdf_cswap_mve_256();    rep_cyc[1][r] = expdf_timer_stop();
        } else {
            expdf_cswap_prepare(); expdf_timer_start(); expdf_cswap_mve_256();    rep_cyc[1][r] = expdf_timer_stop();
            expdf_cswap_prepare(); expdf_timer_start(); expdf_cswap_scalar_256(); rep_cyc[0][r] = expdf_timer_stop();
        }
    }
}

/* ---------------- DF2: zero-safe two-element batch inversion ---------------- */

static uint32_t expdf_fe_in[32] EXPDF_DTCM;
static uint32_t expdf_fe_out_a[16] EXPDF_DTCM;
static uint32_t expdf_fe_out_b[16] EXPDF_DTCM;

static void expdf_fe_case(uint32_t which)
{
    static const uint32_t p_minus_1[8] = {
        0xffffffecu, 0xffffffffu, 0xffffffffu, 0xffffffffu,
        0xffffffffu, 0xffffffffu, 0xffffffffu, 0x7fffffffu
    };
    for (uint32_t i = 0u; i < 32u; i++) expdf_fe_in[i] = 0u;
    for (uint32_t i = 0u; i < 8u; i++) {
        expdf_fe_in[i]       = 0x13579bdu * (i + 1u);
        expdf_fe_in[8u + i]  = 0x1020304u * (i + 1u);
        expdf_fe_in[16u + i] = 0x2468aceu * (i + 1u);
        expdf_fe_in[24u + i] = 0x01030507u * (i + 1u);
    }
    expdf_fe_in[7] &= 0x7fffffffu;
    expdf_fe_in[15] &= 0x7fffffffu;
    expdf_fe_in[23] &= 0x7fffffffu;
    expdf_fe_in[31] &= 0x7fffffffu;
    if (which == 1u || which == 3u) for (uint32_t i = 0u; i < 8u; i++) expdf_fe_in[8u + i] = 0u;
    if (which == 2u || which == 3u) for (uint32_t i = 0u; i < 8u; i++) expdf_fe_in[24u + i] = 0u;
    if (which == 4u) {
        for (uint32_t i = 0u; i < 8u; i++) {
            expdf_fe_in[8u + i] = (i == 0u) ? 1u : 0u;
            expdf_fe_in[24u + i] = p_minus_1[i];
        }
    }
}

static uint32_t expdf_fe_check(void)
{
    uint32_t mm = 0u;
    for (uint32_t k = 0u; k < 5u; k++) {
        expdf_fe_case(k);
        expdf_fe_pair_independent(expdf_fe_out_a, expdf_fe_in);
        expdf_fe_pair_batch(expdf_fe_out_b, expdf_fe_in);
        mm += (uint32_t) (memcmp(expdf_fe_out_a, expdf_fe_out_b,
                                sizeof(expdf_fe_out_a)) != 0);
    }
    return mm;
}

static void expdf_fe_measure(void)
{
    expdf_fe_case(0u);
    for (uint32_t r = 0u; r < REP_N; r++) {
        if ((r & 1u) == 0u) {
            expdf_timer_start(); expdf_fe_pair_independent(expdf_fe_out_a, expdf_fe_in); rep_cyc[0][r] = expdf_timer_stop();
            expdf_timer_start(); expdf_fe_pair_batch(expdf_fe_out_b, expdf_fe_in);       rep_cyc[1][r] = expdf_timer_stop();
        } else {
            expdf_timer_start(); expdf_fe_pair_batch(expdf_fe_out_b, expdf_fe_in);       rep_cyc[1][r] = expdf_timer_stop();
            expdf_timer_start(); expdf_fe_pair_independent(expdf_fe_out_a, expdf_fe_in); rep_cyc[0][r] = expdf_timer_stop();
        }
    }
    expdf_sink ^= expdf_fe_out_a[0] ^ expdf_fe_out_b[15];
}

/* ---------------- DF3: direct-64 Keccak squeeze unit ---------------- */

static uint64_t expdf_k_plain[25] EXPDF_DTCM;
static uint64_t expdf_k_ref[25] EXPDF_DTCM;
static uint64_t expdf_k_direct[25] EXPDF_DTCM;
static uint8_t expdf_k_out_a[168] EXPDF_DTCM;
static uint8_t expdf_k_out_b[168] EXPDF_DTCM;

static const uint64_t expdf_keccak_rc[24] = {
    0x0000000000000001ULL, 0x0000000000008082ULL,
    0x800000000000808aULL, 0x8000000080008000ULL,
    0x000000000000808bULL, 0x0000000080000001ULL,
    0x8000000080008081ULL, 0x8000000000008009ULL,
    0x000000000000008aULL, 0x0000000000000088ULL,
    0x0000000080008009ULL, 0x000000008000000aULL,
    0x000000008000808bULL, 0x800000000000008bULL,
    0x8000000000008089ULL, 0x8000000000008003ULL,
    0x8000000000008002ULL, 0x8000000000000080ULL,
    0x000000000000800aULL, 0x800000008000000aULL,
    0x8000000080008081ULL, 0x8000000000008080ULL,
    0x0000000080000001ULL, 0x8000000080008008ULL
};
#define EXPDF_ROL64_CONST(value, count)                                      \
    __extension__ ({                                                        \
        uint64_t _value = (value);                                          \
        uint64_t _swap = (_value << 32) | (_value >> 32);                   \
        uint64_t _left = ((count) < 32) ? _value : _swap;                   \
        uint64_t _right = ((count) < 32) ? _swap : _value;                  \
        __asm volatile ("lsll %Q0, %R0, %2\n\t"                            \
                        "lsrl %Q1, %R1, %3"                                \
                        : "+r" (_left), "+r" (_right)                     \
                        : "i" (((count) < 32) ? (count) : (count) - 32),    \
                          "i" (((count) < 32) ? 32 - (count)                \
                                               : 64 - (count)));             \
        _left | _right;                                                     \
    })

#define EXPDF_RHO_STEP(index, count) do {                                   \
    uint64_t _next = s[(index)];                                            \
    s[(index)] = EXPDF_ROL64_CONST(t, (count));                             \
    t = _next;                                                              \
} while (0)

EXPDF_TEXT static void expdf_keccak64_permute(uint64_t s[25])
{
    uint64_t bc[5], t;
    for (uint32_t round = 0u; round < 24u; round++) {
        for (uint32_t i = 0u; i < 5u; i++)
            bc[i] = s[i] ^ s[i + 5u] ^ s[i + 10u] ^ s[i + 15u] ^ s[i + 20u];
        for (uint32_t i = 0u; i < 5u; i++) {
            t = bc[(i + 4u) % 5u] ^ EXPDF_ROL64_CONST(bc[(i + 1u) % 5u], 1);
            for (uint32_t j = 0u; j < 25u; j += 5u) s[j + i] ^= t;
        }
        t = s[1];
        EXPDF_RHO_STEP(10, 1);  EXPDF_RHO_STEP(7, 3);
        EXPDF_RHO_STEP(11, 6);  EXPDF_RHO_STEP(17, 10);
        EXPDF_RHO_STEP(18, 15); EXPDF_RHO_STEP(3, 21);
        EXPDF_RHO_STEP(5, 28);  EXPDF_RHO_STEP(16, 36);
        EXPDF_RHO_STEP(8, 45);  EXPDF_RHO_STEP(21, 55);
        EXPDF_RHO_STEP(24, 2);  EXPDF_RHO_STEP(4, 14);
        EXPDF_RHO_STEP(15, 27); EXPDF_RHO_STEP(23, 41);
        EXPDF_RHO_STEP(19, 56); EXPDF_RHO_STEP(13, 8);
        EXPDF_RHO_STEP(12, 25); EXPDF_RHO_STEP(2, 43);
        EXPDF_RHO_STEP(20, 62); EXPDF_RHO_STEP(14, 18);
        EXPDF_RHO_STEP(22, 39); EXPDF_RHO_STEP(9, 61);
        EXPDF_RHO_STEP(6, 20);  EXPDF_RHO_STEP(1, 44);
        for (uint32_t j = 0u; j < 25u; j += 5u) {
            for (uint32_t i = 0u; i < 5u; i++) bc[i] = s[j + i];
            for (uint32_t i = 0u; i < 5u; i++)
                s[j + i] ^= (~bc[(i + 1u) % 5u]) & bc[(i + 2u) % 5u];
        }
        s[0] ^= expdf_keccak_rc[round];
    }
}

static void expdf_keccak_prepare(void)
{
    uint32_t *inter = (uint32_t *) (void *) expdf_k_ref;
    for (uint32_t i = 0u; i < 25u; i++) {
        expdf_k_plain[i] = 0x9e3779b97f4a7c15ULL * (uint64_t) (i + 1u)
                           ^ (0x0123456789abcdefULL + i);
        expdf_k_direct[i] = expdf_k_plain[i];
        bitinterleave(expdf_k_plain[i], &inter[2u * i], &inter[2u * i + 1u]);
    }
}

EXPDF_TEXT static void expdf_keccak_ref_unit(void)
{
    KeccakF1600_StatePermute(expdf_k_ref);
    KeccakF1600_StateExtractBytes(expdf_k_ref, expdf_k_out_a, 0u, 168u);
}

EXPDF_TEXT static void expdf_keccak_direct_unit(void)
{
    expdf_keccak64_permute(expdf_k_direct);
    memcpy(expdf_k_out_b, expdf_k_direct, 168u);
}

static uint32_t expdf_keccak_check(void)
{
    expdf_keccak_prepare();
    expdf_keccak_ref_unit();
    expdf_keccak_direct_unit();
    return (uint32_t) (memcmp(expdf_k_out_a, expdf_k_out_b, 168u) != 0);
}

static void expdf_keccak_measure(void)
{
    for (uint32_t r = 0u; r < REP_N; r++) {
        if ((r & 1u) == 0u) {
            expdf_keccak_prepare(); expdf_timer_start(); expdf_keccak_ref_unit();    rep_cyc[0][r] = expdf_timer_stop();
            expdf_keccak_prepare(); expdf_timer_start(); expdf_keccak_direct_unit(); rep_cyc[1][r] = expdf_timer_stop();
        } else {
            expdf_keccak_prepare(); expdf_timer_start(); expdf_keccak_direct_unit(); rep_cyc[1][r] = expdf_timer_stop();
            expdf_keccak_prepare(); expdf_timer_start(); expdf_keccak_ref_unit();    rep_cyc[0][r] = expdf_timer_stop();
        }
    }
    expdf_sink ^= expdf_k_out_a[0] ^ expdf_k_out_b[167];
}

/* ---------------- DF4: scalar/MVE rejection plus scalar MAC ---------------- */

typedef struct { uint32_t count; uint32_t acc; } expdf_mat_result;

static uint8_t expdf_mat_buf[168] EXPDF_DTCM;
static int16_t expdf_mat_b[112] EXPDF_DTCM;
static uint16_t expdf_mat_out_a[112] EXPDF_DTCM;
static uint16_t expdf_mat_out_b[112] EXPDF_DTCM;
static expdf_mat_result expdf_mat_ra, expdf_mat_rb;
static const uint32_t expdf_off0[4] = {0u, 3u, 6u, 9u};
static const uint32_t expdf_off1[4] = {1u, 4u, 7u, 10u};
static const uint32_t expdf_off2[4] = {2u, 5u, 8u, 11u};

static inline void expdf_mat_accept(uint32_t x, uint16_t out[112],
                                     expdf_mat_result *r)
{
    out[r->count] = (uint16_t) x;
    r->acc += (uint32_t) ((int32_t) x * (int32_t) expdf_mat_b[r->count]);
    r->count++;
}

EXPDF_TEXT __attribute__((optimize("no-tree-vectorize")))
static void expdf_mat_scalar(const uint8_t buf[168], uint16_t out[112],
                             expdf_mat_result *r)
{
    r->count = 0u;
    r->acc = 0x6a09e667u;
    for (uint32_t i = 0u; i < 168u; i += 3u) {
        uint32_t x0 = (uint32_t) buf[i] | (((uint32_t) buf[i + 1u] & 15u) << 8);
        uint32_t x1 = ((uint32_t) buf[i + 1u] >> 4) | ((uint32_t) buf[i + 2u] << 4);
        if (x0 < EXPDF_Q) expdf_mat_accept(x0, out, r);
        if (x1 < EXPDF_Q) expdf_mat_accept(x1, out, r);
    }
}

EXPDF_TEXT static void expdf_mat_mve(const uint8_t buf[168], uint16_t out[112],
                                     expdf_mat_result *r)
{
    const uint32x4_t o0 = vld1q_u32(expdf_off0);
    const uint32x4_t o1 = vld1q_u32(expdf_off1);
    const uint32x4_t o2 = vld1q_u32(expdf_off2);
    const uint32x4_t mask12 = vdupq_n_u32(0x0fffu);
    const uint32x4_t q = vdupq_n_u32(EXPDF_Q);
    const uint32x4_t rejected = vdupq_n_u32(0xffffffffu);
    uint32_t spill0[4] __attribute__((aligned(16)));
    uint32_t spill1[4] __attribute__((aligned(16)));

    r->count = 0u;
    r->acc = 0x6a09e667u;
    for (uint32_t i = 0u; i < 168u; i += 12u) {
        const uint8_t *src = buf + i;
        uint32x4_t b0 = vldrbq_gather_offset_u32(src, o0);
        uint32x4_t b1 = vldrbq_gather_offset_u32(src, o1);
        uint32x4_t b2 = vldrbq_gather_offset_u32(src, o2);
        uint32x4_t w = vorrq_u32(b0, vorrq_u32(vshlq_n_u32(b1, 8),
                                               vshlq_n_u32(b2, 16)));
        uint32x4_t x0 = vandq_u32(w, mask12);
        uint32x4_t x1 = vandq_u32(vshrq_n_u32(w, 12), mask12);
        x0 = vpselq_u32(x0, rejected, vcmphiq_u32(q, x0));
        x1 = vpselq_u32(x1, rejected, vcmphiq_u32(q, x1));
        vstrwq_u32(spill0, x0);
        vstrwq_u32(spill1, x1);
        for (uint32_t j = 0u; j < 4u; j++) {
            if (spill0[j] != 0xffffffffu) expdf_mat_accept(spill0[j], out, r);
            if (spill1[j] != 0xffffffffu) expdf_mat_accept(spill1[j], out, r);
        }
    }
}

static void expdf_mat_prepare(void)
{
    static const uint16_t edge[16] = {
        0u, 1u, 3327u, 3328u, 3329u, 3330u, 4094u, 4095u,
        17u, 1024u, 2048u, 3000u, 3328u, 4000u, 19u, 3311u
    };
    for (uint32_t i = 0u; i < 56u; i++) {
        uint32_t x0 = edge[(2u * i) & 15u];
        uint32_t x1 = edge[(2u * i + 1u) & 15u];
        expdf_mat_buf[3u * i] = (uint8_t) x0;
        expdf_mat_buf[3u * i + 1u] = (uint8_t) ((x0 >> 8) | (x1 << 4));
        expdf_mat_buf[3u * i + 2u] = (uint8_t) (x1 >> 4);
    }
    for (uint32_t i = 0u; i < 112u; i++)
        expdf_mat_b[i] = (int16_t) ((int32_t) ((i * 73u + 11u) % 6659u) - 3329);
}

static uint32_t expdf_mat_check(void)
{
    expdf_mat_prepare();
    expdf_mat_scalar(expdf_mat_buf, expdf_mat_out_a, &expdf_mat_ra);
    expdf_mat_mve(expdf_mat_buf, expdf_mat_out_b, &expdf_mat_rb);
    return (uint32_t) (expdf_mat_ra.count != expdf_mat_rb.count)
         + (uint32_t) (expdf_mat_ra.acc != expdf_mat_rb.acc)
         + (uint32_t) (memcmp(expdf_mat_out_a, expdf_mat_out_b,
                              2u * expdf_mat_ra.count) != 0);
}

static void expdf_mat_measure(void)
{
    for (uint32_t r = 0u; r < REP_N; r++) {
        if ((r & 1u) == 0u) {
            expdf_timer_start(); expdf_mat_scalar(expdf_mat_buf, expdf_mat_out_a, &expdf_mat_ra); rep_cyc[0][r] = expdf_timer_stop();
            expdf_timer_start(); expdf_mat_mve(expdf_mat_buf, expdf_mat_out_b, &expdf_mat_rb);    rep_cyc[1][r] = expdf_timer_stop();
        } else {
            expdf_timer_start(); expdf_mat_mve(expdf_mat_buf, expdf_mat_out_b, &expdf_mat_rb);    rep_cyc[1][r] = expdf_timer_stop();
            expdf_timer_start(); expdf_mat_scalar(expdf_mat_buf, expdf_mat_out_a, &expdf_mat_ra); rep_cyc[0][r] = expdf_timer_stop();
        }
    }
    expdf_sink ^= expdf_mat_ra.acc ^ expdf_mat_rb.acc;
}

static void expdf_run_all(void)
{
    uint32_t mm1, mm2, mm3, mm4;
    dwt_setup();
    mm1 = expdf_cswap_check();
    mm2 = expdf_fe_check();
    mm3 = expdf_keccak_check();
    mm4 = expdf_mat_check();
    uart_puts("expDF correctness cswap="); uart_put_u32(mm1);
    uart_puts(" batch="); uart_put_u32(mm2);
    uart_puts(" keccak="); uart_put_u32(mm3);
    uart_puts(" matacc="); uart_put_u32(mm4);
    uart_puts("\n");
    harness_fails += mm1 + mm2 + mm3 + mm4;

    expdf_cswap_measure(); expdf_print_pair("DF1-cswap", 256u);
    expdf_fe_measure();    expdf_print_pair("DF2-batch", 1u);
    expdf_keccak_measure();expdf_print_pair("DF3-keccak", 1u);
    expdf_mat_measure();   expdf_print_pair("DF4-matacc", 1u);

    uart_puts((mm1 + mm2 + mm3 + mm4) == 0u
              ? "expDF CORRECTNESS GATE PASS\n" : "expDF CORRECTNESS GATE FAIL\n");
}

#undef EXPDF_Q
#undef EXPDF_RHO_STEP
#undef EXPDF_ROL64_CONST
#undef EXPDF_DTCM
#undef EXPDF_TEXT
