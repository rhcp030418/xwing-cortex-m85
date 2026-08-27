################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../src/mlkem/cmov_int16.S \
../src/mlkem/fastaddsub.S \
../src/mlkem/fastbasemul.S \
../src/mlkem/fastinvntt.S \
../src/mlkem/fastntt.S \
../src/mlkem/matacc_asm.S \
../src/mlkem/poly_asm.S \
../src/mlkem/reduce.S 

C_SRCS += \
../src/mlkem/cbd.c \
../src/mlkem/indcpa.c \
../src/mlkem/kem.c \
../src/mlkem/matacc.c \
../src/mlkem/ntt.c \
../src/mlkem/poly.c \
../src/mlkem/poly_mve.c \
../src/mlkem/polyvec.c \
../src/mlkem/randombytes_det.c \
../src/mlkem/symmetric-fips202.c \
../src/mlkem/verify.c 

C_DEPS += \
./src/mlkem/cbd.d \
./src/mlkem/indcpa.d \
./src/mlkem/kem.d \
./src/mlkem/matacc.d \
./src/mlkem/ntt.d \
./src/mlkem/poly.d \
./src/mlkem/poly_mve.d \
./src/mlkem/polyvec.d \
./src/mlkem/randombytes_det.d \
./src/mlkem/symmetric-fips202.d \
./src/mlkem/verify.d 

OBJS += \
./src/mlkem/cbd.o \
./src/mlkem/cmov_int16.o \
./src/mlkem/fastaddsub.o \
./src/mlkem/fastbasemul.o \
./src/mlkem/fastinvntt.o \
./src/mlkem/fastntt.o \
./src/mlkem/indcpa.o \
./src/mlkem/kem.o \
./src/mlkem/matacc.o \
./src/mlkem/matacc_asm.o \
./src/mlkem/ntt.o \
./src/mlkem/poly.o \
./src/mlkem/poly_asm.o \
./src/mlkem/poly_mve.o \
./src/mlkem/polyvec.o \
./src/mlkem/randombytes_det.o \
./src/mlkem/reduce.o \
./src/mlkem/symmetric-fips202.o \
./src/mlkem/verify.o 

SREC += \
blinky.srec 

S_UPPER_DEPS += \
./src/mlkem/cmov_int16.d \
./src/mlkem/fastaddsub.d \
./src/mlkem/fastbasemul.d \
./src/mlkem/fastinvntt.d \
./src/mlkem/fastntt.d \
./src/mlkem/matacc_asm.d \
./src/mlkem/poly_asm.d \
./src/mlkem/reduce.d 

MAP += \
blinky.map 


# Each subdirectory must supply rules for building sources it contributes
src/mlkem/%.o: ../src/mlkem/%.c
	$(file > $@.in,-mthumb -mfloat-abi=hard -mcpu=cortex-m85+nopacbti -O2 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -g -D_RENESAS_RA_ -D_RA_CORE=CM85 -D_RA_ORDINAL=1 -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg/bsp" -I"." -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_gen" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg" -I"C:/Users/cnscj/e2_studio/workspace/blinky/src" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/api" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/instances" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/arm/CMSIS_6/CMSIS/Core/Include" -std=c99 -Wno-stringop-overflow -Wno-format-truncation -flax-vector-conversions --param=min-pagesize=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" -x c "$<")
	@echo Building file: $< && arm-none-eabi-gcc @"$@.in"
src/mlkem/%.o: ../src/mlkem/%.S
	$(file > $@.in,-mthumb -mfloat-abi=hard -mcpu=cortex-m85+nopacbti -O2 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -g -x assembler-with-cpp -D_RENESAS_RA_ -D_RA_CORE=CM85 -D_RA_ORDINAL=1 -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg/bsp" -I"." -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_gen" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg" -I"C:/Users/cnscj/e2_studio/workspace/blinky/src" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/api" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/instances" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/arm/CMSIS_6/CMSIS/Core/Include" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<")
	@echo Building file: $< && arm-none-eabi-gcc @"$@.in"

