/* QEMU mps2-an386 (Cortex-M4) 최소 링커 스크립트
 * 메모리 맵은 pqm4의 MPS2 설정에서 가져옴:
 *   코드용 SRAM: 0x00000000, 4MB (QEMU에서는 쓰기도 가능)
 *   데이터용 SRAM: 0x20000000, 4MB
 */
/* RAM 512K로 축소(2026-08-13): mps3-an547(M55)의 DTCM이 0x20000000에 512KB뿐이라
 * 스택을 그 안에 두기 위함. an386은 4MB지만 512K 부분집합으로 동작 동일 →
 * 링커 스크립트 하나로 an386(M4)·an547(M55) 겸용. */
MEMORY
{
  CODE (rwx) : ORIGIN = 0x00000000, LENGTH = 512K
  RAM  (rw)  : ORIGIN = 0x20000000, LENGTH = 512K
}

ENTRY(Reset_Handler)

SECTIONS
{
  /* 벡터 테이블은 반드시 주소 0에: CPU가 리셋 때 여기서 SP와 PC를 읽는다 */
  .vectors : { KEEP(*(.vectors)) } > CODE

  .text : { *(.text*) } > CODE
  .rodata : { *(.rodata*) } > CODE

  /* QEMU에서는 코드 영역도 SRAM이라 .data를 그냥 여기 둔다 (복사 루틴 불필요) */
  .data : { *(.data*) } > CODE

  .bss (NOLOAD) : {
    . = ALIGN(4);
    __bss_start__ = .;
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    __bss_end__ = .;
  } > RAM

  /* 스택 = RAM 꼭대기에서 아래로 자람 */
  __stack_top = ORIGIN(RAM) + LENGTH(RAM);
}
