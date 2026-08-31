/* 실험 BO (X03/X05 분모): ladder glue 세분.  Slots 662..665.
 *   662 fe25519_add 단가   663 fe25519_sub 단가
 *   664 fe25519_mul 단가(대조)  665 fe25519_sqr 단가(대조)
 * expAR §141 이 "나머지 23%의 내부 세분은 미측정"으로 남긴 것을 잰다.
 * 버퍼는 expBJ §1 규율대로 DTCM 스택. */

#define EXPBO_SLOT_BASE 662u
#define EXPBO_BATCH 64u

extern void fe25519_add_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_sub_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_sqr_lenn(uint32_t r[8], const uint32_t a[8]);

static volatile uint32_t expbo_kind, expbo_slot;
static uint32_t expbo_seed_a[8], expbo_seed_b[8];

static void expbo_micro(void)
{
    const uint32_t slot = expbo_slot;
    const uint32_t kind = expbo_kind;
    uint32_t a[8], b[8], r[8];
    for (uint32_t i = 0; i < 8u; i++) { a[i] = expbo_seed_a[i]; b[i] = expbo_seed_b[i]; r[i] = 0u; }
    for (uint32_t rep = 0; rep < REP_N; rep++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBO_BATCH; i++) {
            if (kind == 0u)      fe25519_add_lenn(r, a, b);
            else if (kind == 1u) fe25519_sub_lenn(r, a, b);
            else if (kind == 2u) fe25519_mul_lenn(r, a, b);
            else                 fe25519_sqr_lenn(r, a);
        }
        rep_cyc[slot][rep] = dwt_span_end();
    }
    expbj_sink += r[0];
}

static void expbo_run_all(void)
{
    uint32_t i;
    for (i = 0; i < 8u; i++) {
        expbo_seed_a[i] = 0x9e3779b9u * (i + 1u);
        expbo_seed_b[i] = 0x85ebca6bu * (i + 3u);
    }
    expbo_seed_a[7] &= 0x7fffffffu;
    expbo_seed_b[7] &= 0x7fffffffu;
    expaj_stack_prepare();
    for (i = 0; i < 4u; i++) {
        expbo_kind = i; expbo_slot = EXPBO_SLOT_BASE + i;
        run_on_stack(expbo_micro, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBO done\n");
}
