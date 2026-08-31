#include "fiat_x25519.h"

#include <stddef.h>

#if defined(__arm__) && defined(__GNUC__)
#pragma GCC target("general-regs-only")
#endif

#include "fiat/curve25519_32.c.inc"

#if !defined(__arm__)
/* Host-only correctness build; the board links the r11-fixed assembly body. */
void fiat_mul_y11_scalar(uint32_t out[10], const uint32_t a[10],
                         const uint32_t b[10])
{
    fiat_25519_carry_mul(out, a, b);
}
#endif

#define JOBS_MAX 2u

/* expDB: SLOTHY does not model possible aliasing between the three base
 * pointers.  Preserve the generated carry_mul alias contract by copying both
 * inputs only on the aliasing path used by the ladder. */
#define DEFINE_EXPDB_ALIAS_WRAPPER(PHASE)                                      \
void fiat_mul_u4a_p##PHASE(uint32_t out[10], const uint32_t a[10],             \
                           const uint32_t b[10])                                \
{                                                                               \
    uint32_t aa[10], bb[10];                                                     \
    for (uint32_t i = 0; i < 10u; i++) { aa[i] = a[i]; bb[i] = b[i]; }          \
    fiat_mul_u4s_p##PHASE(out, aa, bb);                                          \
}

DEFINE_EXPDB_ALIAS_WRAPPER(0)
DEFINE_EXPDB_ALIAS_WRAPPER(1)
DEFINE_EXPDB_ALIAS_WRAPPER(2)
DEFINE_EXPDB_ALIAS_WRAPPER(3)

typedef struct {
    uint8_t *out;
    uint8_t scalar[32];
    fiat_25519_tight_field_element x1, x2, z2, x3, z3;
    fiat_25519_loose_field_element a, b, c, d, e, sum, diff, scaled;
    fiat_25519_tight_field_element aa, bb, da, cb, square;
    int16_t bit;
    uint8_t swap;
    uint8_t phase;
    uint8_t ladder_done;
    uint8_t output_done;
} fiat_x25519_job;

static fiat_x25519_job jobs[JOBS_MAX]
    __attribute__((aligned(8), section(".dtcm")));
static uint32_t job_count;
static uint32_t job_cursor;
static uint32_t job_failures;
volatile uint32_t g_u_real_steps;
volatile uint32_t g_u_dummy_steps;
static uint32_t dummy_out[10] __attribute__((aligned(8), section(".dtcm")));
static const uint32_t dummy_one[10] = {1};

static void fe_copy(uint32_t out[10], const uint32_t in[10])
{
    for (uint32_t i = 0; i < 10; i++) out[i] = in[i];
}

static void fe_zero(uint32_t out[10])
{
    for (uint32_t i = 0; i < 10; i++) out[i] = 0;
}

static void fe_one(uint32_t out[10])
{
    fe_zero(out);
    out[0] = 1;
}

static void fe_cswap(uint32_t a[10], uint32_t b[10], uint8_t swap)
{
    uint32_t t[10];
    fiat_25519_selectznz(t, swap, a, b);
    fiat_25519_selectznz(b, swap, b, a);
    fe_copy(a, t);
}

static void job_init(fiat_x25519_job *job, uint8_t out[32],
                     const uint8_t scalar[32], const uint8_t point[32])
{
    uint8_t u[32];
    job->out = out;
    for (uint32_t i = 0; i < 32; i++) {
        job->scalar[i] = scalar[i];
        u[i] = point[i];
    }
    job->scalar[0] &= 248u;
    job->scalar[31] &= 127u;
    job->scalar[31] |= 64u;
    u[31] &= 127u;
    fiat_25519_from_bytes(job->x1, u);
    fe_one(job->x2);
    fe_zero(job->z2);
    fe_copy(job->x3, job->x1);
    fe_one(job->z3);
    job->bit = 254;
    job->swap = 0;
    job->phase = 0;
    job->ladder_done = 0;
    job->output_done = 0;
}

