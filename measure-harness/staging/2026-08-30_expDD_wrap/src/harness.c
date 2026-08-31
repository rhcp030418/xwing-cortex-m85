/* EK-RA8M1 ?듯빀 ?섎꽕?? KAT(ex2+ex3) + 1?④퀎 DWT/PMU 痢≪젙
 *
 * measure-harness/main.c??蹂대뱶 ?ы똿??(README "蹂대뱶 ?ы똿" ?덉감).
 * uart_* ??RAM 濡쒓렇 踰꾪띁濡?援먯껜: ?몄뒪?멸? pylink(J-Link)濡??щ낵 二쇱냼?먯꽌
 * log_buf/log_len/harness_done??吏곸젒 ?쎌뼱媛꾨떎. UART/RTT 遺덊븘??
 *
 * 二쇱쓽: 肄붾뱶쨌?곗씠??ITCM/DTCM 諛곗튂? ?대줉 怨좎젙? ?꾩쭅 ????寃뚯씠??痢≪젙_怨꾪쉷?? * ?ъ쟾 ?깅줉媛믪? ?ㅼ쓬 ?④퀎). ?ㅻ뒛 ?섏튂??"蹂대뱶?먯꽌 移댁슫?곌? ?ㅼ젣濡??덈떎" 寃利앹슜.
 */
#include <stdint.h>
#include <string.h>
#include "hal_data.h"
#include "keccak/fips202.h"
#include "mlkem/api.h"
#include "mlkem/poly.h"
#include "keccakx4.h"
#include "fiat_x25519.h"
#include "expw_vectors.h"

extern volatile uint32_t g_keccak_perm_calls;   /* keccak/fips202.c 吏묎퀎 移댁슫??*/
extern volatile uint32_t mlkem_ntt_mode;
extern volatile uint32_t mlkem_ntt_alignment_offsets;
extern volatile uint32_t mlkem_invntt_mode;
extern volatile uint32_t mlkem_invntt_alignment_offsets;
extern volatile uint32_t mlkem_invntt_observe;
extern volatile int32_t mlkem_invntt_input_min;
extern volatile int32_t mlkem_invntt_input_max;
extern void PQCLEAN_randombytes_reset(uint32_t seed);
extern int PQCLEAN_randombytes(uint8_t *output, size_t n);

#ifndef ARM_PMU_CHAIN
#define ARM_PMU_CHAIN 0x001EU
#endif

extern void KeccakF1600_StatePermute(uint64_t *state);
extern void curve25519_scalarmult(unsigned char result[32],
                                  const unsigned char scalar[32],
                                  const unsigned char point[32]);

/* ---- ?몄뒪???뚯닔???щ낵 (static 湲덉?: nm?쇰줈 二쇱냼瑜?李얜뒗?? ---- */
volatile uint32_t harness_done  = 0;   /* 1 = 痢≪젙源뚯? ?꾨즺 */
volatile uint32_t harness_fails = 0;   /* KAT ?ㅽ뙣 ??*/
volatile uint32_t log_len = 0;
char log_buf[8192];

/* ---- uart_* ?명꽣?섏씠?ㅻ? 濡쒓렇 踰꾪띁濡?援ы쁽 (main.c 蹂몃Ц 臾댁닔???댁떇?? ---- */
static void uart_putc(char c)
{
    if (log_len < sizeof(log_buf) - 1) { log_buf[log_len++] = c; log_buf[log_len] = 0; }
}
static void uart_puts(const char *s) { while (*s) uart_putc(*s++); }
static void uart_put_u32(uint32_t v)
{
    char t[10]; int i = 0;
    do { t[i++] = (char)('0' + v % 10u); v /= 10u; } while (v);
    while (i--) uart_putc(t[i]);
}
static void uart_put_i32(int32_t v)
{
    if (v < 0) {
        uart_putc('-');
        uart_put_u32((uint32_t) (-(int64_t) v));
    } else {
        uart_put_u32((uint32_t) v);
    }
}
static void uart_put_hex_bytes(const uint8_t *p, unsigned n)
{
    static const char h[] = "0123456789abcdef";
    for (unsigned i = 0; i < n; i++) { uart_putc(h[p[i] >> 4]); uart_putc(h[p[i] & 0xF]); }
}

/* ================= KAT (ex2_x25519_main.c + ex3_keccak_main.c ?댁떇) ============ */

static const uint8_t alice_sk[32] = {
    0x77, 0x07, 0x6d, 0x0a, 0x73, 0x18, 0xa5, 0x7d, 0x3c, 0x16, 0xc1, 0x72, 0x51, 0xb2, 0x66, 0x45,
    0xdf, 0x4c, 0x2f, 0x87, 0xeb, 0xc0, 0x99, 0x2a, 0xb1, 0x77, 0xfb, 0xa5, 0x1d, 0xb9, 0x2c, 0x2a,
};
static const uint8_t alice_pk[32] = {
    0x85, 0x20, 0xf0, 0x09, 0x89, 0x30, 0xa7, 0x54, 0x74, 0x8b, 0x7d, 0xdc, 0xb4, 0x3e, 0xf7, 0x5a,
    0x0d, 0xbf, 0x3a, 0x0d, 0x26, 0x38, 0x1a, 0xf4, 0xeb, 0xa4, 0xa9, 0x8e, 0xaa, 0x9b, 0x4e, 0x6a,
};
static const uint8_t bob_sk[32] = {
    0x5d, 0xab, 0x08, 0x7e, 0x62, 0x4a, 0x8a, 0x4b, 0x79, 0xe1, 0x7f, 0x8b, 0x83, 0x80, 0x0e, 0xe6,
    0x6f, 0x3b, 0xb1, 0x29, 0x26, 0x18, 0xb6, 0xfd, 0x1c, 0x2f, 0x8b, 0x27, 0xff, 0x88, 0xe0, 0xeb,
};
static const uint8_t bob_pk[32] = {
    0xde, 0x9e, 0xdb, 0x7d, 0x7b, 0x7d, 0xc1, 0xb4, 0xd3, 0x5b, 0x61, 0xc2, 0xec, 0xe4, 0x35, 0x37,
    0x3f, 0x83, 0x43, 0xc8, 0x5b, 0x78, 0x67, 0x4d, 0xad, 0xfc, 0x7e, 0x14, 0x6f, 0x88, 0x2b, 0x4f,
};
static const uint8_t shared_k[32] = {
    0x4a, 0x5d, 0x9d, 0x5b, 0xa4, 0xce, 0x2d, 0xe1, 0x72, 0x8e, 0x3b, 0xf4, 0x80, 0x35, 0x0f, 0x25,
    0xe0, 0x7e, 0x21, 0xc9, 0x47, 0xd1, 0x9e, 0x33, 0x76, 0xf0, 0x9b, 0x3c, 0x1e, 0x16, 0x17, 0x42,
};
static const uint8_t basepoint[32] = { 9 };
static const uint8_t d_empty[32] = {
    0xa7, 0xff, 0xc6, 0xf8, 0xbf, 0x1e, 0xd7, 0x66, 0x51, 0xc1, 0x47, 0x56, 0xa0, 0x61, 0xd6, 0x62,
    0xf5, 0x80, 0xff, 0x4d, 0xe4, 0x3b, 0x49, 0xfa, 0x82, 0xd8, 0x0a, 0x4b, 0x80, 0xf8, 0x43, 0x4a,
};
static const uint8_t d_abc[32] = {
    0x3a, 0x98, 0x5d, 0xa7, 0x4f, 0xe2, 0x25, 0xb2, 0x04, 0x5c, 0x17, 0x2d, 0x6b, 0xd3, 0x90, 0xbd,
    0x85, 0x5f, 0x08, 0x6e, 0x3e, 0x9d, 0x52, 0x5b, 0x46, 0xbf, 0xe2, 0x45, 0x11, 0x43, 0x15, 0x32,
};

static void clamp(uint8_t k[32]) { k[0] &= 248; k[31] &= 127; k[31] |= 64; }

static int check(const char *name, const uint8_t got[32], const uint8_t want[32])
{
    uart_puts(name);
    if (memcmp(got, want, 32) == 0) { uart_puts(": OK\n"); return 0; }
    uart_puts(": FAIL\n  got  "); uart_put_hex_bytes(got, 32); uart_puts("\n");
    return 1;
}

static uint32_t kat_run(void)
{
    uint8_t sk[32], out[32], h[32];
    uint32_t fails = 0;

    uart_puts("== KAT: X25519 (RFC 7748 s6.1) ==\n");
    memcpy(sk, alice_sk, 32); clamp(sk);
    curve25519_scalarmult(out, sk, basepoint);
    fails += (uint32_t)check("alice_pk", out, alice_pk);
    memcpy(sk, bob_sk, 32); clamp(sk);
    curve25519_scalarmult(out, sk, basepoint);
    fails += (uint32_t)check("bob_pk  ", out, bob_pk);
    memcpy(sk, alice_sk, 32); clamp(sk);
    curve25519_scalarmult(out, sk, bob_pk);
    fails += (uint32_t)check("K(a,B)  ", out, shared_k);
    memcpy(sk, bob_sk, 32); clamp(sk);
    curve25519_scalarmult(out, sk, alice_pk);
    fails += (uint32_t)check("K(b,A)  ", out, shared_k);

    uart_puts("== KAT: SHA3-256 via asm Keccak-f1600 ==\n");
    sha3_256(h, (const uint8_t *)"", 0);
    fails += (uint32_t)check("sha3(\"\")   ", h, d_empty);
    sha3_256(h, (const uint8_t *)"abc", 3);
    fails += (uint32_t)check("sha3(\"abc\")", h, d_abc);
    return fails;
}

/* ================= 痢≪젙 (measure-harness/main.c 洹몃?濡? ======================= */

static const struct { uint32_t id; const char *name; } PAIR[4] = {
    { ARM_PMU_INST_RETIRED,      "insts        " },
    { ARM_PMU_STALL_OP,          "stall_op     " },
    { ARM_PMU_STALL_OP_FRONTEND, "stall_op_fe  " },
    { ARM_PMU_STALL_OP_BACKEND,  "stall_op_be  " },
};

static void pmu_setup(void)
{
    /* RA8/M85: Secure ?곹깭 ?대깽?몃뒗 SecureNoninvasiveDebug ?덇? ?놁씠??移댁슫??????
       ?붾쾭嫄곕컻 DAUTHCTRL ?곌린??臾댁떆(RAZ/WI)??CPU(Secure ?밴텒)?먯꽌 ?대? ?ㅻ쾭?쇱씠?쒕? 耳좊떎.
       0xF = SPIDENSEL|INTSPIDEN|SPNIDENSEL|INTSPNIDEN */
    DCB->DAUTHCTRL |= 0xFu;
    uart_puts("DAUTHCTRL readback: "); uart_put_u32(DCB->DAUTHCTRL); uart_puts("\n\n");
    ARM_PMU_Enable();
    for (uint32_t p = 0; p < 4; p++) {
        ARM_PMU_Set_EVTYPER(2u * p,      PAIR[p].id);
        ARM_PMU_Set_EVTYPER(2u * p + 1u, ARM_PMU_CHAIN);
    }
}

static void dwt_setup(void)
{
    CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;
    DWT->CTRL |= DWT_CTRL_CYCCNTENA_Msk;
}

static void perf_start(void)
{
    ARM_PMU_CNTR_Disable(0xFFFFFFFFu);
    ARM_PMU_EVCNTR_ALL_Reset();
    ARM_PMU_CYCCNT_Reset();
    DWT->CYCCNT = 0;
    __DSB(); __ISB();
    ARM_PMU_CNTR_Enable((1UL << 31) | 0xFFu);
}

static uint32_t pair_read(uint32_t p)
{
    return (ARM_PMU_Get_EVCNTR(2u * p + 1u) << 16) | ARM_PMU_Get_EVCNTR(2u * p);
}

static void perf_stop_report(const char *label, uint32_t reps)
{
    uint32_t dwt_cyc;
    __DSB(); __ISB();
    dwt_cyc = DWT->CYCCNT;
    ARM_PMU_CNTR_Disable(0xFFFFFFFFu);
    uint32_t pmu_cyc = ARM_PMU_Get_CCNTR();

    uart_puts("["); uart_puts(label); uart_puts("] x"); uart_put_u32(reps); uart_puts("\n");
    uart_puts("  dwt_cyc/op   : "); uart_put_u32(dwt_cyc / reps); uart_puts("\n");
    uart_puts("  pmu_cyc/op   : "); uart_put_u32(pmu_cyc / reps); uart_puts("\n");
    for (uint32_t p = 0; p < 4; p++) {
        uart_puts("  "); uart_puts(PAIR[p].name); uart_puts(": ");
        uart_put_u32(pair_read(p) / reps); uart_puts("\n");
    }
    if (pmu_cyc != 0) {
        uint64_t insts = pair_read(0), stall_op = pair_read(1);
        uart_puts("  IPC x100     : "); uart_put_u32((uint32_t)(insts * 100u / pmu_cyc)); uart_puts("\n");
        uart_puts("  slot-waste % : "); uart_put_u32((uint32_t)(stall_op * 100u / (2ull * pmu_cyc))); uart_puts("\n");
    } else {
        uart_puts("  (counters read 0 -- unexpected on board)\n");
    }
    uart_puts("\n");
}

/* ---- 痢≪젙 ?꾩깮 (寃뚯씠??痢≪젙_怨꾪쉷??짠7): ?곗씠?걔룹뒪?앹쓣 DTCM(0-wait)??----
 * 肄붾뱶媛 ITCM???덉뼱???ㅽ깮쨌?곹깭 諛곗뿴???쇰컲 SRAM?대㈃ ?湲??ъ씠?댁씠 ?ㅼ뿼?쒗궓??
 * (.dtcm ?뱀뀡 = FSP媛 遺????0?쇰줈 珥덇린?? */
static uint64_t st[25] __attribute__((section(".dtcm")));
static unsigned char bench_out[32] __attribute__((section(".dtcm")));
static uint8_t dtcm_stack[15360] __attribute__((aligned(8), section(".dtcm")));   /* ML-KEM m4fspeed ?ㅽ깮 ??KB */
static const unsigned char bench_scalar[32] = { 0xa5, 0x46, 0xe3, 0x6b, 0xf0, 0x52, 0x7c, 0x9d,
                                                0x3b, 0x16, 0x15, 0x4b, 0x82, 0x46, 0x5e, 0xdd,
                                                0x62, 0x14, 0x4c, 0x0a, 0xc1, 0xfc, 0x5a, 0x18,
                                                0x50, 0x6a, 0x22, 0x44, 0xba, 0x44, 0x9a, 0xc4 };

/* 痢≪젙 援ш컙??DTCM ?ㅽ깮 ?꾩뿉???ㅽ뻾 (naked: 而댄뙆?쇰윭媛 ???ㅽ깮????嫄대뱶由ш쾶).
 * FSP媛 MSPLIM(v8-M ?ㅽ깮 ?섑븳)??硫붿씤 ?ㅽ깮??嫄몄뼱?먮?濡? DTCM?쇰줈 SP瑜???린湲??꾩뿉
 * MSPLIM??0?쇰줈 ?대졇?ㅺ? 蹂듦? ???섎룎由곕떎 ????洹몃윭硫?STKOF UsageFault. */
__attribute__((naked)) static void run_on_stack(void (*fn)(void), void *stack_top)
{
    (void)fn; (void)stack_top;
    __asm volatile ("push {r4, r5, lr}\n"
                    "mrs r4, msplim\n"
                    "movs r5, #0\n"
                    "msr msplim, r5\n"
                    "mov r5, sp\n"
                    "mov sp, r1\n"
                    "blx r0\n"
                    "mov sp, r5\n"
                    "msr msplim, r4\n"
                    "pop {r4, r5, pc}\n");
}

static void bench_keccak(void)
{
    for (uint32_t i = 0; i < 1000; i++) KeccakF1600_StatePermute(st);
}

static void bench_x25519(void)
{
    for (uint32_t i = 0; i < 10; i++) curve25519_scalarmult(bench_out, bench_scalar, basepoint);
}

/* ---- 寃뚯씠??痢≪젙_怨꾪쉷??짠6.2: 而ㅻ꼸蹂?N=100 諛섎났, per-rep DWT ?ъ씠??湲곕줉 ----
 * ?몄뒪??harvest)媛 諛곗뿴???쎌뼱 以묒븰媛뮻룹턀?뙿룹턀? 怨꾩궛. calib(痢≪젙 ?ㅻ쾭?ㅻ뱶)?? * rep_cyc[2][0..N-1]??鍮?援ш컙?쇰줈 媛숈씠 湲곕줉 ???댁꽍 ??李④컧. */
#define REP_N 100
/* [0]=keccak [1]=x25519 [2]=calib [3]=mlkem-keygen [4]=encaps [5]=decaps [6]=combiner-sha3
 * [7]=stitch-A(mul) [8]=stitch-B(logic) [9]=stitch-S(interleaved) ???⑹꽦 ?ㅽ떚移??ㅽ뿕
 * [10]=stitch-B'(mem) [11]=stitch-S'(interleaved-mem) ???ㅽ뿕 2: 硫붾え由??곸＜ ?ㅽ듃由? * [12]=mul256-full [13]=mul256-budget(r8-r11 ?덉빟) ???ㅽ뿕 3: A-?멸툑
 * [14]=mul256-flat [15]=theta-frag [16]=stitched ???ㅽ뿕 4: 吏꾩쭨 吏???ㅽ떚移? * [17]=round-frag [18]=stitched-round ???ㅽ뿕 5: ?꾩껜 Keccak ?쇱슫???щ떎由? * [19]=mul256-flat6 [20]=round6-frag [21]=stitched-round6 ???ㅽ뿕 6: ?덉궛 ?ㅼ쐲
 * [22]=stitched-k2 (怨콂2 횞 round6) ???ㅽ뿕 7: k-?ㅼ쐲
 * [23]=slothy-seq [24]=slothy-opt ??3?④퀎 ?ㅽ뿕 A 蹂대뱶 寃利? * [25]=bmid-seq [26]=bmid-zip [27]=bmid-slothy ???ㅽ뿕 B-mid 3?뚯쟾
 * [28]=bfull-seq [29]=bfull-zip [30]=bfull-slothy ???꾩껜 洹쒕え 3?뚯쟾
 * [31]=expc-seq [32]=expc-slothy ???ㅽ뿕 C: 吏꾩쭨 fiat ?꾨뱶 怨?횞 round6
 * [33]=expd-seq [34]=expd-slothy ???ㅽ뿕 D: fiat 횞 鍮꾪듃-?명꽣由щ툕 ?쇱슫?? * [35]=expe-seq [36]=expe-slothy ???ㅽ뿕 E: 4?④퀎 鍮꾩쑉 肄붿뼱 (怨궁? + ?쇱슫??
 * [37]=mve4-round ???뚮옖 B: 4-way MVE Keccak ?쇱슫?? * [38]=coissue-A(?ㅼ뭡?쇱껜?? [39]=coissue-zip ???ㅽ뿕 F: ?ㅼ뭡?셌뾏VE 肄붿씠?? * [40]=coissue-slothy ???ㅽ뿕 F-solver: SLOTHY ?ㅼ?以?(紐⑤뜽 v0.3) */
/* [41]=mve3-round [42]=coissue3-zip ???ㅽ뿕 G: 3-踰좎씠??Lenngren ?묐낫 3媛??덉궛)
 * [43]=pack+unpack ?뺣났 ???ㅽ뿕 H: 4-way ?덉씤 ?꾩튂 湲猷?鍮꾩슜
 * [44]=fiat-base [45]=fiat-yield3 ???ㅽ뿕 I: 3-?덉??ㅽ꽣 ?묐낫 ?멸툑
 * [46]=mve2-round [47]=coissue2-zip [48]=fiat-yield2 ??v0.4: 2-踰좎씠???묐낫 2媛?
 * [49]=expj-seq [50]=expj-stitch ???ㅽ뿕 J: 吏꾩쭨 fiat 怨?횞 MVE ?쇱슫???듯빀 3?뚯쟾
 * [51]=expk-seq [52]=expk-coarse [53]=expk-stitch ???ㅽ뿕 K: ?議곌뎔 3醫?怨?+?쇱슫??)
 * [54]=expl-ntt [55]=expl-zip [56]=expl-sntt [57]=expl-szip ???ㅽ뿕 L: NTT 吏??議? * [58]=expj-stitch-alt ???곸닔?쒓컙 ?ㅼ쬆: ?낅젰 2踰?援먯감(遺꾪룷媛 ?낅젰 臾닿??댁뼱??
 * [59]=expm-seq [60]=expm-stitch ???ㅽ뿕 M: encaps ?ㅻ퉬??怨?:?쇱슫??) 留ㅽ겕濡??좊떅
 * [61]=expm4-seq [62]=expm4-stitch ??keygen/decaps 鍮꾩쑉(怨?:?쇱슫??)
 * [92]=expj-stitch2 [93]=expq-stitch2 ???ㅽ뿕 R: A-pair 吏?? * [94]=expm-stitch2 [95]=expm4-stitch2 ???ㅽ뿕 S: ?ㅼ젣 鍮꾩쑉 A-pair 吏?? * [96]=expt-fiat [97]=expt-b0 [98]=expt-seq [99]=expt-stitch
 * [100]=expt-m8-seq [101]=expt-m8-stitch [102]=expt-m4-seq [103]=expt-m4-stitch
 * ???ㅽ뿕 T: b0 + GP 臾댁뼇蹂?fiat
 * [104..126]=?ㅽ뿕 U: yield1 + one-GP b1(?곗냽 ?듭빱 1媛?+ q7 gather)
 * [127]=?꾩옱 poly_ntt [128]=?꾩옱 poly_invntt ???ㅽ뿕 V NTT attribution
 * [129..132]=pqmx M85 forward 4醫?[133]=pqmx M55 inverse [134]=rev4 蹂?? * [135]=pqmx WIP M85 inverse ???ㅽ뿕 W
 * [136..138]=?ㅽ뿕 X AB??candidate, [139..141]=BA??candidate,
 * [142..144]=BA??baseline ???숈씪 ?⑥닔쨌?숈씪 RNG stream쨌??닚 ?議? * [145..147]=?ㅽ뿕 Y AB baseline, [148..150]=AB candidate,
 * [151..153]=BA candidate, [154..156]=BA baseline
 * [157..159]=?ㅽ뿕 Z AB baseline, [160..162]=AB candidate,
 * [163..165]=BA candidate, [166..168]=BA baseline */
