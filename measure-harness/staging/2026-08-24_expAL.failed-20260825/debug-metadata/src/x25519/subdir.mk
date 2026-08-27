################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../src/x25519/x25519-cortex-m4-gcc.s 

S_DEPS += \
./src/x25519/x25519-cortex-m4-gcc.d 

OBJS += \
./src/x25519/x25519-cortex-m4-gcc.o 

SREC += \
blinky.srec 

MAP += \
blinky.map 


# Each subdirectory must supply rules for building sources it contributes
src/x25519/%.o: ../src/x25519/%.s
	$(file > $@.in,-mthumb -mfloat-abi=hard -mcpu=cortex-m85+nopacbti -O2 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -g -x assembler-with-cpp -D_RENESAS_RA_ -D_RA_CORE=CM85 -D_RA_ORDINAL=1 -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg/bsp" -I"." -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_gen" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg" -I"C:/Users/cnscj/e2_studio/workspace/blinky/src" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/api" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/instances" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/arm/CMSIS_6/CMSIS/Core/Include" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<")
	@echo Building file: $< && arm-none-eabi-gcc @"$@.in"

