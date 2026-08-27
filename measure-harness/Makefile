# 측정 하네스 — asm-practice의 startup/uart/link.ld와 스트림 asm을 재사용
# WSL에서: make m85     (링크 검증 — QEMU에 M85 머신이 없어 실행은 보드에서)
#          make run-m55 (mps3-an547 구조 검증 — 카운터는 0으로 읽힘)
PREFIX = arm-none-eabi-
AP     = ../asm-practice
SRCS   = $(AP)/startup.s $(AP)/uart.c main.c \
         $(AP)/keccak/keccakf1600.S $(AP)/x25519/x25519-cortex-m4-gcc.s
INC    = -I. -Icmsis -I$(AP)
LDFLAGS = -T $(AP)/link.ld -nostartfiles --specs=nosys.specs -Wl,--gc-sections
BASE   = -mthumb -O2 -g -Wall -ffunction-sections -fdata-sections

harness-m85.elf: $(SRCS) m85_device.h main.c
	$(PREFIX)gcc -mcpu=cortex-m85 $(BASE) $(INC) $(LDFLAGS) $(SRCS) -o $@

# M55 빌드도 core_cm85.h를 그대로 쓴다: DWT·PMU 주소는 v8.1-M 공통이라 유효
harness-m55.elf: $(SRCS) m85_device.h main.c
	$(PREFIX)gcc -mcpu=cortex-m55 $(BASE) -DSEMIHOST $(INC) $(LDFLAGS) $(SRCS) -o $@

m85: harness-m85.elf
	@echo "M85 LINK OK -- 실행·실수치는 EK-RA8M1에서"

run-m55: harness-m55.elf
	qemu-system-arm -M mps3-an547 -cpu cortex-m55 -nographic -semihosting -kernel harness-m55.elf

clean:
	rm -f *.elf

.PHONY: m85 run-m55 clean
