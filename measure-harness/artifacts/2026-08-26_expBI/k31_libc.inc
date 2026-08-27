/* K31 — libc 복사·영점화 루틴 교체 (expBH).
 * expBG §2 실측: newlib-nano memcpy 12.61 cyc/byte, memset 3.07 cyc/byte.
 * 링크 시 -Wl,--wrap=memcpy -Wl,--wrap=memset 로 가로챈다.
 *   k31_mode 0 = __real_* (newlib-nano),  1 = 워드 루프
 *   k31_count_on 1 이면 호출 수·바이트 수를 센다 (분모 측정용 probe)
 * attribute 가 없으면 -ftree-loop-distribute-patterns 가 루프를 memcpy 로 되돌려
 * 무한 재귀가 된다. */

extern void *__real_memcpy(void *dst, const void *src, size_t n);
extern void *__real_memset(void *dst, int c, size_t n);

volatile uint32_t k31_mode = 0u;
volatile uint32_t k31_count_on = 0u;
volatile uint32_t k31_memcpy_calls = 0u, k31_memcpy_bytes = 0u;
volatile uint32_t k31_memset_calls = 0u, k31_memset_bytes = 0u;

__attribute__((optimize("no-tree-loop-distribute-patterns")))
void *__wrap_memcpy(void *dst, const void *src, size_t n)
{
    /* 채택(expBI): 모드 분기·카운터 제거, 무조건 워드. */
    unsigned char *d = (unsigned char *) dst;
    const unsigned char *s = (const unsigned char *) src;
    if (((((uintptr_t) d) | ((uintptr_t) s)) & 3u) == 0u) {
        uint32_t *dw = (uint32_t *) (void *) d;
        const uint32_t *sw = (const uint32_t *) (const void *) s;
        size_t w = n >> 2;
        while (w--) *dw++ = *sw++;
        d = (unsigned char *) dw; s = (const unsigned char *) sw; n &= 3u;
    }
    while (n--) *d++ = *s++;
    return dst;
}

__attribute__((optimize("no-tree-loop-distribute-patterns")))
void *__wrap_memset(void *dst, int c, size_t n)
{
    /* 채택(expBI): 모드 분기·카운터 제거, 무조건 워드. */
    unsigned char *d = (unsigned char *) dst;
    const uint32_t v = 0x01010101u * (uint32_t) (unsigned char) c;
    if ((((uintptr_t) d) & 3u) == 0u) {
        uint32_t *dw = (uint32_t *) (void *) d;
        size_t w = n >> 2;
        while (w--) *dw++ = v;
        d = (unsigned char *) dw; n &= 3u;
    }
    while (n--) *d++ = (unsigned char) c;
    return dst;
}