static void job_step(fiat_x25519_job *job, fiat_mul_fn mul)
{
    switch (job->phase) {
    case 0: {
        uint8_t bit = (uint8_t) ((job->scalar[(uint16_t) job->bit >> 3]
                                  >> (job->bit & 7)) & 1u);
        job->swap ^= bit;
        fe_cswap(job->x2, job->x3, job->swap);
        fe_cswap(job->z2, job->z3, job->swap);
        job->swap = bit;
        fiat_25519_add(job->a, job->x2, job->z2);
        fiat_25519_carry_square(job->aa, job->a);
        fiat_25519_sub(job->b, job->x2, job->z2);
        fiat_25519_carry_square(job->bb, job->b);
        fiat_25519_sub(job->e, job->aa, job->bb);
        fiat_25519_add(job->c, job->x3, job->z3);
        fiat_25519_sub(job->d, job->x3, job->z3);
        mul(job->da, job->d, job->a);
        job->phase = 1;
        break;
    }
    case 1:
        mul(job->cb, job->c, job->b);
        job->phase = 2;
        break;
    case 2:
        fiat_25519_add(job->sum, job->da, job->cb);
        fiat_25519_carry_square(job->x3, job->sum);
        fiat_25519_sub(job->diff, job->da, job->cb);
        fiat_25519_carry_square(job->square, job->diff);
        mul(job->z3, job->x1, job->square);
        job->phase = 3;
        break;
    case 3:
        mul(job->x2, job->aa, job->bb);
        job->phase = 4;
        break;
    default:
        fiat_25519_carry_scmul_121666(job->square, job->e);
        fiat_25519_add(job->scaled, job->bb, job->square);
        mul(job->z2, job->e, job->scaled);
        job->phase = 0;
        job->bit--;
        if (job->bit < 0) job->ladder_done = 1;
        break;
    }
}

static void fe_invert(uint32_t out[10], const uint32_t z[10])
{
    uint32_t acc[10];
    fe_one(acc);
    for (int bit = 254; bit >= 0; bit--) {
        fiat_25519_carry_square(acc, acc);
        if (bit != 4 && bit != 2)
            fiat_mul_y11_scalar(acc, acc, z);
    }
    fe_copy(out, acc);
}

static void job_finalize(fiat_x25519_job *job)
{
    uint32_t inverse[10], affine[10];
    if (job->output_done) return;
    fe_cswap(job->x2, job->x3, job->swap);
    fe_cswap(job->z2, job->z3, job->swap);
    fe_invert(inverse, job->z2);
    fiat_mul_y11_scalar(affine, job->x2, inverse);
    fiat_25519_to_bytes(job->out, affine);
    job->output_done = 1;
}

void curve25519_scalarmult_fiat(uint8_t out[32], const uint8_t scalar[32],
                               const uint8_t point[32])
{
    fiat_x25519_job job;
    job_init(&job, out, scalar, point);
    while (!job.ladder_done) job_step(&job, fiat_mul_y11_scalar);
    job_finalize(&job);
}

void fiat_x25519_queue_reset(void)
{
    job_count = 0;
    job_cursor = 0;
    job_failures = 0;
}

int fiat_x25519_enqueue(uint8_t out[32], const uint8_t scalar[32],
                        const uint8_t point[32])
{
    if (job_count == JOBS_MAX) {
        job_failures++;
        return -1;
    }
    job_init(&jobs[job_count++], out, scalar, point);
    return 0;
}

void fiat_x25519_step(fiat_mul_fn mul)
{
    if (job_count == 1u) {
        if (!jobs[0].ladder_done) {
            job_step(&jobs[0], mul);
            return;
        }
    } else if (job_count == 2u) {
        uint32_t i = job_cursor;
        if (jobs[i].ladder_done) i ^= 1u;
        if (!jobs[i].ladder_done) {
            job_step(&jobs[i], mul);
            job_cursor = i ^ 1u;
            return;
        }
    }
    /* Keep the remaining b1 fragments functional if all jobs finish early. */
    mul(dummy_out, dummy_one, dummy_one);
}

void fiat_x25519_finish_all(void)
{
    for (uint32_t i = 0; i < job_count; i++) {
        while (!jobs[i].ladder_done)
            job_step(&jobs[i], fiat_mul_y11_scalar);
        job_finalize(&jobs[i]);
    }
}

uint32_t fiat_x25519_queue_pending(void)
{
    uint32_t pending = 0;
    for (uint32_t i = 0; i < job_count; i++) pending += !jobs[i].output_done;
    return pending;
}

uint32_t fiat_x25519_failures(void)
{
    return job_failures;
}