#include "k31_libc.inc"

#define REP_SLOTS 775
volatile uint32_t rep_cyc[REP_SLOTS][REP_N];

/* 二쇱쓽: v8.1-M?먯꽌 DWT CYCCNT ??PMU CCNTR(媛숈? 移댁슫??. 吏곸쟾 perf_stop??PMU 移댁슫?곕?
 * disable???곹깭?먯꽌??CYCCNT=0 ?곌린媛 臾댁떆?섎뒗 寃껋쓣 ?ㅼ륫?쇰줈 ?뺤씤(2026-08-16) ?? * rep 痢≪젙 ?쒖옉? perf_start()(PMU ?ы솢???ы븿)瑜?洹몃?濡??ъ슜?쒕떎. */
static inline void     dwt_span_begin(void) { perf_start(); }
static inline uint32_t dwt_span_end(void)   { __DSB(); __ISB(); return DWT->CYCCNT; }

static void bench_keccak_reps(void)
{
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        KeccakF1600_StatePermute(st);
        rep_cyc[0][r] = dwt_span_end();
    }
}

static void bench_x25519_reps(void)
{
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        curve25519_scalarmult(bench_out, bench_scalar, basepoint);
        rep_cyc[1][r] = dwt_span_end();
    }
}

static void bench_calib_reps(void)
{
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        rep_cyc[2][r] = dwt_span_end();
    }
}

/* ---- K3: ML-KEM-768 (pqm4 m4fspeed) + K4 寃고빀湲?---- */
static uint8_t mk_pk[CRYPTO_PUBLICKEYBYTES] __attribute__((section(".dtcm")));
static uint8_t mk_sk[CRYPTO_SECRETKEYBYTES] __attribute__((section(".dtcm")));
static uint8_t mk_ct[CRYPTO_CIPHERTEXTBYTES] __attribute__((section(".dtcm")));
static uint8_t mk_ss_e[CRYPTO_BYTES] __attribute__((section(".dtcm")));
static uint8_t mk_ss_d[CRYPTO_BYTES] __attribute__((section(".dtcm")));
/* X-Wing 寃고빀湲??낅젰: label(6)+ss_M(32)+ss_X(32)+ct_X(32)+pk_X(32) = 134B (SHA3-256 1釉붾줉) */
static uint8_t comb_in[134] __attribute__((section(".dtcm")));
static uint8_t comb_out[32] __attribute__((section(".dtcm")));

#define XWING_PUBLICKEYBYTES  (CRYPTO_PUBLICKEYBYTES + 32u)
#define XWING_SECRETKEYBYTES  (CRYPTO_SECRETKEYBYTES + 64u)
#define XWING_CIPHERTEXTBYTES (CRYPTO_CIPHERTEXTBYTES + 32u)
static uint8_t xw_pk[XWING_PUBLICKEYBYTES] __attribute__((section(".dtcm")));
static uint8_t xw_sk[XWING_SECRETKEYBYTES] __attribute__((section(".dtcm")));
static uint8_t xw_ct[XWING_CIPHERTEXTBYTES] __attribute__((section(".dtcm")));
static uint8_t xw_ss_e[32] __attribute__((section(".dtcm")));
static uint8_t xw_ss_d[32] __attribute__((section(".dtcm")));
static uint8_t xw_ref_pk[XWING_PUBLICKEYBYTES] __attribute__((section(".dtcm")));
static uint8_t xw_ref_sk[XWING_SECRETKEYBYTES] __attribute__((section(".dtcm")));
static uint8_t xw_ref_ct[XWING_CIPHERTEXTBYTES] __attribute__((section(".dtcm")));
static uint8_t xw_ref_ss_e[32] __attribute__((section(".dtcm")));
static uint8_t xw_ref_ss_d[32] __attribute__((section(".dtcm")));
static uint8_t xw_ref_reject[32] __attribute__((section(".dtcm")));

static uint8_t expx_ref_pk[CRYPTO_PUBLICKEYBYTES] __attribute__((section(".dtcm")));
static uint8_t expx_ref_sk[CRYPTO_SECRETKEYBYTES] __attribute__((section(".dtcm")));
static uint8_t expx_ref_ct[CRYPTO_CIPHERTEXTBYTES] __attribute__((section(".dtcm")));
static uint8_t expx_ref_ss_e[CRYPTO_BYTES] __attribute__((section(".dtcm")));
static uint8_t expx_ref_ss_d[CRYPTO_BYTES] __attribute__((section(".dtcm")));
static uint8_t expy_ref_reject[CRYPTO_BYTES] __attribute__((section(".dtcm")));

volatile uint32_t mlkem_smoke_fails = 9;   /* 9 = ?꾩쭅 ???뚯쓬 */
volatile uint32_t kc_keygen, kc_encaps, kc_decaps, kc_combiner;   /* ?곗궛蹂?keccak ?쒖뿴 ?몄텧 ??*/
volatile uint32_t expx_byte_mismatch = 9;
volatile uint32_t expx_smoke_fails = 9;
volatile uint32_t expx_timing_mismatch = 9;
volatile uint32_t expx_stack_canary_fails = 9;
volatile uint32_t expx_stack_highwater = 0;
volatile uint32_t expx_align_baseline = 0;
volatile uint32_t expx_align_candidate = 0;
volatile uint32_t expy_byte_mismatch = 9;
volatile uint32_t expy_smoke_fails = 9;
volatile uint32_t expy_align_baseline = 0;
volatile uint32_t expy_align_candidate = 0;
volatile int32_t expy_input_min = 32767;
volatile int32_t expy_input_max = -32768;
volatile uint32_t expy_timing_mismatch = 9;
volatile uint32_t expy_stack_canary_fails = 9;
volatile uint32_t expy_stack_highwater = 0;
volatile uint32_t expz_byte_mismatch = 9;
volatile uint32_t expz_smoke_fails = 9;
volatile uint32_t expz_timing_mismatch = 9;
volatile uint32_t expz_stack_canary_fails = 9;
volatile uint32_t expz_stack_highwater = 0;
volatile uint32_t expz_fwd_align_baseline = 0;
volatile uint32_t expz_fwd_align_candidate = 0;
volatile uint32_t expz_inv_align_baseline = 0;
volatile uint32_t expz_inv_align_candidate = 0;
volatile uint32_t expaa_byte_mismatch = 9;
volatile uint32_t expaa_smoke_fails = 9;
volatile uint32_t expaa_timing_mismatch = 9;
volatile uint32_t expaa_stack_canary_fails = 9;
volatile uint32_t expaa_stack_highwater = 0;
volatile uint32_t expaa_fwd_align_baseline = 0;
volatile uint32_t expaa_fwd_align_candidate = 0;
volatile uint32_t expab_byte_mismatch = 9;
volatile uint32_t expab_smoke_fails = 9;
volatile uint32_t expab_timing_mismatch = 9;
volatile uint32_t expab_stack_canary_fails = 9;
volatile uint32_t expab_stack_highwater = 0;
volatile uint32_t expac_byte_mismatch = 9;
volatile uint32_t expac_smoke_fails = 9;
volatile uint32_t expac_x4_kat_fails = 9;
volatile uint32_t expac_u_kat_fails = 9;
volatile uint32_t expac_timing_mismatch = 9;
volatile uint32_t expac_stack_canary_fails = 9;
volatile uint32_t expac_stack_highwater = 0;

static uint32_t byte_mismatches(const uint8_t *a, const uint8_t *b, uint32_t n)
{
    uint32_t mismatch = 0;
    for (uint32_t i = 0; i < n; i++) mismatch += (a[i] != b[i]);
    return mismatch;
}

static void xwing_combine(uint8_t out[32], const uint8_t ss_m[32],
                          const uint8_t ss_x[32], const uint8_t ct_x[32],
                          const uint8_t pk_x[32])
{
    static const uint8_t label[6] = {'\\', '.', '/', '/', '^', '\\'};
    memcpy(comb_in, label, sizeof(label));
    memcpy(comb_in + 6, ss_m, 32);
    memcpy(comb_in + 38, ss_x, 32);
    memcpy(comb_in + 70, ct_x, 32);
    memcpy(comb_in + 102, pk_x, 32);
    sha3_256(out, comb_in, sizeof(comb_in));
}

/* 실험 AV/AT-3: X06 fixed-base 토글.  0 = 현행 ladder, 1 = comb.
 * 적용 지점은 keygen pkX 와 encaps ctX 두 곳뿐이며 variable-base 는 손대지 않는다. */
volatile uint32_t mlkem_x06_mode = 0;
extern void curve25519_scalarmult_base(uint8_t out[32], const uint8_t scalar[32]);

static void xwing_keypair(uint8_t pk[XWING_PUBLICKEYBYTES],
                          uint8_t sk[XWING_SECRETKEYBYTES])
{
    crypto_kem_keypair(pk, sk);
    (void) PQCLEAN_randombytes(sk + CRYPTO_SECRETKEYBYTES, 32);
    clamp(sk + CRYPTO_SECRETKEYBYTES);
    /* X06 채택(expBI): 무조건 fixed-base comb. */
    curve25519_scalarmult_base(pk + CRYPTO_PUBLICKEYBYTES,
                               sk + CRYPTO_SECRETKEYBYTES);
    memcpy(sk + CRYPTO_SECRETKEYBYTES + 32,
           pk + CRYPTO_PUBLICKEYBYTES, 32);
}

static void xwing_enc(uint8_t ct[XWING_CIPHERTEXTBYTES], uint8_t ss[32],
                      const uint8_t pk[XWING_PUBLICKEYBYTES])
{
    uint8_t ss_m[32], ss_x[32], ephemeral[32];
    crypto_kem_enc(ct, ss_m, pk);
    (void) PQCLEAN_randombytes(ephemeral, sizeof(ephemeral));
    clamp(ephemeral);
    curve25519_scalarmult_base(ct + CRYPTO_CIPHERTEXTBYTES, ephemeral);
    curve25519_scalarmult(ss_x, ephemeral, pk + CRYPTO_PUBLICKEYBYTES);
    xwing_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  pk + CRYPTO_PUBLICKEYBYTES);
}

static void xwing_dec(uint8_t ss[32], const uint8_t ct[XWING_CIPHERTEXTBYTES],
                      const uint8_t sk[XWING_SECRETKEYBYTES])
{
    uint8_t ss_m[32], ss_x[32];
    crypto_kem_dec(ss_m, ct, sk);
    curve25519_scalarmult(ss_x, sk + CRYPTO_SECRETKEYBYTES,
                         ct + CRYPTO_CIPHERTEXTBYTES);
    xwing_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  sk + CRYPTO_SECRETKEYBYTES + 32);
}

static void mlkem_expx_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;

    mlkem_ntt_mode = 0;
    mlkem_ntt_alignment_offsets = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
    crypto_kem_keypair(mk_pk, mk_sk);
    crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
    crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
    fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
    memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
    memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
    memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
    memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
    memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
    expx_align_baseline = mlkem_ntt_alignment_offsets;

    mlkem_ntt_mode = 1;
    mlkem_ntt_alignment_offsets = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
    crypto_kem_keypair(mk_pk, mk_sk);
    crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
    crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
    mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
    mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
    mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
    mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
    mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
    fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
    mk_ct[0] ^= 1;
    crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
    fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
    mk_ct[0] ^= 1;
    expx_align_candidate = mlkem_ntt_alignment_offsets;

    expx_byte_mismatch = mismatch;
    expx_smoke_fails = fails;
    mlkem_ntt_mode = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
}

/* Experiment Y: X forward is common; only inverse mode changes.  Eight seeds
 * cover real pointwise outputs, and reject secrets are compared as bytes too. */
static void mlkem_expy_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;
    uint32_t align_a = 0;
    uint32_t align_b = 0;

    mlkem_invntt_input_min = 32767;
    mlkem_invntt_input_max = -32768;
    mlkem_invntt_observe = 1;
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0x59590000u + s * 0x00009e37u;

        mlkem_ntt_mode = 1;
        mlkem_invntt_mode = 0;
        mlkem_invntt_alignment_offsets = 0;
        PQCLEAN_randombytes_reset(seed);
        crypto_kem_keypair(mk_pk, mk_sk);
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
        mk_ct[0] ^= 1u;
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
        memcpy(expy_ref_reject, mk_ss_d, sizeof(expy_ref_reject));
        mk_ct[0] ^= 1u;
        align_a |= mlkem_invntt_alignment_offsets;

        mlkem_ntt_mode = 1;
        mlkem_invntt_mode = 1;
        mlkem_invntt_alignment_offsets = 0;
        PQCLEAN_randombytes_reset(seed);
        crypto_kem_keypair(mk_pk, mk_sk);
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
        mk_ct[0] ^= 1u;
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        mismatch += byte_mismatches(mk_ss_d, expy_ref_reject, sizeof(expy_ref_reject));
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
        mk_ct[0] ^= 1u;
        align_b |= mlkem_invntt_alignment_offsets;
    }
    expy_byte_mismatch = mismatch;
    expy_smoke_fails = fails;
    expy_align_baseline = align_a;
    expy_align_candidate = align_b;
    expy_input_min = mlkem_invntt_input_min;
    expy_input_max = mlkem_invntt_input_max;
    mlkem_invntt_observe = 0;
    mlkem_invntt_mode = 0;
    mlkem_ntt_mode = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
}

/* Experiment Z: compare the untouched NTT pair with X+Y enabled together. */
static void mlkem_expz_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;
    uint32_t fwd_align_a = 0;
    uint32_t fwd_align_b = 0;
    uint32_t inv_align_a = 0;
    uint32_t inv_align_b = 0;

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0x5a5a0000u + s * 0x00009e37u;

        mlkem_ntt_mode = 0;
        mlkem_invntt_mode = 0;
        mlkem_ntt_alignment_offsets = 0;
        mlkem_invntt_alignment_offsets = 0;
        PQCLEAN_randombytes_reset(seed);
        crypto_kem_keypair(mk_pk, mk_sk);
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
        mk_ct[0] ^= 1u;
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
        memcpy(expy_ref_reject, mk_ss_d, sizeof(expy_ref_reject));
        mk_ct[0] ^= 1u;
        fwd_align_a |= mlkem_ntt_alignment_offsets;
        inv_align_a |= mlkem_invntt_alignment_offsets;

        mlkem_ntt_mode = 1;
        mlkem_invntt_mode = 1;
        mlkem_ntt_alignment_offsets = 0;
        mlkem_invntt_alignment_offsets = 0;
        PQCLEAN_randombytes_reset(seed);
        crypto_kem_keypair(mk_pk, mk_sk);
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
        mk_ct[0] ^= 1u;
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        mismatch += byte_mismatches(mk_ss_d, expy_ref_reject, sizeof(expy_ref_reject));
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
        mk_ct[0] ^= 1u;
        fwd_align_b |= mlkem_ntt_alignment_offsets;
        inv_align_b |= mlkem_invntt_alignment_offsets;
    }

    expz_byte_mismatch = mismatch;
    expz_smoke_fails = fails;
    expz_fwd_align_baseline = fwd_align_a;
    expz_fwd_align_candidate = fwd_align_b;
    expz_inv_align_baseline = inv_align_a;
    expz_inv_align_candidate = inv_align_b;
    mlkem_invntt_mode = 0;
    mlkem_ntt_mode = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
}

/* Experiment AA: replace X's forward+rev4 with pqmx's current-order kernel. */
static void mlkem_expaa_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;
    uint32_t fwd_align_a = 0;
    uint32_t fwd_align_b = 0;

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xaa000000u + s * 0x00009e37u;

        mlkem_ntt_mode = 1;
        mlkem_invntt_mode = 1;
        mlkem_ntt_alignment_offsets = 0;
        PQCLEAN_randombytes_reset(seed);
        crypto_kem_keypair(mk_pk, mk_sk);
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
        mk_ct[0] ^= 1u;
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
        memcpy(expy_ref_reject, mk_ss_d, sizeof(expy_ref_reject));
        mk_ct[0] ^= 1u;
        fwd_align_a |= mlkem_ntt_alignment_offsets;

        mlkem_ntt_mode = 2;
        mlkem_ntt_alignment_offsets = 0;
        PQCLEAN_randombytes_reset(seed);
        crypto_kem_keypair(mk_pk, mk_sk);
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
        mk_ct[0] ^= 1u;
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        mismatch += byte_mismatches(mk_ss_d, expy_ref_reject, sizeof(expy_ref_reject));
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
        mk_ct[0] ^= 1u;
        fwd_align_b |= mlkem_ntt_alignment_offsets;
    }

    expaa_byte_mismatch = mismatch;
    expaa_smoke_fails = fails;
    expaa_fwd_align_baseline = fwd_align_a;
    expaa_fwd_align_candidate = fwd_align_b;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
}

static void xwing_expab_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xab000000u + s * 0x00009e37u;

        mlkem_ntt_mode = 0;
        mlkem_invntt_mode = 0;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
        xw_ct[0] ^= 1u;
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) == 0);
        memcpy(xw_ref_reject, xw_ss_d, sizeof(xw_ref_reject));
        xw_ct[0] ^= 1u;

        mlkem_ntt_mode = 2;
        mlkem_invntt_mode = 1;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        mismatch += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        mismatch += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        mismatch += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
        mismatch += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        mismatch += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        xw_ct[0] ^= 1u;
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        mismatch += byte_mismatches(xw_ss_d, xw_ref_reject, sizeof(xw_ref_reject));
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) == 0);
        xw_ct[0] ^= 1u;
    }

    expab_byte_mismatch = mismatch;
    expab_smoke_fails = fails;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
}

static uint32_t expac_queue_bad(void)
{
    return x25519_u_queue_pending() + x25519_u_failures();
}

static void xwing_ac_keypair(uint8_t pk[XWING_PUBLICKEYBYTES],
                             uint8_t sk[XWING_SECRETKEYBYTES], uint32_t mode)
{
    const uint32_t use_u = (mode == 1u);
    const uint32_t use_x4 = (mode != 0u);
    const uint32_t use_fiat = (mode == 1u || mode == 3u);
    (void) PQCLEAN_randombytes(sk + CRYPTO_SECRETKEYBYTES, 32);
    clamp(sk + CRYPTO_SECRETKEYBYTES);
    x25519_u_queue_reset();
    if (use_u)
        (void) x25519_u_enqueue(pk + CRYPTO_PUBLICKEYBYTES,
                                sk + CRYPTO_SECRETKEYBYTES, basepoint);
    mlkem_keccakx4_mode = use_x4;
    crypto_kem_keypair(pk, sk);
    if (use_u)
        x25519_u_finish_all();
    else if (use_fiat)
        curve25519_scalarmult_fiat(pk + CRYPTO_PUBLICKEYBYTES,
                                  sk + CRYPTO_SECRETKEYBYTES, basepoint);
    else
        curve25519_scalarmult(pk + CRYPTO_PUBLICKEYBYTES,
                             sk + CRYPTO_SECRETKEYBYTES, basepoint);
    memcpy(sk + CRYPTO_SECRETKEYBYTES + 32,
           pk + CRYPTO_PUBLICKEYBYTES, 32);
    mlkem_keccakx4_mode = 0;
}

