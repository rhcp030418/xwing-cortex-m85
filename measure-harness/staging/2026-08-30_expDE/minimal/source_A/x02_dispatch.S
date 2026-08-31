/* expCJ: fe25519_sqr 기준형/최종형 동일-ELF 디스패처. */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.extern	apx_real_fe25519_sqr
	.extern	fe25519_sqr_bb

	.type	fe25519_sqr, %function
	.global	fe25519_sqr
fe25519_sqr:
	b	apx_real_fe25519_sqr
	.size	fe25519_sqr, .-fe25519_sqr

	.ltorg
