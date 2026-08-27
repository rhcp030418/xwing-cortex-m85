# expAM1 후보 B1 기능검증 (QEMU mps3-an547 / Cortex-M55, MVE)
# 사이클 값은 이 경로에서 얻지 않는다. 기능 전용.
PREFIX = arm-none-eabi-
AP     = ../../asm-practice
SRCS   = $(AP)/startup.s $(AP)/uart.c qemu_main.c expAM_mul_test.c fe25519_mul_mve.S
INC    = -I. -I$(AP)
LDFLAGS = -T $(AP)/link.ld -nostartfiles --specs=nosys.specs -Wl,--gc-sections
BASE   = -mthumb -O2 -g -Wall -Wextra -ffunction-sections -fdata-sections -DSEMIHOST -DAM_PLAIN_TEXT

expAM-m55.elf: $(SRCS)
	$(PREFIX)gcc -mcpu=cortex-m55 $(BASE) $(INC) $(LDFLAGS) $(SRCS) -o $@

run: expAM-m55.elf
	qemu-system-arm -M mps3-an547 -cpu cortex-m55 -nographic -semihosting -kernel $<

# 보드 배치(ITCM) 그대로 어셈블만 검증
m85-asm: fe25519_mul_mve.S
	$(PREFIX)gcc -c -mcpu=cortex-m85 -mthumb -mfloat-abi=hard -mfpu=fpv5-d16 $< -o fe25519_mul_mve-m85.o
	@echo "M85 ITCM 배치 어셈블 OK"

clean:
	rm -f *.elf *.o

.PHONY: run m85-asm clean