static void xwing_ac_enc(uint8_t ct[XWING_CIPHERTEXTBYTES], uint8_t ss[32],
                         const uint8_t pk[XWING_PUBLICKEYBYTES], uint32_t mode)
{
    const uint32_t use_u = (mode == 1u);
    const uint32_t use_x4 = (mode != 0u);
    const uint32_t use_fiat = (mode == 1u || mode == 3u);
    uint8_t ss_m[32], ss_x[32], ephemeral[32];
    (void) PQCLEAN_randombytes(ephemeral, sizeof(ephemeral));
    clamp(ephemeral);
    x25519_u_queue_reset();
    if (use_u) {
        (void) x25519_u_enqueue(ct + CRYPTO_CIPHERTEXTBYTES, ephemeral, basepoint);
        (void) x25519_u_enqueue(ss_x, ephemeral, pk + CRYPTO_PUBLICKEYBYTES);
    }
    mlkem_keccakx4_mode = use_x4;
    crypto_kem_enc(ct, ss_m, pk);
    if (use_u) {
        x25519_u_finish_all();
    } else if (use_fiat) {
        curve25519_scalarmult_fiat(ct + CRYPTO_CIPHERTEXTBYTES,
                                  ephemeral, basepoint);
        curve25519_scalarmult_fiat(ss_x, ephemeral,
                                  pk + CRYPTO_PUBLICKEYBYTES);
    } else {
        curve25519_scalarmult(ct + CRYPTO_CIPHERTEXTBYTES, ephemeral, basepoint);
        curve25519_scalarmult(ss_x, ephemeral, pk + CRYPTO_PUBLICKEYBYTES);
    }
    mlkem_keccakx4_mode = 0;
    xwing_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  pk + CRYPTO_PUBLICKEYBYTES);
}

static void xwing_ac_dec(uint8_t ss[32], const uint8_t ct[XWING_CIPHERTEXTBYTES],
                         const uint8_t sk[XWING_SECRETKEYBYTES], uint32_t mode)
{
    const uint32_t use_u = (mode == 1u);
    const uint32_t use_x4 = (mode != 0u);
    const uint32_t use_fiat = (mode == 1u || mode == 3u);
    uint8_t ss_m[32], ss_x[32];
    x25519_u_queue_reset();
    if (use_u)
        (void) x25519_u_enqueue(ss_x, sk + CRYPTO_SECRETKEYBYTES,
                                ct + CRYPTO_CIPHERTEXTBYTES);
    mlkem_keccakx4_mode = use_x4;
    crypto_kem_dec(ss_m, ct, sk);
    if (use_u)
        x25519_u_finish_all();
    else if (use_fiat)
        curve25519_scalarmult_fiat(ss_x, sk + CRYPTO_SECRETKEYBYTES,
                                  ct + CRYPTO_CIPHERTEXTBYTES);
    else
        curve25519_scalarmult(ss_x, sk + CRYPTO_SECRETKEYBYTES,
                             ct + CRYPTO_CIPHERTEXTBYTES);
    mlkem_keccakx4_mode = 0;
    xwing_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  sk + CRYPTO_SECRETKEYBYTES + 32);
}

static void expac_primitive_kats(void)
{
    uint8_t input[4][34], out[4][200], ref[200];
    uint8_t *o[4] = {out[0], out[1], out[2], out[3]};
    uint32_t x4_fails = 0;
    uint32_t u_fails = 0;

    for (uint32_t s = 0; s < 4; s++)
        for (uint32_t i = 0; i < sizeof(input[s]); i++)
            input[s][i] = (uint8_t) (s * 53u + i * 17u + 3u);

    x25519_u_queue_reset();
    shake128x4(o[0], o[1], o[2], o[3], sizeof(out[0]),
               input[0], input[1], input[2], input[3], sizeof(input[0]));
    for (uint32_t s = 0; s < 4; s++) {
        shake128(ref, sizeof(ref), input[s], sizeof(input[s]));
        x4_fails += byte_mismatches(out[s], ref, sizeof(ref));
    }
    shake256x4(o[0], o[1], o[2], o[3], sizeof(out[0]),
               input[0], input[1], input[2], input[3], sizeof(input[0]));
    for (uint32_t s = 0; s < 4; s++) {
        shake256(ref, sizeof(ref), input[s], sizeof(input[s]));
        x4_fails += byte_mismatches(out[s], ref, sizeof(ref));
    }

    {
        uint8_t scalar[32], xout[32];
        memcpy(scalar, alice_sk, 32); clamp(scalar);
        x25519_u_queue_reset();
        u_fails += (x25519_u_enqueue(xout, scalar, basepoint) != 0);
        shake128x4(o[0], o[1], o[2], o[3], 32,
                   input[0], input[1], input[2], input[3], sizeof(input[0]));
        x25519_u_finish_all();
        u_fails += byte_mismatches(xout, alice_pk, 32) + expac_queue_bad();

        memcpy(scalar, bob_sk, 32); clamp(scalar);
        x25519_u_queue_reset();
        u_fails += (x25519_u_enqueue(xout, scalar, alice_pk) != 0);
        shake128x4(o[0], o[1], o[2], o[3], 32,
                   input[0], input[1], input[2], input[3], sizeof(input[0]));
        x25519_u_finish_all();
        u_fails += byte_mismatches(xout, shared_k, 32) + expac_queue_bad();
    }
    expac_x4_kat_fails = x4_fails;
    expac_u_kat_fails = u_fails;
    x25519_u_queue_reset();
}

static void xwing_expac_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;

    mlkem_ntt_mode = 2;
    mlkem_invntt_mode = 1;
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xac000000u + s * 0x00009e37u;

        PQCLEAN_randombytes_reset(seed);
        xwing_ac_keypair(xw_pk, xw_sk, 0);
        xwing_ac_enc(xw_ct, xw_ss_e, xw_pk, 0);
        xwing_ac_dec(xw_ss_d, xw_ct, xw_sk, 0);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
        xw_ct[0] ^= 1u;
        xwing_ac_dec(xw_ss_d, xw_ct, xw_sk, 0);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) == 0);
        memcpy(xw_ref_reject, xw_ss_d, sizeof(xw_ref_reject));
        xw_ct[0] ^= 1u;

        for (uint32_t mode = 1u; mode <= 3u; mode++) {
            PQCLEAN_randombytes_reset(seed);
            xwing_ac_keypair(xw_pk, xw_sk, mode);
            fails += expac_queue_bad();
            xwing_ac_enc(xw_ct, xw_ss_e, xw_pk, mode);
            fails += expac_queue_bad();
            xwing_ac_dec(xw_ss_d, xw_ct, xw_sk, mode);
            fails += expac_queue_bad();
            mismatch += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
            mismatch += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
            mismatch += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
            mismatch += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
            mismatch += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
            fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
            xw_ct[0] ^= 1u;
            xwing_ac_dec(xw_ss_d, xw_ct, xw_sk, mode);
            mismatch += byte_mismatches(xw_ss_d, xw_ref_reject, sizeof(xw_ref_reject));
            fails += expac_queue_bad();
            fails += (memcmp(xw_ss_e, xw_ss_d, 32) == 0);
            xw_ct[0] ^= 1u;
        }
    }
    expac_byte_mismatch = mismatch;
    expac_smoke_fails = fails;
    mlkem_keccakx4_mode = 0;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
    x25519_u_queue_reset();
    PQCLEAN_randombytes_reset(0x42424242u);
}

static void mlkem_smoke(void)
{
    uint32_t fails = 0;

    g_keccak_perm_calls = 0;
    crypto_kem_keypair(mk_pk, mk_sk);
    kc_keygen = g_keccak_perm_calls;

    g_keccak_perm_calls = 0;
    crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
    kc_encaps = g_keccak_perm_calls;

    g_keccak_perm_calls = 0;
    crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
    kc_decaps = g_keccak_perm_calls;

    if (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0) fails++;

    mk_ct[0] ^= 1;                       /* ?쇱넀 ???붿떆??湲곌컖 ?뺤씤 */
    crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
    if (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0) fails++;
    mk_ct[0] ^= 1;                       /* ?먮났 (decaps 踰ㅼ튂 ?낅젰) */
    crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);

    g_keccak_perm_calls = 0;
    sha3_256(comb_out, comb_in, sizeof(comb_in));
    kc_combiner = g_keccak_perm_calls;

    mlkem_smoke_fails = fails;
}

static volatile uint32_t expx_bench_mode;
static volatile uint32_t expx_bench_slot_base;

/* Baseline/candidate媛 ???⑥닔? ??stack frame??洹몃?濡?怨듭쑀?쒕떎. RNG reset?
 * 痢≪젙 援ш컙 諛뽰씠硫? 留??몄텧留덈떎 ?숈씪 stream???ъ깮?쒕떎. */
