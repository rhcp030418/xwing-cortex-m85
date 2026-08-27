################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../src/stitch_micro.S 

C_SRCS += \
../src/fiat_x25519.c \
../src/hal_entry.c \
../src/hal_warmstart.c \
../src/harness.c \
../src/itcm_pad.c \
../src/keccakx4.c 

C_DEPS += \
./src/fiat_x25519.d \
./src/hal_entry.d \
./src/hal_warmstart.d \
./src/harness.d \
./src/itcm_pad.d \
./src/keccakx4.d 

OBJS += \
./src/fiat_x25519.o \
./src/hal_entry.o \
./src/hal_warmstart.o \
./src/harness.o \
./src/itcm_pad.o \
./src/keccakx4.o \
./src/stitch_micro.o 

SREC += \
blinky.srec 

S_UPPER_DEPS += \
./src/stitch_micro.d 

MAP += \
blinky.map 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	$(file > $@.in,-mthumb -mfloat-abi=hard -mcpu=cortex-m85+nopacbti -O2 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -g -D_RENESAS_RA_ -D_RA_CORE=CM85 -D_RA_ORDINAL=1 -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg/bsp" -I"." -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_gen" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg" -I"C:/Users/cnscj/e2_studio/workspace/blinky/src" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/api" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/instances" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/arm/CMSIS_6/CMSIS/Core/Include" -std=c99 -Wno-stringop-overflow -Wno-format-truncation -flax-vector-conversions --param=min-pagesize=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" -x c "$<")
	@echo Building file: $< && arm-none-eabi-gcc @"$@.in"
src/%.o: ../src/%.S
	$(file > $@.in,-mthumb -mfloat-abi=hard -mcpu=cortex-m85+nopacbti -O2 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -g -x assembler-with-cpp -D_RENESAS_RA_ -D_RA_CORE=CM85 -D_RA_ORDINAL=1 -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg/bsp" -I"." -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_gen" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg" -I"C:/Users/cnscj/e2_studio/workspace/blinky/src" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/api" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/instances" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/arm/CMSIS_6/CMSIS/Core/Include" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<")
	@echo Building file: $< && arm-none-eabi-gcc @"$@.in"

