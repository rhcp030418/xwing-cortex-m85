/* 최소 스타트업: 벡터 테이블 + 리셋 핸들러
 * Cortex-M은 리셋 시 주소 0에서 [초기 SP, 리셋 핸들러 주소]를 읽는다.
 */
    .syntax unified
    .cpu cortex-m4
    .thumb

    .section .vectors, "a"
    .word   __stack_top        /* 0x00: 초기 스택 포인터 */
    .word   Reset_Handler      /* 0x04: 리셋 */
    .word   Default_Handler    /* 0x08: NMI */
    .word   Default_Handler    /* 0x0C: HardFault */
    .word   Default_Handler    /* MemManage */
    .word   Default_Handler    /* BusFault */
    .word   Default_Handler    /* UsageFault */
    .word   0, 0, 0, 0         /* 예약 */
    .word   Default_Handler    /* SVCall */
    .word   Default_Handler    /* DebugMon */
    .word   0                  /* 예약 */
    .word   Default_Handler    /* PendSV */
    .word   Default_Handler    /* SysTick */

    .text
    .thumb_func
    .global Reset_Handler
Reset_Handler:
    /* .bss(초기값 없는 전역변수 영역)를 0으로 채운다 — C가 기대하는 상태 */
    ldr   r0, =__bss_start__
    ldr   r1, =__bss_end__
    movs  r2, #0
0:  cmp   r0, r1
    bcs   1f
    str   r2, [r0], #4
    b     0b
1:  bl    main
hang:
    b     hang                 /* main이 리턴하면 여기서 정지 */

    .thumb_func
Default_Handler:
    b     Default_Handler