static void bench_expx_mode_reps(void)
{
    const uint32_t slot = expx_bench_slot_base;
    mlkem_ntt_mode = expx_bench_mode;
    PQCLEAN_randombytes_reset(0x58585858u);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_keypair(mk_pk, mk_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    if (slot == 3u) {
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
    } else {
        expx_timing_mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        expx_timing_mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        expx_timing_mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        expx_timing_mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        expx_timing_mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
    }
    mlkem_ntt_mode = 0;
}

static void expx_stack_prepare(void)
{
    memset(dtcm_stack, 0xa5, sizeof(dtcm_stack));
    expx_stack_canary_fails = 0;
    expx_stack_highwater = 0;
}

static void expx_stack_check(void)
{
    uint32_t first_used = sizeof(dtcm_stack);
    for (uint32_t i = 0; i < sizeof(dtcm_stack); i++) {
        if (dtcm_stack[i] != 0xa5u) {
            first_used = i;
            break;
        }
    }
    for (uint32_t i = 0; i < 64u; i++) {
        expx_stack_canary_fails += (dtcm_stack[i] != 0xa5u);
    }
    expx_stack_highwater = sizeof(dtcm_stack) - first_used;
}

static volatile uint32_t expy_bench_inv_mode;
static volatile uint32_t expy_bench_slot_base;

/* Y A/B shares this exact function/frame.  Forward mode is fixed to X's
 * candidate, while only the inverse mode changes. */
static void bench_expy_mode_reps(void)
{
    const uint32_t slot = expy_bench_slot_base;
    mlkem_ntt_mode = 1;
    mlkem_invntt_mode = expy_bench_inv_mode;
    mlkem_invntt_observe = 0;
    PQCLEAN_randombytes_reset(0x59595959u);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_keypair(mk_pk, mk_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    if (slot == 145u) {
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
    } else {
        expy_timing_mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        expy_timing_mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        expy_timing_mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        expy_timing_mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        expy_timing_mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
    }
    mlkem_invntt_mode = 0;
    mlkem_ntt_mode = 0;
}

static void expy_stack_prepare(void)
{
    memset(dtcm_stack, 0x5a, sizeof(dtcm_stack));
    expy_stack_canary_fails = 0;
    expy_stack_highwater = 0;
}

static void expy_stack_check(void)
{
    uint32_t first_used = sizeof(dtcm_stack);
    for (uint32_t i = 0; i < sizeof(dtcm_stack); i++) {
        if (dtcm_stack[i] != 0x5au) {
            first_used = i;
            break;
        }
    }
    for (uint32_t i = 0; i < 64u; i++) {
        expy_stack_canary_fails += (dtcm_stack[i] != 0x5au);
    }
    expy_stack_highwater = sizeof(dtcm_stack) - first_used;
}

static volatile uint32_t expz_bench_mode;
static volatile uint32_t expz_bench_slot_base;

/* Z A/B shares this exact function/frame and switches both NTT directions. */
static void bench_expz_mode_reps(void)
{
    const uint32_t slot = expz_bench_slot_base;
    mlkem_ntt_mode = expz_bench_mode;
    mlkem_invntt_mode = expz_bench_mode;
    mlkem_invntt_observe = 0;
    PQCLEAN_randombytes_reset(0x5a5a5a5au);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_keypair(mk_pk, mk_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    if (slot == 157u) {
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
    } else {
        expz_timing_mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        expz_timing_mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        expz_timing_mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        expz_timing_mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        expz_timing_mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
    }
    mlkem_invntt_mode = 0;
    mlkem_ntt_mode = 0;
}

static void expz_stack_prepare(void)
{
    memset(dtcm_stack, 0x3c, sizeof(dtcm_stack));
    expz_stack_canary_fails = 0;
    expz_stack_highwater = 0;
}

static void expz_stack_check(void)
{
    uint32_t first_used = sizeof(dtcm_stack);
    for (uint32_t i = 0; i < sizeof(dtcm_stack); i++) {
        if (dtcm_stack[i] != 0x3cu) {
            first_used = i;
            break;
        }
    }
    for (uint32_t i = 0; i < 64u; i++) {
        expz_stack_canary_fails += (dtcm_stack[i] != 0x3cu);
    }
    expz_stack_highwater = sizeof(dtcm_stack) - first_used;
}

static volatile uint32_t expaa_bench_fwd_mode;
static volatile uint32_t expaa_bench_slot_base;

static void bench_expaa_mode_reps(void)
{
    const uint32_t slot = expaa_bench_slot_base;
    mlkem_ntt_mode = expaa_bench_fwd_mode;
    mlkem_invntt_mode = 1;
    mlkem_invntt_observe = 0;
    PQCLEAN_randombytes_reset(0xaa5a5a5au);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_keypair(mk_pk, mk_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    if (slot == 169u) {
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
    } else {
        expaa_timing_mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        expaa_timing_mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        expaa_timing_mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        expaa_timing_mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        expaa_timing_mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
    }
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
}

static void expaa_stack_prepare(void)
{
    memset(dtcm_stack, 0x3c, sizeof(dtcm_stack));
    expaa_stack_canary_fails = 0;
    expaa_stack_highwater = 0;
}

static void expaa_stack_check(void)
{
    uint32_t first_used = sizeof(dtcm_stack);
    for (uint32_t i = 0; i < sizeof(dtcm_stack); i++) {
        if (dtcm_stack[i] != 0x3cu) {
            first_used = i;
            break;
        }
    }
    for (uint32_t i = 0; i < 64u; i++) {
        expaa_stack_canary_fails += (dtcm_stack[i] != 0x3cu);
    }
    expaa_stack_highwater = sizeof(dtcm_stack) - first_used;
}

static volatile uint32_t expab_bench_mode;
static volatile uint32_t expab_bench_slot_base;

static void bench_expab_mode_reps(void)
{
    const uint32_t slot = expab_bench_slot_base;
    mlkem_ntt_mode = (expab_bench_mode == 0u) ? 0u : 2u;
    mlkem_invntt_mode = (expab_bench_mode == 0u) ? 0u : 1u;
    PQCLEAN_randombytes_reset(0xab5a5a5au);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    if (slot == 181u) {
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
    } else {
        expab_timing_mismatch += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        expab_timing_mismatch += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        expab_timing_mismatch += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
        expab_timing_mismatch += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        expab_timing_mismatch += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
    }
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
}

static void expab_stack_prepare(void)
{
    memset(dtcm_stack, 0x3c, sizeof(dtcm_stack));
    expab_stack_canary_fails = 0;
    expab_stack_highwater = 0;
}

static void expab_stack_check(void)
{
    uint32_t first_used = sizeof(dtcm_stack);
    for (uint32_t i = 0; i < sizeof(dtcm_stack); i++) {
        if (dtcm_stack[i] != 0x3cu) {
            first_used = i;
            break;
        }
    }
    for (uint32_t i = 0; i < 64u; i++) {
        expab_stack_canary_fails += (dtcm_stack[i] != 0x3cu);
    }
    expab_stack_highwater = sizeof(dtcm_stack) - first_used;
}

static volatile uint32_t expac_bench_mode;
static volatile uint32_t expac_bench_slot_base;

static void bench_expac_mode_reps(void)
{
    const uint32_t slot = expac_bench_slot_base;
    mlkem_ntt_mode = 2;
    mlkem_invntt_mode = 1;
    PQCLEAN_randombytes_reset(0xac5a5a5au);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_ac_keypair(xw_pk, xw_sk, expac_bench_mode);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_ac_enc(xw_ct, xw_ss_e, xw_pk, expac_bench_mode);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_ac_dec(xw_ss_d, xw_ct, xw_sk, expac_bench_mode);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    if (slot == 193u) {
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
    } else {
        expac_timing_mismatch += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        expac_timing_mismatch += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        expac_timing_mismatch += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
        expac_timing_mismatch += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        expac_timing_mismatch += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
    }
    mlkem_keccakx4_mode = 0;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
    x25519_u_queue_reset();
}

static void expac_stack_prepare(void)
{
    memset(dtcm_stack, 0x69, sizeof(dtcm_stack));
    expac_stack_canary_fails = 0;
    expac_stack_highwater = 0;
}

static void expac_stack_check(void)
{
    uint32_t first_used = sizeof(dtcm_stack);
    for (uint32_t i = 0; i < sizeof(dtcm_stack); i++) {
        if (dtcm_stack[i] != 0x69u) {
            first_used = i;
            break;
        }
    }
    for (uint32_t i = 0; i < 64u; i++)
        expac_stack_canary_fails += (dtcm_stack[i] != 0x69u);
    expac_stack_highwater = sizeof(dtcm_stack) - first_used;
}

/* ---- Experiment AF: current U4/U8 batch attribution ---- */
static uint64_t expaf_state[4][25] __attribute__((aligned(16), section(".dtcm")));
static uint64_t expaf_ref4[4][25] __attribute__((aligned(16), section(".dtcm")));
static uint64_t expaf_ref8[4][25] __attribute__((aligned(16), section(".dtcm")));
static uint8_t expaf_out0[32] __attribute__((section(".dtcm")));
static uint8_t expaf_out1[32] __attribute__((section(".dtcm")));
static volatile uint32_t expaf_bench_mode;
static volatile uint32_t expaf_bench_slot;
static volatile uint32_t expaf_mismatch;
static volatile uint32_t expaf_u4_rounds[3];
static volatile uint32_t expaf_u8_rounds[3];
static volatile uint32_t expaf_real_steps[3];
static volatile uint32_t expaf_dummy_steps[3];

static void expaf_state_init(uint64_t states[4][25])
{
    for (uint32_t s = 0; s < 4; s++)
        for (uint32_t lane = 0; lane < 25; lane++)
            states[s][lane] = ((uint64_t) (0x9e3779b9u * (s + 1u)) << 32)
                            ^ (uint64_t) (0x01020305u * (lane + 1u));
}

static void expaf_enqueue(uint32_t jobs)
{
    x25519_u_queue_reset();
    expaf_mismatch += (x25519_u_enqueue(expaf_out0, alice_sk, basepoint) != 0);
    if (jobs == 2u)
        expaf_mismatch += (x25519_u_enqueue(expaf_out1, bob_sk, basepoint) != 0);
}

static void expaf_check_outputs(uint32_t jobs)
{
    x25519_u_finish_all();
    expaf_mismatch += byte_mismatches(expaf_out0, alice_pk, 32);
    if (jobs == 2u)
        expaf_mismatch += byte_mismatches(expaf_out1, bob_pk, 32);
    expaf_mismatch += x25519_u_failures();
}

static void expaf_prepare_refs(void)
{
    expaf_mismatch = 0;
    expaf_state_init(expaf_ref4);
    expaf_enqueue(1u);
    x25519_u_bench_seq4(expaf_ref4);
    expaf_check_outputs(1u);

    expaf_state_init(expaf_ref8);
    expaf_enqueue(2u);
    x25519_u_bench_seq8(expaf_ref8);
    expaf_check_outputs(2u);
}

static void bench_expaf_path_reps(void)
{
    const uint32_t mode = expaf_bench_mode;
    const uint32_t jobs = (mode >= 2u) ? 2u : 1u;
    const uint64_t (*ref)[25] = (jobs == 2u) ? expaf_ref8 : expaf_ref4;
    for (uint32_t r = 0; r < REP_N; r++) {
        expaf_state_init(expaf_state);
        expaf_enqueue(jobs);
        dwt_span_begin();
        if (mode == 0u) x25519_u_bench_seq4(expaf_state);
        else if (mode == 1u) x25519_u_bench_fused4(expaf_state);
        else if (mode == 2u) x25519_u_bench_seq8(expaf_state);
        else x25519_u_bench_fused8(expaf_state);
        rep_cyc[expaf_bench_slot][r] = dwt_span_end();
        expaf_check_outputs(jobs);
        expaf_mismatch += byte_mismatches((const uint8_t *) expaf_state,
                                          (const uint8_t *) ref,
                                          sizeof(expaf_state));
    }
}

static void expaf_count_u_paths(void)
{
    mlkem_ntt_mode = 2;
    mlkem_invntt_mode = 1;
    PQCLEAN_randombytes_reset(0xaf5a5a5au);

    g_u4_round_calls = g_u8_round_calls = 0;
    g_u_real_steps = g_u_dummy_steps = 0;
    xwing_ac_keypair(xw_pk, xw_sk, 1u);
    expaf_u4_rounds[0] = g_u4_round_calls;
    expaf_u8_rounds[0] = g_u8_round_calls;
    expaf_real_steps[0] = g_u_real_steps;
    expaf_dummy_steps[0] = g_u_dummy_steps;

    g_u4_round_calls = g_u8_round_calls = 0;
    g_u_real_steps = g_u_dummy_steps = 0;
    xwing_ac_enc(xw_ct, xw_ss_e, xw_pk, 1u);
    expaf_u4_rounds[1] = g_u4_round_calls;
    expaf_u8_rounds[1] = g_u8_round_calls;
    expaf_real_steps[1] = g_u_real_steps;
    expaf_dummy_steps[1] = g_u_dummy_steps;

    g_u4_round_calls = g_u8_round_calls = 0;
    g_u_real_steps = g_u_dummy_steps = 0;
    xwing_ac_dec(xw_ss_d, xw_ct, xw_sk, 1u);
    expaf_u4_rounds[2] = g_u4_round_calls;
    expaf_u8_rounds[2] = g_u8_round_calls;
    expaf_real_steps[2] = g_u_real_steps;
    expaf_dummy_steps[2] = g_u_dummy_steps;

    mlkem_keccakx4_mode = 0;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
    x25519_u_queue_reset();
}

/* ---- Experiment AI: encaps F/U/U1 total and interval attribution ---- */
static volatile uint32_t expai_bench_mode;
static volatile uint32_t expai_bench_slot;
static volatile uint32_t expai_mismatch;
static uint8_t expai_ref_ct[XWING_CIPHERTEXTBYTES] __attribute__((section(".dtcm")));
static uint8_t expai_ref_ss[32] __attribute__((section(".dtcm")));

static void expai_prepare(void)
{
    PQCLEAN_randombytes_reset(0xa1c0ffeeu);
    xwing_ac_keypair(xw_pk, xw_sk, 3u);
}

static void bench_expai_enc_reps(void)
{
    const uint32_t mode = expai_bench_mode; /* 0=F, 1=U, 2=U1 */
    const uint32_t slot = expai_bench_slot;
    uint8_t ss_m[32], ss_x[32], ephemeral[32];

    PQCLEAN_randombytes_reset(0xa15a5a5au);
    for (uint32_t r = 0; r < REP_N; r++) {
        (void) PQCLEAN_randombytes(ephemeral, sizeof(ephemeral));
        clamp(ephemeral);
        x25519_u_queue_reset();
        if (mode != 0u) {
            expai_mismatch += (x25519_u_enqueue(xw_ct + CRYPTO_CIPHERTEXTBYTES,
                                               ephemeral, basepoint) != 0);
            if (mode == 1u)
                expai_mismatch += (x25519_u_enqueue(ss_x, ephemeral,
                                                   xw_pk + CRYPTO_PUBLICKEYBYTES) != 0);
        }

        mlkem_keccakx4_mode = 1u;
        dwt_span_begin();
        crypto_kem_enc(xw_ct, ss_m, xw_pk);
        uint32_t fused_end = dwt_span_end();

        if (mode == 0u) {
            curve25519_scalarmult_fiat(xw_ct + CRYPTO_CIPHERTEXTBYTES,
                                      ephemeral, basepoint);
            curve25519_scalarmult_fiat(ss_x, ephemeral,
                                      xw_pk + CRYPTO_PUBLICKEYBYTES);
        } else if (mode == 1u) {
            x25519_u_finish_all();
        } else {
            x25519_u_finish_all();
            curve25519_scalarmult_fiat(ss_x, ephemeral,
                                      xw_pk + CRYPTO_PUBLICKEYBYTES);
        }
        uint32_t residual_end = dwt_span_end();

        mlkem_keccakx4_mode = 0u;
        xwing_combine(xw_ss_e, ss_m, ss_x,
                      xw_ct + CRYPTO_CIPHERTEXTBYTES,
                      xw_pk + CRYPTO_PUBLICKEYBYTES);
        uint32_t total_end = dwt_span_end();

        rep_cyc[slot][r] = total_end;
        rep_cyc[slot + 1u][r] = fused_end;
        rep_cyc[slot + 2u][r] = residual_end - fused_end;
        expai_mismatch += x25519_u_queue_pending() + x25519_u_failures();
    }

    if (slot == 237u) {
        memcpy(expai_ref_ct, xw_ct, sizeof(expai_ref_ct));
        memcpy(expai_ref_ss, xw_ss_e, sizeof(expai_ref_ss));
    } else {
        expai_mismatch += byte_mismatches(xw_ct, expai_ref_ct, sizeof(expai_ref_ct));
        expai_mismatch += byte_mismatches(xw_ss_e, expai_ref_ss, sizeof(expai_ref_ss));
    }
    mlkem_keccakx4_mode = 0u;
    x25519_u_queue_reset();
}

static void bench_combiner_reps(void)
{
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        sha3_256(comb_out, comb_in, sizeof(comb_in));
        rep_cyc[6][r] = dwt_span_end();
    }
}

/* ---- ?⑹꽦 ?ㅽ떚移?留덉씠?щ줈踰ㅼ튂 (stitch_micro.S, ITCM) ---- */
extern void stitch_mul_chain(uint32_t iters);
extern void stitch_logic_chain(uint32_t iters);
extern void stitch_interleaved(uint32_t iters);
extern void stitch_mem_chain(uint32_t iters, uint32_t *buf);
extern void stitch_interleaved_mem(uint32_t iters, uint32_t *buf);

static uint32_t stitch_buf[16] __attribute__((section(".dtcm")));

/* ?ㅽ뿕 3: A-?멸툑 ??媛숈? C ?뚯뒪瑜??덉??ㅽ꽣 ?덉궛 ??踰뚮줈 而댄뙆?쇳븳 256鍮꾪듃 怨?(src/gen/) */
extern void mul256_full(uint32_t r[16], const uint32_t a[8], const uint32_t b[8]);
extern void mul256_budget(uint32_t r[16], const uint32_t a[8], const uint32_t b[8]);
static uint32_t m3_a[8] __attribute__((section(".dtcm")));
static uint32_t m3_b[8] __attribute__((section(".dtcm")));
static uint32_t m3_r1[16] __attribute__((section(".dtcm")));
static uint32_t m3_r2[16] __attribute__((section(".dtcm")));
volatile uint32_t mul256_mismatch = 9;

/* ?ㅽ뿕 4: 吏???ㅽ떚移?(src/gen/stitched.s ??stitch_zip.py ?앹꽦) */
extern void mul256_flat(uint32_t r[16], const uint32_t a[8], const uint32_t b[8]);
extern void mul256_theta_stitched(uint32_t r[16], const uint32_t a[8], const uint32_t b[8]);
extern void theta_frag(uint32_t *state);
extern void round_frag(uint32_t *state);
extern void mul256_round_stitched(uint32_t r[16], const uint32_t a[8], const uint32_t b[8]);
extern void mul256_flat6(uint32_t r[16], const uint32_t a[8], const uint32_t b[8]);
extern void round6_frag(uint32_t *state);
extern void mul256_round6_stitched(uint32_t r[16], const uint32_t a[8], const uint32_t b[8]);
extern void mul2_round6_stitched(uint32_t r[16], const uint32_t a[8], const uint32_t b[8]);
extern void slothy_expa_seq(uint32_t iters, uint32_t *state);
extern void slothy_expa_opt(uint32_t iters, uint32_t *state);
extern void bmid_seq(uint32_t iters, uint32_t *state);
extern void bmid_zip(uint32_t iters, uint32_t *state);
extern void bmid_slothy(uint32_t iters, uint32_t *state);
volatile uint32_t bmid_mismatch = 9;

/* ?꾩껜 洹쒕え 鍮꾧탳 (bfull_board.s) ??asm???щ낵 吏곸젒 李몄“.
 * 吏??蹂?뺤? flatY? ?덉??ㅽ꽣 遺꾪븷 鍮꾪샇???쇱씠釉?媛??뚭눼)?대씪 ?놁쓬 ?? * 吏?쇱쓽 ?꾩껜 洹쒕え 湲곗?媛믪? flat6 湲곕컲 stitched-round6(681cyc) 湲곗〈 ?ㅼ륫 ?ъ슜 */
extern void bfull_seq(uint32_t iters);
extern void bfull_slothy(uint32_t iters);
uint32_t g_spill[320] __attribute__((aligned(8), section(".dtcm")));   /* ?ㅽ븘 理쒕? 303 + 移댁슫??[60]/[94]/[318] */

/* ?ㅽ뿕 E: 4?④퀎 鍮꾩쑉 肄붿뼱 (expe_board.s) */
extern void expe_seq(uint32_t iters);
extern void expe_slothy(uint32_t iters);
volatile uint32_t expe_mismatch = 9;

/* ?뚮옖 B: 4-way MVE Keccak (mvekeccak_board.s) ??釉붾줉 2384B (E/O/BE/BO/C/D) */
extern void keccak4_round_mve(uint32_t iters, uint32_t *block);
extern void coissue_scalar(uint32_t iters);
extern void coissue_zip(uint32_t iters, uint32_t *block);
extern void coissue_slothy(uint32_t iters, uint32_t *block);
extern void coissue_slothy2(uint32_t iters, uint32_t *block);  /* 紐⑤뜽 v0.4 */
uint32_t g_mve[600] __attribute__((aligned(16), section(".dtcm")));
volatile uint32_t mve4_mismatch = 9;
volatile uint32_t coissue_mismatch = 9;
volatile uint32_t cosol_mismatch = 9;

/* ?ㅽ뿕 G: 3-踰좎씠?ㅽ뙋 (mvekeccak_board.s) */
extern void keccak4_mve3(uint32_t iters, uint32_t *block);
extern void coissue3_zip(uint32_t iters, uint32_t *block);
volatile uint32_t expg_mismatch = 9;

/* ?ㅽ뿕 H: ?덉씤 ?꾩튂 湲猷?(pack4/unpack4) */
extern void pack4_lane(const uint32_t *flat, uint32_t *packed);
extern void unpack4_lane(const uint32_t *packed, uint32_t *flat);
uint32_t g_flat[200] __attribute__((aligned(16), section(".dtcm")));   /* 4?곹깭 횞 50?뚮뱶 */
volatile uint32_t exph_mismatch = 9;

/* ?ㅽ뿕 I: fiat ?꾨뱶怨?3-?덉??ㅽ꽣 ?묐낫 ?멸툑 (base=fiat_mul_ref ?꾩껜GP, yield3=r10/11/12 ?묐낫) */
extern void fiat_mul_yield3(uint32_t out1[10], const uint32_t arg1[10], const uint32_t arg2[10]);
volatile uint32_t expi_mismatch = 9;

/* v0.4: 2-踰좎씠??MVE + 2-?덉??ㅽ꽣 ?묐낫 fiat */
extern void keccak4_mve2(uint32_t iters, uint32_t *block);
extern void coissue2_zip(uint32_t iters, uint32_t *block);
extern void fiat_mul_yield2(uint32_t out1[10], const uint32_t arg1[10], const uint32_t arg2[10]);
volatile uint32_t v04_mismatch = 9;

/* ?ㅽ뿕 J: 吏꾩쭨 fiat 怨?횞 MVE ?쇱슫???듯빀 (expj_board.s) */
extern void expj_seq(uint32_t iters);
extern void expj_stitch(uint32_t iters);
extern void expj_stitch2(uint32_t iters);
volatile uint32_t expj_mismatch = 9;

/* ?ㅽ뿕 K: ?議곌뎔 3醫????쒖감/援듭? 援먮?/?ㅽ떚移?(媛숈? ?? 怨?+?쇱슫??) */
extern void expk_seq(uint32_t iters);
extern void expk_coarse(uint32_t iters);
extern void expk_stitch(uint32_t iters);
volatile uint32_t expk_mismatch = 9;

/* ?ㅽ뿕 L: NTT 吏??議???B = 踰꾪꽣?뚮씪?댄삎(vmul low + vmulh high) 3?⑥뒪 */
extern void expl_ntt(uint32_t iters, uint32_t *block);
extern void expl_zip(uint32_t iters, uint32_t *block);
extern void expl_sntt(uint32_t iters, uint32_t *block);
extern void expl_szip(uint32_t iters, uint32_t *block);
volatile uint32_t expl_mismatch = 9;

/* ?ㅽ뿕 M: encaps ?ㅻ퉬??怨?:?쇱슫??) */
extern void expm_seq(uint32_t iters);
extern void expm_stitch(uint32_t iters);
extern void expm_stitch2(uint32_t iters);
extern void expm4_seq(uint32_t iters);
extern void expm4_stitch(uint32_t iters);
extern void expm4_stitch2(uint32_t iters);
volatile uint32_t expm_mismatch = 9;

/* ?ㅽ뿕 T: GP 0媛?b0 MVE + GP 臾댁뼇蹂?no -ffixed-r*) fiat */
extern void expt_fiat(uint32_t iters);
extern void expt_b0(uint32_t iters);
extern void expt_seq(uint32_t iters);
extern void expt_stitch(uint32_t iters);
extern void expt_m8_seq(uint32_t iters);
extern void expt_m8_stitch(uint32_t iters);
extern void expt_m4_seq(uint32_t iters);
extern void expt_m4_stitch(uint32_t iters);
volatile uint32_t expt_mismatch = 9;

/* ?ㅽ뿕 U: yield1 scalar + one-GP b1 MVE ?섏씠釉뚮━??*/
extern void expu_y10(uint32_t iters);
extern void expu_y11(uint32_t iters);
extern void expu_lo10_b1(uint32_t iters);
extern void expu_lo10_seq(uint32_t iters);
extern void expu_lo10_stitch(uint32_t iters);
extern void expu_lo10_m4_seq(uint32_t iters);
extern void expu_lo10_m4_stitch(uint32_t iters);
extern void expu_lo10_m8_seq(uint32_t iters);
extern void expu_lo10_m8_stitch(uint32_t iters);
extern void expu_lo11_b1(uint32_t iters);
extern void expu_lo11_seq(uint32_t iters);
extern void expu_lo11_stitch(uint32_t iters);
extern void expu_lo11_m4_seq(uint32_t iters);
extern void expu_lo11_m4_stitch(uint32_t iters);
extern void expu_lo11_m8_seq(uint32_t iters);
extern void expu_lo11_m8_stitch(uint32_t iters);
extern void expu_hi11_b1(uint32_t iters);
extern void expu_hi11_seq(uint32_t iters);
extern void expu_hi11_stitch(uint32_t iters);
extern void expu_hi11_m4_seq(uint32_t iters);
extern void expu_hi11_m4_stitch(uint32_t iters);
extern void expu_hi11_m8_seq(uint32_t iters);
extern void expu_hi11_m8_stitch(uint32_t iters);
volatile uint32_t expu_mismatch = 9;

/* ?ㅽ뿕 V: ?꾩옱 ML-KEM NTT/invNTT 吏곸젒 attribution. 0 ?ㅽ빆?앹쑝濡?踰붿쐞 怨좎젙. */
poly expv_poly __attribute__((section(".dtcm")));
volatile uint32_t expv_mismatch = 9;

/* ?ㅽ뿕 W: pqmx/SLOTHY??怨좎젙 commit?먯꽌 媛?몄삩 MVE Kyber NTT ?꾨낫. */
extern void ntt_kyber_1_23_45_67_no_trans_opt_m85(int16_t *src);
extern void ntt_kyber_1_23_45_67_no_trans_vld4_opt_m85(int16_t *src);
extern void ntt_kyber_12_345_67_opt_size_m85(int16_t *src);
extern void ntt_kyber_12_345_67_opt_speed_m85(int16_t *src);
extern void intt_kyber_1_23_45_67_opt_m85(int16_t *src);
extern void intt_kyber_1_23_45_67_opt_m85_plantard(int16_t *src);
poly expw_poly __attribute__((section(".dtcm"), aligned(16)));
volatile uint32_t expw_mismatch = 9;
/* M55 comparator rejected on this M85: upstream overlap-writeback LDRD faults. */
volatile uint32_t expw_m55_unavailable = 1;
volatile uint32_t expw_inverse_m85_mismatch = 9;
volatile uint32_t expw_roundtrip_m85_mismatch = 9;

typedef struct {
    uint32_t before[4];
    poly value;
    uint32_t after[4];
} expy_guarded_poly;
static expy_guarded_poly expy_oracle_a __attribute__((section(".dtcm"), aligned(16)));
static expy_guarded_poly expy_oracle_b __attribute__((section(".dtcm"), aligned(16)));
volatile uint32_t expy_oracle_mismatch = 9;
volatile uint32_t expy_oracle_canary_fails = 9;
volatile int32_t expy_oracle_output_min = 32767;
volatile int32_t expy_oracle_output_max = -32768;

static uint16_t expw_mod_q(int16_t value)
{
    int32_t reduced = value;
    reduced %= 3329;
    if (reduced < 0) reduced += 3329;
    return (uint16_t) reduced;
}

static void expy_set_canaries(expy_guarded_poly *guarded)
{
    for (uint32_t i = 0; i < 4u; i++) {
        guarded->before[i] = 0x13579bdfu ^ i;
        guarded->after[i] = 0x2468ace0u ^ i;
    }
}

static uint32_t expy_check_canaries(const expy_guarded_poly *guarded)
{
    uint32_t fails = 0;
    for (uint32_t i = 0; i < 4u; i++) {
        fails += (guarded->before[i] != (0x13579bdfu ^ i));
        fails += (guarded->after[i] != (0x2468ace0u ^ i));
    }
    return fails;
}

/* Eight raw inverse-input vectors within invntt_fast's documented <0.5q
 * coefficient contract: same current layout/domain enters A and B. */
static void expy_run_standalone_oracle(void)
{
    uint32_t mismatch = 0;
    uint32_t canary_fails = 0;
    int32_t output_min = 32767;
    int32_t output_max = -32768;

    mlkem_invntt_observe = 0;
    for (uint32_t vector = 0; vector < 8u; vector++) {
        uint32_t state = 0x45585059u ^ (vector * 0x9e3779b9u);
        expy_set_canaries(&expy_oracle_a);
        expy_set_canaries(&expy_oracle_b);
        for (uint32_t i = 0; i < KYBER_N; i++) {
            int32_t value;
            state = state * 1664525u + 1013904223u;
            if (vector == 0u) value = 0;
            else if (vector == 1u) value = -1; /* centered representative of q-1 */
            else if (vector == 2u) value = (int32_t) (i % 3329u);
            else if (vector == 3u) value = (i & 1u) ? -1664 : 1664;
            else {
                value = (int32_t) (state % 3329u);
                if (value > 1664) value -= 3329;
            }
            expy_oracle_a.value.coeffs[i] = (int16_t) value;
            expy_oracle_b.value.coeffs[i] = (int16_t) value;
        }
        mlkem_invntt_mode = 0;
        poly_invntt(&expy_oracle_a.value);
        mlkem_invntt_mode = 1;
        poly_invntt(&expy_oracle_b.value);
        for (uint32_t i = 0; i < KYBER_N; i++) {
            const int32_t value = expy_oracle_b.value.coeffs[i];
            mismatch += (expw_mod_q(expy_oracle_a.value.coeffs[i]) !=
                         expw_mod_q(expy_oracle_b.value.coeffs[i]));
            if (value < output_min) output_min = value;
            if (value > output_max) output_max = value;
        }
        canary_fails += expy_check_canaries(&expy_oracle_a);
        canary_fails += expy_check_canaries(&expy_oracle_b);
    }
    expy_oracle_mismatch = mismatch;
    expy_oracle_canary_fails = canary_fails;
    expy_oracle_output_min = output_min;
    expy_oracle_output_max = output_max;
    mlkem_invntt_mode = 0;
}

/* pqmx tests/ntt-kyber/main.c??buf_bitrev_4? 媛숈? 4x4 int32-pair ?꾩튂. */
static void __attribute__((noinline)) expw_rev4(poly *value)
{
    int32_t *pairs = (int32_t *) (void *) value->coeffs;
    for (uint32_t base = 0; base < 128; base += 16) {
        int32_t tmp[16];
        for (uint32_t i = 0; i < 16; i++) tmp[i] = pairs[base + i];
        for (uint32_t row = 0; row < 4; row++)
            for (uint32_t col = 0; col < 4; col++)
                pairs[base + row * 4 + col] = tmp[col * 4 + row];
    }
}

static uint32_t expw_compare_expected(const poly *value)
{
    uint32_t mismatch = 0;
    for (uint32_t i = 0; i < KYBER_N; i++)
        mismatch += (expw_mod_q(value->coeffs[i]) != (uint16_t) expw_expected_rev4[i]);
    return mismatch;
}

static uint32_t expw_compare_inverse_expected(const poly *value)
{
    uint32_t mismatch = 0;
    for (uint32_t i = 0; i < KYBER_N; i++)
        mismatch += (expw_mod_q(value->coeffs[i]) != (uint16_t) expw_expected_inverse[i]);
    return mismatch;
}

static uint32_t expw_compare_montgomery_input(const poly *value)
{
    uint32_t mismatch = 0;
    for (uint32_t i = 0; i < KYBER_N; i++) {
        uint16_t expected = (uint16_t) (((uint32_t) expw_input[i] * 2285u) % 3329u);
        mismatch += (expw_mod_q(value->coeffs[i]) != expected);
    }
    return mismatch;
}

/* ?ㅽ뿕 C: fiat ?꾨뱶 怨?(expc_board.s) */
extern void expc_seq(uint32_t iters);
extern void expc_slothy(uint32_t iters);
extern void fiat_mul_ref(uint32_t out1[10], const uint32_t arg1[10], const uint32_t arg2[10]);
uint32_t g_fc_out[10] __attribute__((section(".dtcm")));
uint32_t g_fc_a[10] __attribute__((section(".dtcm")));
uint32_t g_fc_b[10] __attribute__((section(".dtcm")));
volatile uint32_t expc_mismatch = 9;

/* ?ㅽ뿕 D: 鍮꾪듃-?명꽣由щ툕 ?쇱슫??(expd_board.s) */
extern void expd_seq(uint32_t iters);
extern void expd_slothy(uint32_t iters);
volatile uint32_t expd_mismatch = 9;

/* 鍮꾪듃-?명꽣由щ툕 ?ы띁: u64 ??(even, odd) 32鍮꾪듃 ??*/
static void bitinterleave(uint64_t v, uint32_t *e, uint32_t *o)
{
    uint32_t ev = 0, od = 0;
    for (uint32_t i = 0; i < 32; i++) {
        ev |= (uint32_t)((v >> (2 * i)) & 1u) << i;
        od |= (uint32_t)((v >> (2 * i + 1)) & 1u) << i;
    }
    *e = ev; *o = od;
}

static uint64_t bitdeinterleave(uint32_t e, uint32_t o)
{
    uint64_t v = 0;
    for (uint32_t i = 0; i < 32; i++) {
        v |= (uint64_t)((e >> i) & 1u) << (2 * i);
        v |= (uint64_t)((o >> i) & 1u) << (2 * i + 1);
    }
    return v;
}
uint32_t g_bf_r[16] __attribute__((section(".dtcm")));
uint32_t g_bf_a[8] __attribute__((section(".dtcm")));
uint32_t g_bf_b[8] __attribute__((section(".dtcm")));
volatile uint32_t bfull_mismatch = 9;
/* ?덉씠?꾩썐(?뚮뱶): A=0..49, ?? ?ㅽ겕?섏튂=50..99, 罐?⑤━??C=100..109, D=110..119 */
uint32_t g_theta_state[120] __attribute__((aligned(8), section(".dtcm")));
static uint32_t m3_r3[16] __attribute__((section(".dtcm")));
volatile uint32_t stitched_mismatch = 9;   /* 怨?遺덉씪移?+ 罐 遺덉씪移???(0?댁뼱???? */

static void theta_reference(const uint32_t *in, uint32_t *out)
{
    for (uint32_t x = 0; x < 5; x++)
        for (uint32_t h = 0; h < 2; h++) {
            uint32_t v = 0;
            for (uint32_t y = 0; y < 5; y++) v ^= in[2 * (x + 5 * y) + h];
            out[2 * x + h] = v;
        }
}

/* ?꾩껜 ?쇱슫??C ?덊띁?곗뒪 (FIPS202 ?섏궗肄붾뱶, ?됰㈃ uint64 ?덉씤 ??LE???뚮뱶?띻낵 ?명솚) */
#define ROL64(v, n) (((v) << (n)) | ((v) >> (64 - (n))))
static void keccak_round_reference(uint64_t A[25])
{
    static const uint8_t RHO[5][5] = { { 0, 36, 3, 41, 18 }, { 1, 44, 10, 45, 2 },
                                       { 62, 6, 43, 15, 61 }, { 28, 55, 25, 21, 56 },
                                       { 27, 20, 39, 8, 14 } };   /* RHO[x][y] */
    uint64_t C[5], D[5], B[25];
    for (uint32_t x = 0; x < 5; x++)
        C[x] = A[x] ^ A[x + 5] ^ A[x + 10] ^ A[x + 15] ^ A[x + 20];
    for (uint32_t x = 0; x < 5; x++)
        D[x] = C[(x + 4) % 5] ^ ROL64(C[(x + 1) % 5], 1);
    for (uint32_t i = 0; i < 25; i++) A[i] ^= D[i % 5];
    for (uint32_t x = 0; x < 5; x++)
        for (uint32_t y = 0; y < 5; y++) {
            uint32_t n = RHO[x][y];
            B[y + 5 * ((2 * x + 3 * y) % 5)] = n ? ROL64(A[x + 5 * y], n) : A[x + 5 * y];
        }
    for (uint32_t y = 0; y < 5; y++)
        for (uint32_t x = 0; x < 5; x++)
            A[x + 5 * y] = B[x + 5 * y] ^ ((~B[(x + 1) % 5 + 5 * y]) & B[(x + 2) % 5 + 5 * y]);
    A[0] ^= 1u;   /* 菅, ?쇱슫??0 */
}

#define STITCH_ITERS 1000u

static void bench_stitch_reps(void)
{
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        stitch_mul_chain(STITCH_ITERS);
        rep_cyc[7][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        stitch_logic_chain(STITCH_ITERS);
        rep_cyc[8][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        stitch_interleaved(STITCH_ITERS);
        rep_cyc[9][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        stitch_mem_chain(STITCH_ITERS, stitch_buf);
        rep_cyc[10][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        stitch_interleaved_mem(STITCH_ITERS, stitch_buf);
        rep_cyc[11][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 3: 怨?1?뚮뒗 吏㏃쑝??100??猷⑦봽瑜???援ш컙?쇰줈 痢≪젙 (per-rep 媛?= 100???? */
    for (uint32_t i = 0; i < 8; i++) { m3_a[i] = 0x01234567u * (i + 1); m3_b[i] = 0x89abcdefu ^ (i * 0x1111u); }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) mul256_full(m3_r1, m3_a, m3_b);
        rep_cyc[12][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) mul256_budget(m3_r2, m3_a, m3_b);
        rep_cyc[13][r] = dwt_span_end();
    }
    mul256_mismatch = 0;
    for (uint32_t i = 0; i < 16; i++) mul256_mismatch += (m3_r1[i] != m3_r2[i]);

    /* ?ㅽ뿕 4: ?뺣떟 寃利?(怨?寃곌낵 == full?? 罐 異쒕젰 == C ?덊띁?곗뒪) ??踰ㅼ튂 */
    {
        uint32_t theta_ref[10];
        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x9e3779b9u * (i + 1);
        theta_reference(g_theta_state, theta_ref);

        mul256_theta_stitched(m3_r3, m3_a, m3_b);
        stitched_mismatch = 0;
        for (uint32_t i = 0; i < 16; i++) stitched_mismatch += (m3_r3[i] != m3_r1[i]);
        for (uint32_t i = 0; i < 10; i++) stitched_mismatch += (g_theta_state[50 + i] != theta_ref[i]);

        theta_frag(g_theta_state);
        for (uint32_t i = 0; i < 10; i++) stitched_mismatch += (g_theta_state[50 + i] != theta_ref[i]);
    }

    /* ?ㅽ뿕 5: ?꾩껜 ?쇱슫??寃利???round_frag? stitched ????C ?덊띁?곗뒪? ?議?*/
    {
        uint64_t ref[25];
        uint64_t *lanes = (uint64_t *) g_theta_state;

        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x9e3779b9u * (i + 7);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        round_frag(g_theta_state);
        for (uint32_t i = 0; i < 25; i++) stitched_mismatch += (lanes[i] != ref[i]);

        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x85ebca6bu * (i + 3);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        mul256_round_stitched(m3_r3, m3_a, m3_b);
        for (uint32_t i = 0; i < 25; i++) stitched_mismatch += (lanes[i] != ref[i]);
        for (uint32_t i = 0; i < 16; i++) stitched_mismatch += (m3_r3[i] != m3_r1[i]);

        /* ?ㅽ뿕 6: ?덉궛 ?ㅼ쐲??寃利?(flat6 怨?+ round6 ?⑤룆 + stitched6) */
        mul256_flat6(m3_r3, m3_a, m3_b);
        for (uint32_t i = 0; i < 16; i++) stitched_mismatch += (m3_r3[i] != m3_r1[i]);

        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0xc2b2ae35u * (i + 11);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        round6_frag(g_theta_state);
        for (uint32_t i = 0; i < 25; i++) stitched_mismatch += (lanes[i] != ref[i]);

        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x27d4eb2fu * (i + 5);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        mul256_round6_stitched(m3_r3, m3_a, m3_b);
        for (uint32_t i = 0; i < 25; i++) stitched_mismatch += (lanes[i] != ref[i]);
        for (uint32_t i = 0; i < 16; i++) stitched_mismatch += (m3_r3[i] != m3_r1[i]);

        /* ?ㅽ뿕 7: k=2 寃利?*/
        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x165667b1u * (i + 13);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        mul2_round6_stitched(m3_r3, m3_a, m3_b);
        for (uint32_t i = 0; i < 25; i++) stitched_mismatch += (lanes[i] != ref[i]);
        for (uint32_t i = 0; i < 16; i++) stitched_mismatch += (m3_r3[i] != m3_r1[i]);
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) mul256_flat(m3_r3, m3_a, m3_b);
        rep_cyc[14][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) theta_frag(g_theta_state);
        rep_cyc[15][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) mul256_theta_stitched(m3_r3, m3_a, m3_b);
        rep_cyc[16][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) round_frag(g_theta_state);
        rep_cyc[17][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) mul256_round_stitched(m3_r3, m3_a, m3_b);
        rep_cyc[18][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) mul256_flat6(m3_r3, m3_a, m3_b);
        rep_cyc[19][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) round6_frag(g_theta_state);
        rep_cyc[20][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) mul256_round6_stitched(m3_r3, m3_a, m3_b);
        rep_cyc[21][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) mul2_round6_stitched(m3_r3, m3_a, m3_b);
        rep_cyc[22][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        slothy_expa_seq(1000, g_theta_state);
        rep_cyc[23][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        slothy_expa_opt(1000, g_theta_state);
        rep_cyc[24][r] = dwt_span_end();
    }

    /* B-mid 3?뚯쟾: 罐 異쒕젰(state ?뚮뱶 50..59)????蹂??紐⑤몢 C ?덊띁?곗뒪? ?쇱튂?댁빞 ??*/
    {
        uint32_t theta_ref[10];
        uint32_t mm = 0;
        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x7f4a7c15u * (i + 9);
        theta_reference(g_theta_state, theta_ref);
        bmid_seq(1, g_theta_state);
        for (uint32_t i = 0; i < 10; i++) mm += (g_theta_state[50 + i] != theta_ref[i]);
        bmid_zip(1, g_theta_state);
        for (uint32_t i = 0; i < 10; i++) mm += (g_theta_state[50 + i] != theta_ref[i]);
        bmid_slothy(1, g_theta_state);
        for (uint32_t i = 0; i < 10; i++) mm += (g_theta_state[50 + i] != theta_ref[i]);
        bmid_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        bmid_seq(1000, g_theta_state);
        rep_cyc[25][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        bmid_zip(1000, g_theta_state);
        rep_cyc[26][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        bmid_slothy(1000, g_theta_state);
        rep_cyc[27][r] = dwt_span_end();
    }

    /* ?꾩껜 洹쒕え 3?뚯쟾: 怨?寃곌낵(g_bf_r vs mul256_full) + Keccak ?쇱슫??寃곌낵(?덉씤 vs C ?덊띁?곗뒪) */
    {
        uint64_t ref[25];
        uint64_t *lanes = (uint64_t *) g_theta_state;
        uint32_t mm = 0;
        for (uint32_t i = 0; i < 8; i++) { g_bf_a[i] = m3_a[i]; g_bf_b[i] = m3_b[i]; }

        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x6c62272eu * (i + 21);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        bfull_seq(1);
        for (uint32_t i = 0; i < 16; i++) mm += (g_bf_r[i] != m3_r1[i]);
        for (uint32_t i = 0; i < 25; i++) mm += (lanes[i] != ref[i]);

        /* ?붾쾭 蹂??寃利???怨??덉씤 遺꾪빐 吏꾨떒 */
        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x6c62272eu * (i + 21);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        bfull_slothy(1);
        {
            uint32_t mp = 0, ml = 0;
            for (uint32_t i = 0; i < 16; i++) mp += (g_bf_r[i] != m3_r1[i]);
            for (uint32_t i = 0; i < 25; i++) ml += (lanes[i] != ref[i]);
            uart_puts("bfull_slothy diag: prod-mm="); uart_put_u32(mp);
            uart_puts(" lane-mm="); uart_put_u32(ml);
            uart_puts(" first-bad-prod=");
            for (uint32_t i = 0; i < 16; i++) if (g_bf_r[i] != m3_r1[i]) { uart_put_u32(i); break; }
            uart_puts(" first-bad-lane=");
            for (uint32_t i = 0; i < 25; i++) if (lanes[i] != ref[i]) { uart_put_u32(i); break; }
            uart_puts("\n");
            mm += mp + ml;
        }
        bfull_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        bfull_seq(1000);
        rep_cyc[28][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        bfull_slothy(1000);
        rep_cyc[30][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 C 寃利? 怨?fiat C ?덊띁?곗뒪 ?議? + ?쇱슫???덊띁?곗뒪 ?議?, seq/slothy 媛곴컖 */
    {
        uint64_t ref[25];
        uint64_t *lanes = (uint64_t *) g_theta_state;
        uint32_t fc_ref[10];
        uint32_t mm = 0;
        for (uint32_t i = 0; i < 10; i++) {
            g_fc_a[i] = (0x03FFFFFFu >> (i & 1)) & (0x12345u * (i + 1));   /* 26/25鍮꾪듃 由쇰툕 踰붿쐞 */
            g_fc_b[i] = (0x03FFFFFFu >> (i & 1)) & (0x0BEEFu * (i + 3));
        }
        fiat_mul_ref(fc_ref, g_fc_a, g_fc_b);

        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x9e3779b1u * (i + 31);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        expc_seq(1);
        for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fc_ref[i]);
        for (uint32_t i = 0; i < 25; i++) mm += (lanes[i] != ref[i]);

        for (uint32_t i = 0; i < 50; i++) g_theta_state[i] = 0x9e3779b1u * (i + 31);
        for (uint32_t i = 0; i < 25; i++) ref[i] = lanes[i];
        keccak_round_reference(ref);
        expc_slothy(1);
        for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fc_ref[i]);
        for (uint32_t i = 0; i < 25; i++) mm += (lanes[i] != ref[i]);
        expc_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expc_seq(1000);
        rep_cyc[31][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expc_slothy(1000);
        rep_cyc[32][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 D 寃利? ?명꽣由щ툕 ?쇱슫??寃곌낵瑜??붿씤?곕━釉뚰빐 ?됰㈃ ?덊띁?곗뒪? ?議?+ 怨??議?*/
    {
        uint64_t plain[25], ref[25];
        uint32_t fc_ref[10];
        uint32_t mm = 0;
        fiat_mul_ref(fc_ref, g_fc_a, g_fc_b);   /* g_fc_a/b???ㅽ뿕 C 釉붾줉?먯꽌 珥덇린?붾맖 */

        for (uint32_t i = 0; i < 25; i++) plain[i] = 0x9e3779b97f4a7c15ull * (i + 41);
        for (uint32_t i = 0; i < 25; i++) { ref[i] = plain[i]; }
        keccak_round_reference(ref);
        for (uint32_t i = 0; i < 25; i++)
            bitinterleave(plain[i], &g_theta_state[2 * i], &g_theta_state[2 * i + 1]);
        expd_seq(1);
        for (uint32_t i = 0; i < 25; i++)
            mm += (bitdeinterleave(g_theta_state[2 * i], g_theta_state[2 * i + 1]) != ref[i]);
        for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fc_ref[i]);

        for (uint32_t i = 0; i < 25; i++)
            bitinterleave(plain[i], &g_theta_state[2 * i], &g_theta_state[2 * i + 1]);
        expd_slothy(1);
        for (uint32_t i = 0; i < 25; i++)
            mm += (bitdeinterleave(g_theta_state[2 * i], g_theta_state[2 * i + 1]) != ref[i]);
        for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fc_ref[i]);
        expd_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expd_seq(1000);
        rep_cyc[33][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expd_slothy(1000);
        rep_cyc[34][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 E 寃利? 怨?媛숈? ?몄옄 4??= 寃곌낵 ?숈씪?댁빞) + ?명꽣由щ툕 ?쇱슫??*/
    {
        uint64_t plain[25], ref[25];
        uint32_t fc_ref[10];
        uint32_t mm = 0;
        fiat_mul_ref(fc_ref, g_fc_a, g_fc_b);

        for (uint32_t i = 0; i < 25; i++) plain[i] = 0xc2b2ae3d27d4eb4full * (i + 51);
        for (uint32_t i = 0; i < 25; i++) ref[i] = plain[i];
        keccak_round_reference(ref);
        for (uint32_t i = 0; i < 25; i++)
            bitinterleave(plain[i], &g_theta_state[2 * i], &g_theta_state[2 * i + 1]);
        expe_seq(1);
        for (uint32_t i = 0; i < 25; i++)
            mm += (bitdeinterleave(g_theta_state[2 * i], g_theta_state[2 * i + 1]) != ref[i]);
        for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fc_ref[i]);

        for (uint32_t i = 0; i < 25; i++)
            bitinterleave(plain[i], &g_theta_state[2 * i], &g_theta_state[2 * i + 1]);
        expe_slothy(1);
        for (uint32_t i = 0; i < 25; i++)
            mm += (bitdeinterleave(g_theta_state[2 * i], g_theta_state[2 * i + 1]) != ref[i]);
        for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fc_ref[i]);
        expe_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expe_seq(1000);
        rep_cyc[35][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expe_slothy(1000);
        rep_cyc[36][r] = dwt_span_end();
    }

    /* ?뚮옖 B 寃利? ?낅┰ ?곹깭 4媛?媛곴컖 ?명꽣由щ툕??E/O ?덉씤???⑦궧 ??1?쇱슫?????議?*/
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t mm = 0;
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0x9e3779b97f4a7c15ull * (s * 31 + i + 7);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                uint32_t e, o;
                bitinterleave(plain[s][i], &e, &o);
                g_mve[4 * i + s] = e;            /* E[i] ?덉씤 s */
                g_mve[128 + 4 * i + s] = o;      /* O[i] ?덉씤 s */
            }
        keccak4_round_mve(1, g_mve);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++)
                mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);
        mve4_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        keccak4_round_mve(1000, g_mve);
        rep_cyc[37][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 F 寃利? 援먯감?먮룄 ?쇱슫??寃곌낵媛 ?뺥솗?댁빞 (A???덉??ㅽ꽣 ?꾩슜?대씪 臾닿컙?? */
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t mm = 0;
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0x27d4eb2f165667b1ull * (s * 37 + i + 11);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                uint32_t e, o;
                bitinterleave(plain[s][i], &e, &o);
                g_mve[4 * i + s] = e;
                g_mve[128 + 4 * i + s] = o;
            }
        coissue_zip(1, g_mve);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++)
                mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);
        coissue_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        coissue_scalar(1000);
        rep_cyc[38][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        coissue_zip(1000, g_mve);
        rep_cyc[39][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 F-solver 寃利? SLOTHY ?ㅼ?以꾪뙋 (吏?쇱? 媛숈? 珥덇린 ?곹깭쨌媛숈? ?議? */
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t mm = 0;
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0xc2b2ae3d27d4eb4full * (s * 41 + i + 13);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                uint32_t e, o;
                bitinterleave(plain[s][i], &e, &o);
                g_mve[4 * i + s] = e;
                g_mve[128 + 4 * i + s] = o;
            }
        coissue_slothy(1, g_mve);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++)
                mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);
        /* v0.4 ?ъ뒪耳以꾪뙋 ??媛숈? 珥덇린 ?곹깭濡??ш?利?(mismatch??cosol???⑹궛) */
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                uint32_t e, o;
                bitinterleave(plain[s][i], &e, &o);
                g_mve[4 * i + s] = e;
                g_mve[128 + 4 * i + s] = o;
            }
        coissue_slothy2(1, g_mve);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++)
                mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);
        cosol_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        coissue_slothy(1000, g_mve);
        rep_cyc[40][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        coissue_slothy2(1000, g_mve);
        rep_cyc[71][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 G 寃利? 3-踰좎씠???쇱슫???⑤룆쨌肄붿씠?? ?뺣떟 ?議?*/
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t mm = 0;
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0x165667b19e3779f9ull * (s * 43 + i + 17);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);

        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                uint32_t e, o;
                bitinterleave(plain[s][i], &e, &o);
                g_mve[4 * i + s] = e;
                g_mve[128 + 4 * i + s] = o;
            }
        keccak4_mve3(1, g_mve);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++)
                mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);

        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                uint32_t e, o;
                bitinterleave(plain[s][i], &e, &o);
                g_mve[4 * i + s] = e;
                g_mve[128 + 4 * i + s] = o;
            }
        coissue3_zip(1, g_mve);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++)
                mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);
        expg_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        keccak4_mve3(1000, g_mve);
        rep_cyc[41][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        coissue3_zip(1000, g_mve);
        rep_cyc[42][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 H 寃利? flat?뭦ack?뭨ound ?놁씠?뭫npack?뭚lat' ???먮낯怨??쇱튂 (?꾩튂 ?뺣났 ??벑) */
    {
        uint32_t mm = 0;
        for (uint32_t i = 0; i < 200; i++) g_flat[i] = 0xa5a5u * (i + 1) ^ (i << 16);
        pack4_lane(g_flat, g_mve);
        for (uint32_t i = 0; i < 200; i++) g_flat[i] = 0;   /* 吏?곌퀬 ??쟾移섎줈 蹂듭썝 */
        unpack4_lane(g_mve, g_flat);
        for (uint32_t i = 0; i < 200; i++)
            mm += (g_flat[i] != (uint32_t)(0xa5a5u * (i + 1) ^ (i << 16)));
        exph_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        pack4_lane(g_flat, g_mve);
        unpack4_lane(g_mve, g_flat);
        rep_cyc[43][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 I 寃利? yield3 怨?寃곌낵 == base(fiat_mul_ref) ??3-?덉??ㅽ꽣 ?묐낫媛 ?뺣떟 遺덈? */
    {
        uint32_t ref[10], y3[10];
        fiat_mul_ref(ref, g_fc_a, g_fc_b);
        fiat_mul_yield3(y3, g_fc_a, g_fc_b);
        uint32_t mm = 0;
        for (uint32_t i = 0; i < 10; i++) mm += (y3[i] != ref[i]);
        expi_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) fiat_mul_ref(g_fc_out, g_fc_a, g_fc_b);
        rep_cyc[44][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) fiat_mul_yield3(g_fc_out, g_fc_a, g_fc_b);
        rep_cyc[45][r] = dwt_span_end();
    }

    /* v0.4 寃利? 2-踰좎씠???쇱슫???⑤룆쨌肄붿씠?? ?뺣떟 + yield2 怨??뺣떟 */
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t mm = 0;
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0xff51afd7ed558ccdull * (s * 47 + i + 19);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);

        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                uint32_t e, o;
                bitinterleave(plain[s][i], &e, &o);
                g_mve[4 * i + s] = e;
                g_mve[128 + 4 * i + s] = o;
            }
        keccak4_mve2(1, g_mve);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++)
                mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);

        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                uint32_t e, o;
                bitinterleave(plain[s][i], &e, &o);
                g_mve[4 * i + s] = e;
                g_mve[128 + 4 * i + s] = o;
            }
        coissue2_zip(1, g_mve);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++)
                mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);

        uint32_t y2[10], fref[10];
        fiat_mul_ref(fref, g_fc_a, g_fc_b);
        fiat_mul_yield2(y2, g_fc_a, g_fc_b);
        for (uint32_t i = 0; i < 10; i++) mm += (y2[i] != fref[i]);
        v04_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        keccak4_mve2(1000, g_mve);
        rep_cyc[46][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        coissue2_zip(1000, g_mve);
        rep_cyc[47][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < 100; i++) fiat_mul_yield2(g_fc_out, g_fc_a, g_fc_b);
        rep_cyc[48][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 J 寃利? seq/stitch 媛곴컖 怨?fiat_ref)쨌?쇱슫??C ref) ?????뺣떟?댁뼱??*/
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t fref[10];
        uint32_t mm = 0;
        uint64_t *lanes = (uint64_t *) 0;   /* g_mve??uint32, ?꾨옒 ?섎룞 ?붿씤?곕━釉?*/
        (void) lanes;
        fiat_mul_ref(fref, g_fc_a, g_fc_b);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0x9e3779b185ebca87ull * (s * 53 + i + 23);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);

        for (uint32_t v = 0; v < 3; v++) {
            for (uint32_t s = 0; s < 4; s++)
                for (uint32_t i = 0; i < 25; i++) {
                    uint32_t e, o;
                    bitinterleave(plain[s][i], &e, &o);
                    g_mve[4 * i + s] = e;
                    g_mve[128 + 4 * i + s] = o;
                }
            if (v == 0) expj_seq(1);
            else if (v == 1) expj_stitch(1);
            else expj_stitch2(1);
            for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fref[i]);
            for (uint32_t s = 0; s < 4; s++)
                for (uint32_t i = 0; i < 25; i++)
                    mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);
        }
        expj_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expj_seq(1000);
        rep_cyc[49][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expj_stitch(1000);
        rep_cyc[50][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expj_stitch2(1000);
        rep_cyc[92][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 K 寃利? ??諛곗튂 紐⑤몢 怨??뺣떟 + ?쇱슫??3???곹깭 ?뺣떟 */
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t fref[10];
        uint32_t mm = 0;
        fiat_mul_ref(fref, g_fc_a, g_fc_b);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0xc4ceb9fe1a85ec53ull * (s * 59 + i + 29);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t rr = 0; rr < 3; rr++) keccak_round_reference(ref[s]);

        for (uint32_t v = 0; v < 3; v++) {
            for (uint32_t s = 0; s < 4; s++)
                for (uint32_t i = 0; i < 25; i++) {
                    uint32_t e, o;
                    bitinterleave(plain[s][i], &e, &o);
                    g_mve[4 * i + s] = e;
                    g_mve[128 + 4 * i + s] = o;
                }
            if (v == 0) expk_seq(1);
            else if (v == 1) expk_coarse(1);
            else expk_stitch(1);
            for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fref[i]);
            for (uint32_t s = 0; s < 4; s++)
                for (uint32_t i = 0; i < 25; i++)
                    mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);
        }
        expk_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expk_seq(1000);
        rep_cyc[51][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expk_coarse(1000);
        rep_cyc[52][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expk_stitch(1000);
        rep_cyc[53][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 L 寃利? 踰꾪꽣?뚮씪?댄삎 3?⑥뒪 C 紐⑤뜽 ?議?(E'=E+lo(E*O), O'=O-hi(E*O)) */
    {
        uint32_t ref_e[100], ref_o[100];
        uint32_t mm = 0;
        for (uint32_t i = 0; i < 100; i++) {
            ref_e[i] = 0x1234567u * (i + 3);
            ref_o[i] = 0x89abcdeu * (i + 7);
            g_mve[i] = ref_e[i];
            g_mve[128 + i] = ref_o[i];
        }
        for (uint32_t p = 0; p < 3; p++)
            for (uint32_t i = 0; i < 100; i++) {
                uint64_t prod = (uint64_t) ref_e[i] * ref_o[i];
                ref_e[i] += (uint32_t) prod;
                ref_o[i] -= (uint32_t) (prod >> 32);
            }
        expl_ntt(1, g_mve);
        for (uint32_t i = 0; i < 100; i++)
            mm += (g_mve[i] != ref_e[i]) + (g_mve[128 + i] != ref_o[i]);
        expl_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expl_ntt(1000, g_mve);
        rep_cyc[54][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expl_zip(1000, g_mve);
        rep_cyc[55][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expl_sntt(1000, g_mve);
        rep_cyc[56][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expl_szip(1000, g_mve);
        rep_cyc[57][r] = dwt_span_end();
    }

    /* ?곸닔?쒓컙 ?ㅼ쬆: ?꾪? ?ㅻⅨ ?낅젰?쇰줈 expj_stitch ?ъ륫????[50]怨?遺꾪룷 ?숈씪?댁빞.
     * fiat limb 踰붿쐞(??^26) 蹂댁〈 XOR. */
    for (uint32_t i = 0; i < 10; i++) {
        g_fc_a[i] ^= 0x1abcdefu;
        g_fc_b[i] ^= 0x0fedcbau;
    }
    for (uint32_t i = 0; i < 256; i++) g_mve[i] = 0x9e3779b9u * (i + 101);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expj_stitch(1000);
        rep_cyc[58][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 M 寃利? 怨??뺣떟(??g_fc_a/b 湲곗?) + ?쇱슫??1???곹깭 ?뺣떟, ??諛곗튂 紐⑤몢 */
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t fref[10];
        uint32_t mm = 0;
        fiat_mul_ref(fref, g_fc_a, g_fc_b);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0x2545f4914f6cdd1dull * (s * 61 + i + 31);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);
        for (uint32_t v = 0; v < 6; v++) {
            for (uint32_t s = 0; s < 4; s++)
                for (uint32_t i = 0; i < 25; i++) {
                    uint32_t e, o;
                    bitinterleave(plain[s][i], &e, &o);
                    g_mve[4 * i + s] = e;
                    g_mve[128 + 4 * i + s] = o;
                }
            if (v == 0) expm_seq(1);
            else if (v == 1) expm_stitch(1);
            else if (v == 2) expm4_seq(1);
            else if (v == 3) expm4_stitch(1);
            else if (v == 4) expm_stitch2(1);
            else expm4_stitch2(1);
            for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fref[i]);
            for (uint32_t s = 0; s < 4; s++)
                for (uint32_t i = 0; i < 25; i++)
                    mm += (bitdeinterleave(g_mve[4 * i + s], g_mve[128 + 4 * i + s]) != ref[s][i]);
        }
        expm_mismatch = mm;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expm_seq(1000);
        rep_cyc[59][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expm_stitch(1000);
        rep_cyc[60][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expm4_seq(1000);
        rep_cyc[61][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expm4_stitch(1000);
        rep_cyc[62][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expm_stitch2(1000);
        rep_cyc[94][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        expm4_stitch2(1000);
        rep_cyc[95][r] = dwt_span_end();
    }

    /* ?ㅽ뿕 N ???섏뼱留??ㅽ럺?몃읆(?⑹꽦, 寃利??놁쓬): umaal 횞 MVE ?⑥씪 ?대옒??
     * g_mve瑜??ㅽ겕?섏튂濡??곕?濡?諛섎뱶??紐⑤뱺 寃利???留????먯꽌 ?ㅽ뻾. ?щ’ 63~70. */
    {
        extern void pairn_veor(uint32_t iters);
        extern void pairn_veor_zip(uint32_t iters);
        extern void pairn_ldr(uint32_t iters);
        extern void pairn_ldr_zip(uint32_t iters);
        extern void pairn_str(uint32_t iters);
        extern void pairn_str_zip(uint32_t iters);
        extern void pairn_rot(uint32_t iters);
        extern void pairn_rot_zip(uint32_t iters);
        extern void pairn2_ldr(uint32_t iters);
        extern void pairn2_str(uint32_t iters);
        extern void pairn2_rot(uint32_t iters);
        extern void pairn_lsmix(uint32_t iters);
        extern void pairn_lsmix_zip(uint32_t iters);
        void (*const fns[13])(uint32_t) = {
            pairn_veor, pairn_veor_zip, pairn_ldr, pairn_ldr_zip,
            pairn_str, pairn_str_zip, pairn_rot, pairn_rot_zip,
            pairn2_ldr, pairn2_str, pairn2_rot,       /* ?щ’ 72~74: 2:1 鍮꾩쑉 */
            pairn_lsmix, pairn_lsmix_zip };           /* ?щ’ 75~76: LSU ?쇳빀 */
        for (uint32_t k = 0; k < 13; k++)
            for (uint32_t r = 0; r < REP_N; r++) {
                dwt_span_begin();
                fns[k](1000);
                rep_cyc[k < 8 ? 63 + k : 64 + k][r] = dwt_span_end();
            }
    }

    /* ?ㅽ뿕 P ??DTCM 諭낇겕 ?ㅽ럺?몃읆(?⑹꽦, 寃利??놁쓬): ?ㅼ뭡??濡쒕뱶??二쇱냼 鍮꾪듃[3:2]留?     * b=0..3 ?쇰줈 諛붽씀怨??섎㉧吏???꾨? 怨좎젙. ?ㅽ뿕 J????됰쪧 ?섎씫??LSU ?좊떅 寃쏀빀?몄?
     * 諭낇겕 異⑸룎?몄? 遺꾨━?쒕떎(SWOG 짠4.3). ?ㅽ뿕 N怨?媛숈? ?댁쑀濡?g_mve ?ㅽ겕?섏튂 =
     * 諛섎뱶??紐⑤뱺 寃利??? ?щ’ 77~85. gen_exp_p.py ?앹꽦. */
    {
        extern void pairp_vec(uint32_t iters);
        extern void pairp_s0(uint32_t iters);
        extern void pairp_s0_zip(uint32_t iters);
        extern void pairp_s1(uint32_t iters);
        extern void pairp_s1_zip(uint32_t iters);
        extern void pairp_s2(uint32_t iters);
        extern void pairp_s2_zip(uint32_t iters);
        extern void pairp_s3(uint32_t iters);
        extern void pairp_s3_zip(uint32_t iters);
        void (*const fns[9])(uint32_t) = {
            pairp_vec,                                /* ?щ’ 77: MVE ?⑤룆 湲곗???*/
            pairp_s0, pairp_s0_zip, pairp_s1, pairp_s1_zip,
            pairp_s2, pairp_s2_zip, pairp_s3, pairp_s3_zip };
        for (uint32_t k = 0; k < 9; k++)
            for (uint32_t r = 0; r < REP_N; r++) {
                dwt_span_begin();
                fns[k](1000);
                rep_cyc[77 + k][r] = dwt_span_end();
            }
    }

    /* ?ㅽ뿕 J-solo ??J ??A/B ?ㅽ듃由??⑤룆 鍮꾩슜 + ?섑띁 猷⑦봽 鍮꾩슜. ??됰쪧 遺꾨え min(A,B) 瑜?     * 異붿젙???꾨땲???ㅼ륫?쇰줈 ?뺤젙?쒕떎(?ㅽ뿕 P 媛 ?ㅼ뭡??濡쒕뱶 ?꾩쟾 ?몄텧???뺤젙?????꾩슂?댁쭚).
     * expj_* ? 媛숈? ?섑띁???ㅻ쾭?ㅻ뱶媛 ?숈씪 -> expj_loop 李④컧???깅┰. ?щ’ 86~88. */
    {
        extern void expj_a(uint32_t iters);
        extern void expj_b(uint32_t iters);
        extern void expj_loop(uint32_t iters);
        void (*const fns[3])(uint32_t) = { expj_a, expj_b, expj_loop };
        for (uint32_t k = 0; k < 3; k++)
            for (uint32_t r = 0; r < REP_N; r++) {
                dwt_span_begin();
                fns[k](1000);
                rep_cyc[86 + k][r] = dwt_span_end();
            }
    }

    /* ?ㅽ뿕 Q ???몄텧 223 ??遺꾪빐: B ?먯꽌 `vstrw` 121 媛쒕쭔 `vorr`(MVE ??벑)濡?諛붽씀怨?     * 紐낅졊 ??612)쨌`vldrw`(181)쨌A ?ㅽ듃由쇱쓣 ?꾨? J ? ?숈씪?섍쾶 怨좎젙???⑥씪 蹂???議?
     * 痢≪젙 ?꾩슜 而ㅻ꼸?대씪 湲곕뒫 ?깃?媛 ?꾨땲??-> KAT ????꾨떂. ?щ’ 89~91.
     * ?몄텧' = zip' - B'_solo - loop 濡?J ? 媛숈? ?뺤쓽. gen_exp_q.py ?앹꽦. */
    {
        extern void expq_b(uint32_t iters);
        extern void expq_stitch(uint32_t iters);
        extern void expq_stitch2(uint32_t iters);
        extern void expq_seq(uint32_t iters);
        void (*const fns[3])(uint32_t) = { expq_b, expq_stitch, expq_seq };
        for (uint32_t k = 0; k < 3; k++)
            for (uint32_t r = 0; r < REP_N; r++) {
                dwt_span_begin();
                fns[k](1000);
                rep_cyc[89 + k][r] = dwt_span_end();
            }
        for (uint32_t r = 0; r < REP_N; r++) {
            dwt_span_begin();
            expq_stitch2(1000);
            rep_cyc[93][r] = dwt_span_end();
        }
    }

    /* ?ㅽ뿕 T ??b0 + GP 臾댁뼇蹂?fiat. SLP 踰≫꽣?붾쭔 爰?q0~q7 異⑸룎???쇳븳 湲곕뒫 ?깃? 而ㅻ꼸.
     * 8媛?蹂??紐⑤몢 fiat 諛?4-way Keccak ?쇱슫?쒕? C 湲곗?媛믨낵 ?議고븳?? ?щ’ 96~103. */
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t fref[10];
        uint32_t mm = 0;
        void (*const fns[8])(uint32_t) = {
            expt_fiat, expt_b0, expt_seq, expt_stitch,
            expt_m8_seq, expt_m8_stitch, expt_m4_seq, expt_m4_stitch };

        fiat_mul_ref(fref, g_fc_a, g_fc_b);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0xd1342543de82ef95ull * (s * 67 + i + 37);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);

        for (uint32_t v = 0; v < 8; v++) {
            for (uint32_t s = 0; s < 4; s++)
                for (uint32_t i = 0; i < 25; i++) {
                    uint32_t e, o;
                    bitinterleave(plain[s][i], &e, &o);
                    g_mve[4 * i + s] = e;
                    g_mve[128 + 4 * i + s] = o;
                }
            fns[v](1);
            if (v != 1)
                for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fref[i]);
            if (v != 0)
                for (uint32_t s = 0; s < 4; s++)
                    for (uint32_t i = 0; i < 25; i++)
                        mm += (bitdeinterleave(g_mve[4 * i + s],
                                              g_mve[128 + 4 * i + s]) != ref[s][i]);
        }
        expt_mismatch = mm;

        for (uint32_t k = 0; k < 8; k++)
            for (uint32_t r = 0; r < REP_N; r++) {
                dwt_span_begin();
                fns[k](1000);
                rep_cyc[96 + k][r] = dwt_span_end();
            }
    }

    /* ?ㅽ뿕 U ??yield1 + one-GP b1. 23媛?而ㅻ꼸??fiat/Keccak 湲곕뒫??     * 媛곴컖 ?ъ큹湲고솕??C 湲곗?媛믨낵 ?議고븳 ???щ’ 104~126??痢≪젙?쒕떎. */
    {
        uint64_t plain[4][25], ref[4][25];
        uint32_t fref[10];
        uint32_t mm = 0;
        void (*const fns[23])(uint32_t) = {
            expu_y10, expu_y11,
            expu_lo10_b1, expu_lo10_seq, expu_lo10_stitch,
            expu_lo10_m4_seq, expu_lo10_m4_stitch,
            expu_lo10_m8_seq, expu_lo10_m8_stitch,
            expu_lo11_b1, expu_lo11_seq, expu_lo11_stitch,
            expu_lo11_m4_seq, expu_lo11_m4_stitch,
            expu_lo11_m8_seq, expu_lo11_m8_stitch,
            expu_hi11_b1, expu_hi11_seq, expu_hi11_stitch,
            expu_hi11_m4_seq, expu_hi11_m4_stitch,
            expu_hi11_m8_seq, expu_hi11_m8_stitch };

        fiat_mul_ref(fref, g_fc_a, g_fc_b);
        for (uint32_t s = 0; s < 4; s++)
            for (uint32_t i = 0; i < 25; i++) {
                plain[s][i] = 0x94d049bb133111ebull * (s * 71 + i + 43);
                ref[s][i] = plain[s][i];
            }
        for (uint32_t s = 0; s < 4; s++) keccak_round_reference(ref[s]);

        for (uint32_t v = 0; v < 23; v++) {
            for (uint32_t s = 0; s < 4; s++)
                for (uint32_t i = 0; i < 25; i++) {
                    uint32_t e, o;
                    bitinterleave(plain[s][i], &e, &o);
                    g_mve[4 * i + s] = e;
                    g_mve[128 + 4 * i + s] = o;
                }
            fns[v](1);
            if (v != 2 && v != 9 && v != 16)
                for (uint32_t i = 0; i < 10; i++) mm += (g_fc_out[i] != fref[i]);
            if (v >= 2)
                for (uint32_t s = 0; s < 4; s++)
                    for (uint32_t i = 0; i < 25; i++)
                        mm += (bitdeinterleave(g_mve[4 * i + s],
                                              g_mve[128 + 4 * i + s]) != ref[s][i]);
        }
        expu_mismatch = mm;

        for (uint32_t k = 0; k < 23; k++)
            for (uint32_t r = 0; r < REP_N; r++) {
                dwt_span_begin();
                fns[k](1000);
                rep_cyc[104 + k][r] = dwt_span_end();
            }
    }

    /* ?ㅽ뿕 V ???뚭퀬由ъ쬁 蹂寃??놁씠 ??poly_ntt/poly_invntt ?몄텧 鍮꾩슜??遺꾨━. */
    {
        memset(&expv_poly, 0, sizeof(expv_poly));
        poly_ntt(&expv_poly);
        poly_invntt(&expv_poly);
        uint32_t mm = 0;
        for (uint32_t i = 0; i < KYBER_N; i++) mm += (expv_poly.coeffs[i] != 0);
        expv_mismatch = mm;

        for (uint32_t r = 0; r < REP_N; r++) {
            dwt_span_begin();
            for (uint32_t i = 0; i < 1000; i++) poly_ntt(&expv_poly);
            rep_cyc[127][r] = dwt_span_end();
        }
        for (uint32_t r = 0; r < REP_N; r++) {
            dwt_span_begin();
            for (uint32_t i = 0; i < 1000; i++) poly_invntt(&expv_poly);
            rep_cyc[128][r] = dwt_span_end();
        }
    }

    /* ?ㅽ뿕 W ??pqmx M85 forward 4醫? WIP M85 inverse, 紐낆떆??rev4 鍮꾩슜. */
    {
        void (*const forward[4])(int16_t *) = {
            ntt_kyber_1_23_45_67_no_trans_opt_m85,
            ntt_kyber_1_23_45_67_no_trans_vld4_opt_m85,
            ntt_kyber_12_345_67_opt_size_m85,
            ntt_kyber_12_345_67_opt_speed_m85
        };
        uint32_t mm = 0;
        for (uint32_t candidate = 0; candidate < 4; candidate++) {
            memcpy(expw_poly.coeffs, expw_input, sizeof(expw_input));
            forward[candidate](expw_poly.coeffs);
            mm += expw_compare_expected(&expw_poly);
        }
        expw_mismatch = mm;

        /* WIP branch??怨듭떇 inverse test: standard bit-reversed ?낅젰??rev4 ???몄텧. */
        memcpy(expw_poly.coeffs, expw_input, sizeof(expw_input));
        expw_rev4(&expw_poly);
        intt_kyber_1_23_45_67_opt_m85(expw_poly.coeffs);
        expw_inverse_m85_mismatch = expw_compare_inverse_expected(&expw_poly);

        /* forward? WIP inverse??noncanonical layout??洹몃?濡??곌껐?섎㈃ R=2^16 諛곗쑉. */
        memcpy(expw_poly.coeffs, expw_input, sizeof(expw_input));
        ntt_kyber_1_23_45_67_no_trans_opt_m85(expw_poly.coeffs);
        intt_kyber_1_23_45_67_opt_m85(expw_poly.coeffs);
        expw_roundtrip_m85_mismatch = expw_compare_montgomery_input(&expw_poly);

#define EXPW_BENCH(SLOT, FUNCTION)                                                \
        do {                                                                      \
            for (uint32_t r = 0; r < REP_N; r++) {                                \
                memcpy(expw_poly.coeffs, expw_input, sizeof(expw_input));         \
                dwt_span_begin();                                                  \
                for (uint32_t i = 0; i < 1000; i++) FUNCTION(expw_poly.coeffs);   \
                rep_cyc[(SLOT)][r] = dwt_span_end();                              \
            }                                                                     \
        } while (0)

        EXPW_BENCH(129, ntt_kyber_1_23_45_67_no_trans_opt_m85);
        EXPW_BENCH(130, ntt_kyber_1_23_45_67_no_trans_vld4_opt_m85);
        EXPW_BENCH(131, ntt_kyber_12_345_67_opt_size_m85);
        EXPW_BENCH(132, ntt_kyber_12_345_67_opt_speed_m85);
        EXPW_BENCH(135, intt_kyber_1_23_45_67_opt_m85);
#undef EXPW_BENCH
        for (uint32_t r = 0; r < REP_N; r++) {
            memcpy(expw_poly.coeffs, expw_input, sizeof(expw_input));
            dwt_span_begin();
            for (uint32_t i = 0; i < 1000; i++) expw_rev4(&expw_poly);
            rep_cyc[134][r] = dwt_span_end();
        }
    }
}

/* ==== Experiment AJ: C9(packing/CBD/msg) MVE — prereg 2026-08-24_expAJ_c9_mve ==== */
extern volatile uint32_t mlkem_c9_mode;
extern uint32_t mve_c9_selftest(void);

volatile uint32_t expaj_kat_mismatch = 9;
volatile uint32_t expaj_byte_mismatch = 9;
volatile uint32_t expaj_smoke_fails = 9;
volatile uint32_t expaj_xw_byte_mismatch = 9;
volatile uint32_t expaj_xw_smoke_fails = 9;
volatile uint32_t expaj_timing_mismatch = 9;
volatile uint32_t expaj_stack_canary_fails = 9;
volatile uint32_t expaj_stack_highwater = 0;

static void expaj_run_selftest(void)
{
    expaj_kat_mismatch = mve_c9_selftest();
}

/* A=X/Y/C8(c9=0), B=X/Y/C8+MVE C9(c9=1); NTT 모드는 양쪽 2/1 고정. */
static void mlkem_expaj_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa9000000u + s * 0x00009e37u;

        mlkem_ntt_mode = 2;
        mlkem_invntt_mode = 1;
        mlkem_c9_mode = 0;
        PQCLEAN_randombytes_reset(seed);
        crypto_kem_keypair(mk_pk, mk_sk);
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
        mk_ct[0] ^= 1u;
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
        memcpy(expy_ref_reject, mk_ss_d, sizeof(expy_ref_reject));
        mk_ct[0] ^= 1u;

        mlkem_c9_mode = 1;
        PQCLEAN_randombytes_reset(seed);
        crypto_kem_keypair(mk_pk, mk_sk);
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) != 0);
        mk_ct[0] ^= 1u;
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        mismatch += byte_mismatches(mk_ss_d, expy_ref_reject, sizeof(expy_ref_reject));
        fails += (memcmp(mk_ss_e, mk_ss_d, CRYPTO_BYTES) == 0);
        mk_ct[0] ^= 1u;
    }

    expaj_byte_mismatch = mismatch;
    expaj_smoke_fails = fails;
    mlkem_c9_mode = 0;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
}

static void xwing_expaj_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa9110000u + s * 0x00009e37u;

        mlkem_ntt_mode = 2;
        mlkem_invntt_mode = 1;
        mlkem_c9_mode = 0;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
        xw_ct[0] ^= 1u;
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) == 0);
        memcpy(xw_ref_reject, xw_ss_d, sizeof(xw_ref_reject));
        xw_ct[0] ^= 1u;

        mlkem_c9_mode = 1;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        mismatch += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        mismatch += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        mismatch += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
        mismatch += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        mismatch += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        xw_ct[0] ^= 1u;
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        mismatch += byte_mismatches(xw_ss_d, xw_ref_reject, sizeof(xw_ref_reject));
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) == 0);
        xw_ct[0] ^= 1u;
    }

    expaj_xw_byte_mismatch = mismatch;
    expaj_xw_smoke_fails = fails;
    mlkem_c9_mode = 0;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
    PQCLEAN_randombytes_reset(0x42424242u);
}

