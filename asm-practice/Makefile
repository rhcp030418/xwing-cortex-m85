# WSL에서:  make run-ex1  /  make run-ex2
PREFIX  = arm-none-eabi-
CFLAGS  = -mcpu=cortex-m4 -mthumb -O2 -g -Wall -ffunction-sections -fdata-sections
LDFLAGS = -T link.ld -nostartfiles --specs=nosys.specs -Wl,--gc-sections
COMMON  = startup.s uart.c
QEMU    = qemu-system-arm -M mps2-an386 -cpu cortex-m4 -nographic -semihosting -kernel

ex1.elf: $(COMMON) ex1_sum.s ex1_main.c link.ld
	$(PREFIX)gcc $(CFLAGS) $(LDFLAGS) $(COMMON) ex1_sum.s ex1_main.c -o $@

ex2.elf: $(COMMON) x25519/x25519-cortex-m4-gcc.s ex2_x25519_main.c link.ld
	$(PREFIX)gcc $(CFLAGS) $(LDFLAGS) $(COMMON) x25519/x25519-cortex-m4-gcc.s ex2_x25519_main.c -o $@

ex3.elf: $(COMMON) keccak/keccakf1600.S keccak/fips202.c ex3_keccak_main.c link.ld
	$(PREFIX)gcc $(CFLAGS) $(LDFLAGS) -I. $(COMMON) keccak/keccakf1600.S keccak/fips202.c ex3_keccak_main.c -o $@

run-ex1: ex1.elf
	$(QEMU) ex1.elf

run-ex2: ex2.elf
	$(QEMU) ex2.elf

run-ex3: ex3.elf
	$(QEMU) ex3.elf

# ---- M85/M55 변형 (2026-08-13, 보드 도착 전 선검증) ----
# m85: 크로스컴파일+링크만 검증 (QEMU에 M85 머신이 없어 실행 불가 — 실행은 EK-RA8M1에서)
# m55: mps3-an547이 같은 Armv8.1-M+MVE라 M85의 기능 프록시. UART 주소가 달라 -DSEMIHOST로 빌드
M85FLAGS = -mcpu=cortex-m85 -mthumb -O2 -g -Wall -ffunction-sections -fdata-sections
M55FLAGS = -mcpu=cortex-m55 -mthumb -O2 -g -Wall -DSEMIHOST -ffunction-sections -fdata-sections
QEMU55   = qemu-system-arm -M mps3-an547 -cpu cortex-m55 -nographic -semihosting -kernel

ex2-m85.elf: $(COMMON) x25519/x25519-cortex-m4-gcc.s ex2_x25519_main.c link.ld
	$(PREFIX)gcc $(M85FLAGS) $(LDFLAGS) $(COMMON) x25519/x25519-cortex-m4-gcc.s ex2_x25519_main.c -o $@

ex3-m85.elf: $(COMMON) keccak/keccakf1600.S keccak/fips202.c ex3_keccak_main.c link.ld
	$(PREFIX)gcc $(M85FLAGS) $(LDFLAGS) -I. $(COMMON) keccak/keccakf1600.S keccak/fips202.c ex3_keccak_main.c -o $@

m85-check: ex2-m85.elf ex3-m85.elf
	@echo "M85 LINK OK (ex2, ex3) -- 실행 검증은 run-ex2-m55/run-ex3-m55 또는 실보드"

ex2-m55.elf: $(COMMON) x25519/x25519-cortex-m4-gcc.s ex2_x25519_main.c link.ld
	$(PREFIX)gcc $(M55FLAGS) $(LDFLAGS) $(COMMON) x25519/x25519-cortex-m4-gcc.s ex2_x25519_main.c -o $@

ex3-m55.elf: $(COMMON) keccak/keccakf1600.S keccak/fips202.c ex3_keccak_main.c link.ld
	$(PREFIX)gcc $(M55FLAGS) $(LDFLAGS) -I. $(COMMON) keccak/keccakf1600.S keccak/fips202.c ex3_keccak_main.c -o $@

run-ex2-m55: ex2-m55.elf
	$(QEMU55) ex2-m55.elf

run-ex3-m55: ex3-m55.elf
	$(QEMU55) ex3-m55.elf

clean:
	rm -f *.elf

.PHONY: run-ex1 run-ex2 run-ex3 m85-check run-ex2-m55 run-ex3-m55 clean
