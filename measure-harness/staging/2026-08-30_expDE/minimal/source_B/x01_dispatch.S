/* expCJ: fe25519_mul 기준형/최종형 동일-ELF 디스패처. */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.extern	apx_real_fe25519_mul
	.extern	fe25519_mul_sched

	.type	fe25519_mul, %function
	.global	fe25519_mul
fe25519_mul:
	b	fe25519_mul_sched
	.size	fe25519_mul, .-fe25519_mul

	.ltorg