static volatile uint32_t expaj_bench_mode;
static volatile uint32_t expaj_bench_slot_base;

static void bench_expaj_mlkem_reps(void)
{
    const uint32_t slot = expaj_bench_slot_base;
    mlkem_ntt_mode = 2;
    mlkem_invntt_mode = 1;
    mlkem_c9_mode = expaj_bench_mode;
    PQCLEAN_randombytes_reset(0xa95a5a5au);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_keypair(mk_pk, mk_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_enc(mk_ct, mk_ss_e, mk_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        crypto_kem_dec(mk_ss_d, mk_ct, mk_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    if (slot == 261u) {
        memcpy(expx_ref_pk, mk_pk, sizeof(expx_ref_pk));
        memcpy(expx_ref_sk, mk_sk, sizeof(expx_ref_sk));
        memcpy(expx_ref_ct, mk_ct, sizeof(expx_ref_ct));
        memcpy(expx_ref_ss_e, mk_ss_e, sizeof(expx_ref_ss_e));
        memcpy(expx_ref_ss_d, mk_ss_d, sizeof(expx_ref_ss_d));
    } else {
        expaj_timing_mismatch += byte_mismatches(mk_pk, expx_ref_pk, sizeof(expx_ref_pk));
        expaj_timing_mismatch += byte_mismatches(mk_sk, expx_ref_sk, sizeof(expx_ref_sk));
        expaj_timing_mismatch += byte_mismatches(mk_ct, expx_ref_ct, sizeof(expx_ref_ct));
        expaj_timing_mismatch += byte_mismatches(mk_ss_e, expx_ref_ss_e, sizeof(expx_ref_ss_e));
        expaj_timing_mismatch += byte_mismatches(mk_ss_d, expx_ref_ss_d, sizeof(expx_ref_ss_d));
    }
    mlkem_c9_mode = 0;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
}

static void bench_expaj_xwing_reps(void)
{
    const uint32_t slot = expaj_bench_slot_base;
    mlkem_ntt_mode = 2;
    mlkem_invntt_mode = 1;
    mlkem_c9_mode = expaj_bench_mode;
    PQCLEAN_randombytes_reset(0xa9ab5a5au);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    if (slot == 273u) {
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
    } else {
        expaj_timing_mismatch += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        expaj_timing_mismatch += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        expaj_timing_mismatch += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
        expaj_timing_mismatch += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        expaj_timing_mismatch += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
    }
    mlkem_c9_mode = 0;
    mlkem_ntt_mode = 0;
    mlkem_invntt_mode = 0;
}

static void expaj_stack_prepare(void)
{
    memset(dtcm_stack, 0x7e, sizeof(dtcm_stack));
    expaj_stack_canary_fails = 0;
    expaj_stack_highwater = 0;
}

static void expaj_stack_check(void)
{
    uint32_t first_used = sizeof(dtcm_stack);
    for (uint32_t i = 0; i < sizeof(dtcm_stack); i++) {
        if (dtcm_stack[i] != 0x7eu) {
            first_used = i;
            break;
        }
    }
    for (uint32_t i = 0; i < 64u; i++) {
        expaj_stack_canary_fails += (dtcm_stack[i] != 0x7eu);
    }
    expaj_stack_highwater = sizeof(dtcm_stack) - first_used;
}

#include "expAL_factorial.inc"
#include "expAM_slots.inc"
#include "expAM_slots_b.inc"
#include "expAN_slots.inc"
#include "expAT_slots.inc"
#include "expAU_slots.inc"
#include "expAW_slots.inc"
#include "expBA_slots.inc"
#include "expBB_slots.inc"
#include "expBC_slots.inc"
#include "expBF_slots.inc"
#include "expBH_slots.inc"
#include "expBI_slots.inc"
#include "expBJ_slots.inc"
#include "expBK_slots.inc"
#include "expBL_slots.inc"
#include "expBM_slots.inc"
#include "expBN_slots.inc"
#include "expBO_slots.inc"
#include "expBS_slots.inc"
#include "expBU_draft10.inc"
#include "expBW_d10kat.inc"
#include "expBV_slots.inc"
#include "expBX_slots.inc"
#include "expBZ_slots.inc"
#include "expCA_slots.inc"
#include "expCB_slots.inc"
#include "expCC_slots.inc"
#include "expCD_slots.inc"
#include "expCE_slots.inc"
#include "expCG_slots.inc"
#include "expCJ_slots.inc"

/* expDD: DWT cycle counter를 끈 PMU 전용 보조 측정.
 * 사전등록: 2026-08-30_expDD_pmu_recovery_prereg.md */
enum { EXPDD_CYC, EXPDD_INST, EXPDD_STALL, EXPDD_FE, EXPDD_BE, EXPDD_METRICS };

static uint32_t expdd_values[4][4][EXPDD_METRICS];
static uint32_t expdd_calib[EXPDD_METRICS];
static uint32_t expdd_sw_count, expdd_chain_count, expdd_chain_high;
static uint32_t expdd_dwt_ctrl;
static volatile uint32_t expdd_cell;

static void expdd_config_pairs(void)
{
    ARM_PMU_CNTR_Disable(0xffffffffu);
    ARM_PMU_Disable();
    ARM_PMU_Enable();
    for (uint32_t p = 0; p < 4u; p++) {
        ARM_PMU_Set_EVTYPER(2u * p, PAIR[p].id);
        ARM_PMU_Set_EVTYPER(2u * p + 1u, ARM_PMU_CHAIN);
    }
}

static void expdd_start(void)
{
    ARM_PMU_CNTR_Disable(0xffffffffu);
    ARM_PMU_EVCNTR_ALL_Reset();
    ARM_PMU_CYCCNT_Reset();
    __DSB();
    __ISB();
    ARM_PMU_CNTR_Enable((1ul << 31) | 0xffu);
}

static void expdd_stop(uint32_t out[EXPDD_METRICS])
{
    __DSB();
    __ISB();
    ARM_PMU_CNTR_Disable(0xffffffffu);
    out[EXPDD_CYC] = ARM_PMU_Get_CCNTR();
    out[EXPDD_INST] = pair_read(0u);
    out[EXPDD_STALL] = pair_read(1u);
    out[EXPDD_FE] = pair_read(2u);
    out[EXPDD_BE] = pair_read(3u);
}

static void expdd_selftest(void)
{
    volatile uint32_t i;

    CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;
    DWT->CTRL &= ~DWT_CTRL_CYCCNTENA_Msk;
    __DSB();
    __ISB();
    expdd_dwt_ctrl = DWT->CTRL;

    DCB->DAUTHCTRL |= 0x0fu;
    ARM_PMU_CNTR_Disable(0xffffffffu);
    ARM_PMU_Disable();
    ARM_PMU_Enable();
    ARM_PMU_Set_EVTYPER(0u, ARM_PMU_SW_INCR);
    ARM_PMU_EVCNTR_ALL_Reset();
    ARM_PMU_CNTR_Enable(1u);
    for (i = 0u; i < 100u; i++) ARM_PMU_CNTR_Increment(1u);
    ARM_PMU_CNTR_Disable(1u);
    expdd_sw_count = ARM_PMU_Get_EVCNTR(0u);

    ARM_PMU_CNTR_Disable(0xffffffffu);
    ARM_PMU_Set_EVTYPER(0u, ARM_PMU_INST_RETIRED);
    ARM_PMU_Set_EVTYPER(1u, ARM_PMU_CHAIN);
    ARM_PMU_EVCNTR_ALL_Reset();
    ARM_PMU_CNTR_Enable(3u);
    for (i = 0u; i < 100000u; i++) __NOP();
    ARM_PMU_CNTR_Disable(3u);
    expdd_chain_high = ARM_PMU_Get_EVCNTR(1u);
    expdd_chain_count = (expdd_chain_high << 16) | ARM_PMU_Get_EVCNTR(0u);

    expdd_config_pairs();
    expdd_start();
    expdd_stop(expdd_calib);
}

static void expdd_prepare(uint32_t mode, uint32_t op)
{
    d10_set_optimizations(mode);
    if (op == 0u) {
        PQCLEAN_randombytes_reset(0xdd001001u);
        return;
    }

    PQCLEAN_randombytes_reset(0xdd001001u);
    d10_keypair(d10_pk, d10_sk);
    d10_expand(&d10_cache, d10_sk);
    PQCLEAN_randombytes_reset(0xdd002002u);
    if (op >= 2u) (void) d10_enc(d10_ct, d10_ss_e, d10_pk);
}

static void expdd_measure_op(uint32_t mode, uint32_t op,
                             uint32_t out[EXPDD_METRICS])
{
    expdd_prepare(mode, op);
    expdd_start();
    if (op == 0u) {
        d10_keypair(d10_pk, d10_sk);
    } else if (op == 1u) {
        (void) d10_enc(d10_ct, d10_ss_e, d10_pk);
    } else if (op == 2u) {
        d10_dec_warm(d10_ss_d, d10_ct);
    } else {
        d10_dec_cold(d10_ss_d, d10_ct, d10_sk);
    }
    expdd_stop(out);
    d10_set_optimizations(0u);
}

static void expdd_measure_cell(void)
{
    static const uint8_t order[4] = {0u, 1u, 1u, 0u};
    const uint32_t cell = expdd_cell;
    for (uint32_t op = 0u; op < 4u; op++) {
        expdd_measure_op(order[cell], op, expdd_values[cell][op]);
    }
}

static void expdd_print_metrics(const uint32_t value[EXPDD_METRICS])
{
    uart_puts(" cyc="); uart_put_u32(value[EXPDD_CYC]);
    uart_puts(" inst="); uart_put_u32(value[EXPDD_INST]);
    uart_puts(" stall="); uart_put_u32(value[EXPDD_STALL]);
    uart_puts(" fe="); uart_put_u32(value[EXPDD_FE]);
    uart_puts(" be="); uart_put_u32(value[EXPDD_BE]);
}

static void expdd_run_all(void)
{
    static const char *const opname[4] = {"keygen", "encaps", "warm", "cold"};
    static const char modechar[4] = {'A', 'B', 'B', 'A'};
    uint32_t fail = 0u;

    run_on_stack(expcj_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expDD equiv: bytes-mm="); uart_put_u32(expcj_byte_mm);
    uart_puts(" smoke="); uart_put_u32(expcj_smoke);
    uart_puts(" reject-mm="); uart_put_u32(expcj_reject_mm);
    uart_puts(" coldwarm-mm="); uart_put_u32(expcj_coldwarm_mm);
    uart_puts("\n");
    fail += expcj_byte_mm + expcj_smoke + expcj_reject_mm + expcj_coldwarm_mm;

    expdd_selftest();
    uart_puts("expDD selftest: dwt_ctrl="); uart_put_u32(expdd_dwt_ctrl);
    uart_puts(" cyccntena="); uart_put_u32((expdd_dwt_ctrl & DWT_CTRL_CYCCNTENA_Msk) != 0u);
    uart_puts(" sw100="); uart_put_u32(expdd_sw_count);
    uart_puts(" chain="); uart_put_u32(expdd_chain_count);
    uart_puts(" high="); uart_put_u32(expdd_chain_high);
    uart_puts("\nexpDD calib:"); expdd_print_metrics(expdd_calib); uart_puts("\n");
    fail += ((expdd_dwt_ctrl & DWT_CTRL_CYCCNTENA_Msk) != 0u);
    fail += (expdd_sw_count != 100u);
    fail += (expdd_chain_count <= 65535u) || (expdd_chain_high == 0u);

    for (uint32_t cell = 0u; cell < 4u; cell++) {
        expdd_cell = cell;
        run_on_stack(expdd_measure_cell, dtcm_stack + sizeof(dtcm_stack));
    }

    for (uint32_t cell = 0u; cell < 4u; cell++) {
        for (uint32_t op = 0u; op < 4u; op++) {
            uart_puts("expDD cell="); uart_put_u32(cell);
            uart_puts(" mode="); uart_putc(modechar[cell]);
            uart_puts(" op="); uart_puts(opname[op]);
            expdd_print_metrics(expdd_values[cell][op]);
            uart_puts("\n");
            fail += (expdd_values[cell][op][EXPDD_CYC] == 0u);
            fail += (expdd_values[cell][op][EXPDD_INST] == 0u);
        }
    }

    uart_puts(fail == 0u ? "expDD PMU GATE PASS\n" : "expDD PMU GATE FAIL\n");
    harness_fails += fail;
}

void harness_main(void)
{
    /* ITCM ?щ났??蹂듭썝): 遺????ITCM 0x18쨌0xE0??8諛붿씠??釉붾줉 2媛쒓? 誘몄긽???곌린濡?     * 源⑥????꾩긽 愿李?2026-08-16, J-Link ?묒냽 ?ㅽ겕由쏀듃 ?섏떖). BSP DDSC 蹂듭궗 ?댄썑??     * 諛쒖깮?섎?濡?痢≪젙 吏곸쟾???뚮옒???먮낯(LMA)?먯꽌 ?듭㎏濡??щ났?ы븳?? 64鍮꾪듃 ?⑥쐞(ECC). */
    {
        extern uint64_t __itcm_from_flash$$Base, __itcm_from_flash$$Limit, __itcm_from_flash$$Load;
        uint64_t       *dst = &__itcm_from_flash$$Base;
        uint64_t       *end = &__itcm_from_flash$$Limit;
        const uint64_t *src = (const uint64_t *) &__itcm_from_flash$$Load;
        while (dst < end) { *dst++ = *src++; }
        __DSB(); __ISB();
    }

    /* itcm_pad.c???⑤뱶媛 留곸빱 --gc-sections??踰꾨젮吏吏 ?딄쾶 李몄“ 怨좎젙 */
    {
        extern const uint8_t g_itcm_bad_granule_pad[256];
        (void) *(volatile const uint8_t *) g_itcm_bad_granule_pad;
    }

    uart_puts("=== EK-RA8M1 harness: KAT + DWT/PMU (ITCM/DTCM) ===\n\n");

    harness_fails = kat_run();
    uart_puts(harness_fails ? "\nKAT FAIL\n\n" : "\nKAT ALL PASS -- streams A+B verified on board\n\n");

    /* expDD는 PMU 복구만 다루므로 기존 장시간 전체 하네스는 실행하지 않는다. */
    expdd_run_all();
    uart_puts("HARNESS DONE\n");
    __DSB();
    harness_done = 1;
    return;

    dwt_setup();
    pmu_setup();

    perf_start();
    perf_stop_report("calib-empty", 1);

    perf_start();
    run_on_stack(bench_keccak, dtcm_stack + sizeof(dtcm_stack));
    perf_stop_report("keccak-f1600", 1000);

    perf_start();
    run_on_stack(bench_x25519, dtcm_stack + sizeof(dtcm_stack));
    perf_stop_report("x25519-scalarmult", 10);

    /* N=100 per-rep (怨꾪쉷??짠6.2) ???몄뒪?멸? rep_cyc 諛곗뿴濡?以묒븰媛?怨꾩궛 */
    run_on_stack(bench_calib_reps, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(bench_keccak_reps, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(bench_x25519_reps, dtcm_stack + sizeof(dtcm_stack));

    /* K3: ML-KEM-768 ?뺣났 寃利?+ ?곗궛蹂?keccak ?쒖뿴 ?몄텧 ??+ N=100 痢≪젙 */
    run_on_stack(mlkem_smoke, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("== K3: ML-KEM-768 (pqm4 m4fspeed) ==\n");
    uart_puts(mlkem_smoke_fails ? "roundtrip+reject: FAIL\n" : "roundtrip+reject: OK\n");
    harness_fails += mlkem_smoke_fails;
    uart_puts("keccak perms/op: keygen "); uart_put_u32(kc_keygen);
    uart_puts("  encaps "); uart_put_u32(kc_encaps);
    uart_puts("  decaps "); uart_put_u32(kc_decaps);
    uart_puts("  combiner "); uart_put_u32(kc_combiner);
    uart_puts("\n");
    run_on_stack(mlkem_expx_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expX bytes-mm: "); uart_put_u32(expx_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expx_smoke_fails);
    uart_puts(" align-base-bits="); uart_put_u32(expx_align_baseline);
    uart_puts(" align-candidate-bits="); uart_put_u32(expx_align_candidate);
    uart_puts("\n");
    harness_fails += expx_byte_mismatch + expx_smoke_fails;
    /* ABBA: ?숈씪 ?⑥닔/stack/RNG stream?쇰줈 ?ㅽ뻾 ?쒖꽌 ?명뼢源뚯? 吏곸젒 ?議고븳?? */
    expx_timing_mismatch = 0;
    expx_stack_prepare();
    expx_bench_mode = 0; expx_bench_slot_base = 3;
    run_on_stack(bench_expx_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expx_bench_mode = 1; expx_bench_slot_base = 136;
    run_on_stack(bench_expx_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expx_bench_mode = 1; expx_bench_slot_base = 139;
    run_on_stack(bench_expx_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expx_bench_mode = 0; expx_bench_slot_base = 142;
    run_on_stack(bench_expx_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expx_stack_check();
    uart_puts("expX timing-mm: "); uart_put_u32(expx_timing_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expx_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expx_stack_highwater);
    uart_puts("\n");
    harness_fails += expx_timing_mismatch + expx_stack_canary_fails;

    run_on_stack(mlkem_expy_equivalence, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(expy_run_standalone_oracle, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expY bytes-mm: "); uart_put_u32(expy_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expy_smoke_fails);
    uart_puts(" oracle-mm="); uart_put_u32(expy_oracle_mismatch);
    uart_puts(" oracle-canary="); uart_put_u32(expy_oracle_canary_fails);
    uart_puts(" align-base-bits="); uart_put_u32(expy_align_baseline);
    uart_puts(" align-candidate-bits="); uart_put_u32(expy_align_candidate);
    uart_puts(" input-min="); uart_put_i32(expy_input_min);
    uart_puts(" input-max="); uart_put_i32(expy_input_max);
    uart_puts(" output-min="); uart_put_i32(expy_oracle_output_min);
    uart_puts(" output-max="); uart_put_i32(expy_oracle_output_max);
    uart_puts("\n");
    harness_fails += expy_byte_mismatch + expy_smoke_fails;
    harness_fails += expy_oracle_mismatch + expy_oracle_canary_fails;

    /* Y ABBA: X forward is common, inverse A=current and B=pqmx Plantard. */
    expy_timing_mismatch = 0;
    expy_stack_prepare();
    expy_bench_inv_mode = 0; expy_bench_slot_base = 145;
    run_on_stack(bench_expy_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expy_bench_inv_mode = 1; expy_bench_slot_base = 148;
    run_on_stack(bench_expy_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expy_bench_inv_mode = 1; expy_bench_slot_base = 151;
    run_on_stack(bench_expy_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expy_bench_inv_mode = 0; expy_bench_slot_base = 154;
    run_on_stack(bench_expy_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expy_stack_check();
    uart_puts("expY timing-mm: "); uart_put_u32(expy_timing_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expy_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expy_stack_highwater);
    uart_puts("\n");
    harness_fails += expy_timing_mismatch + expy_stack_canary_fails;

    run_on_stack(mlkem_expz_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expZ bytes-mm: "); uart_put_u32(expz_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expz_smoke_fails);
    uart_puts(" fwd-align-base="); uart_put_u32(expz_fwd_align_baseline);
    uart_puts(" fwd-align-candidate="); uart_put_u32(expz_fwd_align_candidate);
    uart_puts(" inv-align-base="); uart_put_u32(expz_inv_align_baseline);
    uart_puts(" inv-align-candidate="); uart_put_u32(expz_inv_align_candidate);
    uart_puts("\n");
    harness_fails += expz_byte_mismatch + expz_smoke_fails;

    expz_timing_mismatch = 0;
    expz_stack_prepare();
    expz_bench_mode = 0; expz_bench_slot_base = 157;
    run_on_stack(bench_expz_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expz_bench_mode = 1; expz_bench_slot_base = 160;
    run_on_stack(bench_expz_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expz_bench_mode = 1; expz_bench_slot_base = 163;
    run_on_stack(bench_expz_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expz_bench_mode = 0; expz_bench_slot_base = 166;
    run_on_stack(bench_expz_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expz_stack_check();
    uart_puts("expZ timing-mm: "); uart_put_u32(expz_timing_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expz_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expz_stack_highwater);
    uart_puts("\n");
    harness_fails += expz_timing_mismatch + expz_stack_canary_fails;

    run_on_stack(mlkem_expaa_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAA bytes-mm: "); uart_put_u32(expaa_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expaa_smoke_fails);
    uart_puts(" fwd-align-base="); uart_put_u32(expaa_fwd_align_baseline);
    uart_puts(" fwd-align-candidate="); uart_put_u32(expaa_fwd_align_candidate);
    uart_puts("\n");
    harness_fails += expaa_byte_mismatch + expaa_smoke_fails;

    expaa_timing_mismatch = 0;
    expaa_stack_prepare();
    expaa_bench_fwd_mode = 1; expaa_bench_slot_base = 169;
    run_on_stack(bench_expaa_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expaa_bench_fwd_mode = 2; expaa_bench_slot_base = 172;
    run_on_stack(bench_expaa_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expaa_bench_fwd_mode = 2; expaa_bench_slot_base = 175;
    run_on_stack(bench_expaa_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expaa_bench_fwd_mode = 1; expaa_bench_slot_base = 178;
    run_on_stack(bench_expaa_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expaa_stack_check();
    uart_puts("expAA timing-mm: "); uart_put_u32(expaa_timing_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expaa_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaa_stack_highwater);
    uart_puts("\n");
    harness_fails += expaa_timing_mismatch + expaa_stack_canary_fails;

    run_on_stack(xwing_expab_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAB bytes-mm: "); uart_put_u32(expab_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expab_smoke_fails);
    uart_puts("\n");
    harness_fails += expab_byte_mismatch + expab_smoke_fails;

    expab_timing_mismatch = 0;
    expab_stack_prepare();
    expab_bench_mode = 0; expab_bench_slot_base = 181;
    run_on_stack(bench_expab_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expab_bench_mode = 1; expab_bench_slot_base = 184;
    run_on_stack(bench_expab_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expab_bench_mode = 1; expab_bench_slot_base = 187;
    run_on_stack(bench_expab_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expab_bench_mode = 0; expab_bench_slot_base = 190;
    run_on_stack(bench_expab_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expab_stack_check();
    uart_puts("expAB timing-mm: "); uart_put_u32(expab_timing_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expab_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expab_stack_highwater);
    uart_puts("\n");
    harness_fails += expab_timing_mismatch + expab_stack_canary_fails;

    run_on_stack(expac_primitive_kats, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAE x4-kat-fails: "); uart_put_u32(expac_x4_kat_fails);
    uart_puts(" u-kat-fails="); uart_put_u32(expac_u_kat_fails);
    uart_puts("\n");
    harness_fails += expac_x4_kat_fails + expac_u_kat_fails;

    run_on_stack(xwing_expac_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAE bytes-mm: "); uart_put_u32(expac_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expac_smoke_fails);
    uart_puts("\n");
    harness_fails += expac_byte_mismatch + expac_smoke_fails;

    expac_timing_mismatch = 0;
    expac_stack_prepare();
    expac_bench_mode = 0; expac_bench_slot_base = 193;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 1; expac_bench_slot_base = 196;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 1; expac_bench_slot_base = 199;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 0; expac_bench_slot_base = 202;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));

    /* AE attribution: S-vs-X keeps x4 cost; F-vs-U isolates true U. */
    expac_bench_mode = 0; expac_bench_slot_base = 205;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 2; expac_bench_slot_base = 208;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 2; expac_bench_slot_base = 211;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 0; expac_bench_slot_base = 214;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));

    expac_bench_mode = 3; expac_bench_slot_base = 217;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 1; expac_bench_slot_base = 220;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 1; expac_bench_slot_base = 223;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_bench_mode = 3; expac_bench_slot_base = 226;
    run_on_stack(bench_expac_mode_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_stack_check();
    uart_puts("expAE timing-mm: "); uart_put_u32(expac_timing_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expac_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expac_stack_highwater);
    uart_puts("\n");
    harness_fails += expac_timing_mismatch + expac_stack_canary_fails;

    run_on_stack(expaf_count_u_paths, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(expaf_prepare_refs, dtcm_stack + sizeof(dtcm_stack));
    expaf_bench_mode = 0; expaf_bench_slot = 229;
    run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    expaf_bench_mode = 1; expaf_bench_slot = 230;
    run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    expaf_bench_mode = 1; expaf_bench_slot = 231;
    run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    expaf_bench_mode = 0; expaf_bench_slot = 232;
    run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    expaf_bench_mode = 2; expaf_bench_slot = 233;
    run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    expaf_bench_mode = 3; expaf_bench_slot = 234;
    run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    expaf_bench_mode = 3; expaf_bench_slot = 235;
    run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    expaf_bench_mode = 2; expaf_bench_slot = 236;
    run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAF path counts (u4-rounds/u8-rounds/real/dummy):\n");
    for (uint32_t op = 0; op < 3; op++) {
        uart_puts("  op"); uart_put_u32(op); uart_puts(": ");
        uart_put_u32(expaf_u4_rounds[op]); uart_putc('/');
        uart_put_u32(expaf_u8_rounds[op]); uart_putc('/');
        uart_put_u32(expaf_real_steps[op]); uart_putc('/');
        uart_put_u32(expaf_dummy_steps[op]); uart_putc('\n');
    }
    uart_puts("expAF mismatch: "); uart_put_u32(expaf_mismatch); uart_puts("\n");
    harness_fails += expaf_mismatch;

    expai_mismatch = 0;
    run_on_stack(expai_prepare, dtcm_stack + sizeof(dtcm_stack));
    expac_stack_prepare();
    expai_bench_mode = 0; expai_bench_slot = 237;
    run_on_stack(bench_expai_enc_reps, dtcm_stack + sizeof(dtcm_stack));
    expai_bench_mode = 1; expai_bench_slot = 240;
    run_on_stack(bench_expai_enc_reps, dtcm_stack + sizeof(dtcm_stack));
    expai_bench_mode = 1; expai_bench_slot = 243;
    run_on_stack(bench_expai_enc_reps, dtcm_stack + sizeof(dtcm_stack));
    expai_bench_mode = 0; expai_bench_slot = 246;
    run_on_stack(bench_expai_enc_reps, dtcm_stack + sizeof(dtcm_stack));
    expai_bench_mode = 0; expai_bench_slot = 249;
    run_on_stack(bench_expai_enc_reps, dtcm_stack + sizeof(dtcm_stack));
    expai_bench_mode = 2; expai_bench_slot = 252;
    run_on_stack(bench_expai_enc_reps, dtcm_stack + sizeof(dtcm_stack));
    expai_bench_mode = 2; expai_bench_slot = 255;
    run_on_stack(bench_expai_enc_reps, dtcm_stack + sizeof(dtcm_stack));
    expai_bench_mode = 0; expai_bench_slot = 258;
    run_on_stack(bench_expai_enc_reps, dtcm_stack + sizeof(dtcm_stack));
    expac_stack_check();
    uart_puts("expAI mismatch: "); uart_put_u32(expai_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expac_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expac_stack_highwater);
    uart_puts("\n");
    harness_fails += expai_mismatch + expac_stack_canary_fails;

    run_on_stack(bench_combiner_reps, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(bench_stitch_reps, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("mul256 full-vs-budget mismatch: "); uart_put_u32(mul256_mismatch);
    uart_puts("  /  stitched(product+theta) mismatch: "); uart_put_u32(stitched_mismatch);
    uart_puts("  /  bmid(theta x3) mismatch: "); uart_put_u32(bmid_mismatch);
    uart_puts("  /  bfull mismatch: "); uart_put_u32(bfull_mismatch);
    uart_puts("  /  expc mismatch: "); uart_put_u32(expc_mismatch);
    uart_puts("  /  expd mismatch: "); uart_put_u32(expd_mismatch);
    uart_puts("  /  expe mismatch: "); uart_put_u32(expe_mismatch);
    uart_puts("  /  mve4 mismatch: "); uart_put_u32(mve4_mismatch);
    uart_puts("  /  coissue mismatch: "); uart_put_u32(coissue_mismatch);
    uart_puts("  /  cosol mismatch: "); uart_put_u32(cosol_mismatch);
    uart_puts("  /  expg mismatch: "); uart_put_u32(expg_mismatch);
    uart_puts("  /  exph mismatch: "); uart_put_u32(exph_mismatch);
    uart_puts("  /  expi mismatch: "); uart_put_u32(expi_mismatch);
    uart_puts("  /  v04 mismatch: "); uart_put_u32(v04_mismatch);
    uart_puts("  /  expj mismatch: "); uart_put_u32(expj_mismatch);
    uart_puts("  /  expk mismatch: "); uart_put_u32(expk_mismatch);
    uart_puts("  /  expl mismatch: "); uart_put_u32(expl_mismatch);
    uart_puts("  /  expm mismatch: "); uart_put_u32(expm_mismatch);
    uart_puts("  /  expt mismatch: "); uart_put_u32(expt_mismatch);
    uart_puts("  /  expu mismatch: "); uart_put_u32(expu_mismatch);
    uart_puts("  /  expv mismatch: "); uart_put_u32(expv_mismatch);
    uart_puts("  /  expw mismatch: "); uart_put_u32(expw_mismatch);
    uart_puts(" m55-unavailable="); uart_put_u32(expw_m55_unavailable);
    uart_puts(" m85-inv-mm="); uart_put_u32(expw_inverse_m85_mismatch);
    uart_puts(" m85-roundtrip-mm="); uart_put_u32(expw_roundtrip_m85_mismatch);
    uart_puts("\n");
    harness_fails += expl_mismatch + expm_mismatch + expt_mismatch + expu_mismatch + expv_mismatch;
    harness_fails += expw_mismatch + expw_inverse_m85_mismatch + expw_roundtrip_m85_mismatch;
    harness_fails += mve4_mismatch + coissue_mismatch + cosol_mismatch + expg_mismatch
                     + exph_mismatch + expi_mismatch + v04_mismatch + expj_mismatch
                     + expk_mismatch;
    harness_fails += mul256_mismatch + stitched_mismatch + bmid_mismatch + bfull_mismatch
                     + expc_mismatch + expd_mismatch + expe_mismatch;
    /* ==== Experiment AJ: selftest → 동등성 → ABBA (ML-KEM, X-Wing) ==== */
    run_on_stack(expaj_run_selftest, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAJ kat-mm: "); uart_put_u32(expaj_kat_mismatch);
    uart_puts("\n");
    harness_fails += expaj_kat_mismatch;

    run_on_stack(mlkem_expaj_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAJ bytes-mm: "); uart_put_u32(expaj_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expaj_smoke_fails);
    uart_puts("\n");
    harness_fails += expaj_byte_mismatch + expaj_smoke_fails;

    run_on_stack(xwing_expaj_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAJ xw-bytes-mm: "); uart_put_u32(expaj_xw_byte_mismatch);
    uart_puts(" xw-smoke-fails="); uart_put_u32(expaj_xw_smoke_fails);
    uart_puts("\n");
    harness_fails += expaj_xw_byte_mismatch + expaj_xw_smoke_fails;

    expaj_timing_mismatch = 0;
    expaj_stack_prepare();
    expaj_bench_mode = 0; expaj_bench_slot_base = 261;
    run_on_stack(bench_expaj_mlkem_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 1; expaj_bench_slot_base = 264;
    run_on_stack(bench_expaj_mlkem_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 1; expaj_bench_slot_base = 267;
    run_on_stack(bench_expaj_mlkem_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 0; expaj_bench_slot_base = 270;
    run_on_stack(bench_expaj_mlkem_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 0; expaj_bench_slot_base = 273;
    run_on_stack(bench_expaj_xwing_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 1; expaj_bench_slot_base = 276;
    run_on_stack(bench_expaj_xwing_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 1; expaj_bench_slot_base = 279;
    run_on_stack(bench_expaj_xwing_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 0; expaj_bench_slot_base = 282;
    run_on_stack(bench_expaj_xwing_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAJ timing-mm: "); uart_put_u32(expaj_timing_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_timing_mismatch + expaj_stack_canary_fails;

    /* ==== Experiment AK1: C9 v1(1) vs v2(2) — 같은 ELF 단일변수 ==== */
    expaj_timing_mismatch = 0;
    expaj_stack_prepare();
    expaj_bench_mode = 1; expaj_bench_slot_base = 285;
    run_on_stack(bench_expaj_mlkem_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 2; expaj_bench_slot_base = 288;
    run_on_stack(bench_expaj_mlkem_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 2; expaj_bench_slot_base = 291;
    run_on_stack(bench_expaj_mlkem_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 1; expaj_bench_slot_base = 294;
    run_on_stack(bench_expaj_mlkem_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 1; expaj_bench_slot_base = 297;
    run_on_stack(bench_expaj_xwing_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 2; expaj_bench_slot_base = 300;
    run_on_stack(bench_expaj_xwing_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 2; expaj_bench_slot_base = 303;
    run_on_stack(bench_expaj_xwing_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_bench_mode = 1; expaj_bench_slot_base = 306;
    run_on_stack(bench_expaj_xwing_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAK timing-mm: "); uart_put_u32(expaj_timing_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_timing_mismatch + expaj_stack_canary_fails;

    /* ==== Experiment AL: same-ELF cumulative 2x2 ==== */
    expal_run_all();

    /* ==== Experiment AM1: MVE field-mul feasibility gate ==== */
    expam_run_all();

    /* ==== Experiment AM1b: AM1 미측정 항목 일괄 ==== */
    expamb_run_all();

    /* ==== Experiment AN: X-Wing top-level cycle attribution (E0-top) ==== */
    expan_run_all();

    /* ==== Experiment AT-0: constant-time table lookup cost ==== */
    expat_run_all();

    /* ==== Experiment AU (AT-2): fixed-base X25519 ==== */
    expau_run_all();

    /* ==== Experiment AW (AT-3): full X-Wing with X06 ==== */
    expaw_run_all();

    /* ==== Experiment BA: scalar-scalar dual-issue ==== */
    expba_run_all();

    /* ==== Experiment BB: fe25519_sqr reschedule ==== */
    expbb_run_all();

    /* ==== Experiment BC: X02 in full X-Wing ==== */
    expbc_run_all();

    /* ==== Experiment BF (K22): XOF absorb cache ==== */
    expbf_run_all();
    expbh_run_all();
    expbi_run_all();
    expbj_run_all();
    expbk_run_all();
    expbl_run_all();
    expbm_run_all();
    expbn_run_all();
    expbo_run_all();
    expbs_run_all();
    d10_run_all();
    d10kat_all();
    expbv_run_all();
    expbx_run_all();
    expbz_run_all();
    expca_run_all();
    expcb_run_all();
    expcc_run_all();
    expcd_run_all();
    expce_run_all();
    expcg_run_all();
    expcj_run_all();

    uart_puts("rep arrays ready x100 (775 slots)\n");

    uart_puts("HARNESS DONE\n");
    __DSB();
    harness_done = 1;
}
