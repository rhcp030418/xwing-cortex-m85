################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../src/gen/fiat_u_stitch_m85.S \
../src/gen/keccakx4_round_m85.S 

S_SRCS += \
../src/gen/bfull_board.s \
../src/gen/bmid_board.s \
../src/gen/expc_board.s \
../src/gen/expd_board.s \
../src/gen/expe_board.s \
../src/gen/expf_board.s \
../src/gen/expj_board.s \
../src/gen/expjsolo_board.s \
../src/gen/expl_board.s \
../src/gen/expn_board.s \
../src/gen/expp_board.s \
../src/gen/expq_board.s \
../src/gen/expt_board.s \
../src/gen/expu_board.s \
../src/gen/expw_intt_kyber_1_23_45_67_opt_m55.s \
../src/gen/expw_intt_kyber_1_23_45_67_opt_m85.s \
../src/gen/expw_ntt_kyber_12_345_67_opt_size_m85.s \
../src/gen/expw_ntt_kyber_12_345_67_opt_speed_m85.s \
../src/gen/expw_ntt_kyber_1_23_45_67_no_trans_opt_m85.s \
../src/gen/expw_ntt_kyber_1_23_45_67_no_trans_vld4_opt_m85.s \
../src/gen/expw_ntt_kyber_1_23_45_67_opt_m85.s \
../src/gen/expy_intt_kyber_1_23_45_67_opt_m85_plantard.s \
../src/gen/fiat_yield2.s \
../src/gen/fiat_yield3.s \
../src/gen/mul256_budget.s \
../src/gen/mul256_flat.s \
../src/gen/mul256_flat6.s \
../src/gen/mul256_full.s \
../src/gen/mvekeccak_board.s \
../src/gen/slothy_expa.s \
../src/gen/stitched.s 

S_DEPS += \
./src/gen/bfull_board.d \
./src/gen/bmid_board.d \
./src/gen/expc_board.d \
./src/gen/expd_board.d \
./src/gen/expe_board.d \
./src/gen/expf_board.d \
./src/gen/expj_board.d \
./src/gen/expjsolo_board.d \
./src/gen/expl_board.d \
./src/gen/expn_board.d \
./src/gen/expp_board.d \
./src/gen/expq_board.d \
./src/gen/expt_board.d \
./src/gen/expu_board.d \
./src/gen/expw_intt_kyber_1_23_45_67_opt_m55.d \
./src/gen/expw_intt_kyber_1_23_45_67_opt_m85.d \
./src/gen/expw_ntt_kyber_12_345_67_opt_size_m85.d \
./src/gen/expw_ntt_kyber_12_345_67_opt_speed_m85.d \
./src/gen/expw_ntt_kyber_1_23_45_67_no_trans_opt_m85.d \
./src/gen/expw_ntt_kyber_1_23_45_67_no_trans_vld4_opt_m85.d \
./src/gen/expw_ntt_kyber_1_23_45_67_opt_m85.d \
./src/gen/expy_intt_kyber_1_23_45_67_opt_m85_plantard.d \
./src/gen/fiat_yield2.d \
./src/gen/fiat_yield3.d \
./src/gen/mul256_budget.d \
./src/gen/mul256_flat.d \
./src/gen/mul256_flat6.d \
./src/gen/mul256_full.d \
./src/gen/mvekeccak_board.d \
./src/gen/slothy_expa.d \
./src/gen/stitched.d 

OBJS += \
./src/gen/bfull_board.o \
./src/gen/bmid_board.o \
./src/gen/expc_board.o \
./src/gen/expd_board.o \
./src/gen/expe_board.o \
./src/gen/expf_board.o \
./src/gen/expj_board.o \
./src/gen/expjsolo_board.o \
./src/gen/expl_board.o \
./src/gen/expn_board.o \
./src/gen/expp_board.o \
./src/gen/expq_board.o \
./src/gen/expt_board.o \
./src/gen/expu_board.o \
./src/gen/expw_intt_kyber_1_23_45_67_opt_m55.o \
./src/gen/expw_intt_kyber_1_23_45_67_opt_m85.o \
./src/gen/expw_ntt_kyber_12_345_67_opt_size_m85.o \
./src/gen/expw_ntt_kyber_12_345_67_opt_speed_m85.o \
./src/gen/expw_ntt_kyber_1_23_45_67_no_trans_opt_m85.o \
./src/gen/expw_ntt_kyber_1_23_45_67_no_trans_vld4_opt_m85.o \
./src/gen/expw_ntt_kyber_1_23_45_67_opt_m85.o \
./src/gen/expy_intt_kyber_1_23_45_67_opt_m85_plantard.o \
./src/gen/fiat_u_stitch_m85.o \
./src/gen/fiat_yield2.o \
./src/gen/fiat_yield3.o \
./src/gen/keccakx4_round_m85.o \
./src/gen/mul256_budget.o \
./src/gen/mul256_flat.o \
./src/gen/mul256_flat6.o \
./src/gen/mul256_full.o \
./src/gen/mvekeccak_board.o \
./src/gen/slothy_expa.o \
./src/gen/stitched.o 

SREC += \
blinky.srec 

S_UPPER_DEPS += \
./src/gen/fiat_u_stitch_m85.d \
./src/gen/keccakx4_round_m85.d 

MAP += \
blinky.map 


# Each subdirectory must supply rules for building sources it contributes
src/gen/%.o: ../src/gen/%.s
	$(file > $@.in,-mthumb -mfloat-abi=hard -mcpu=cortex-m85+nopacbti -O2 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -g -x assembler-with-cpp -D_RENESAS_RA_ -D_RA_CORE=CM85 -D_RA_ORDINAL=1 -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg/bsp" -I"." -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_gen" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg" -I"C:/Users/cnscj/e2_studio/workspace/blinky/src" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/api" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/instances" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/arm/CMSIS_6/CMSIS/Core/Include" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<")
	@echo Building file: $< && arm-none-eabi-gcc @"$@.in"
src/gen/%.o: ../src/gen/%.S
	$(file > $@.in,-mthumb -mfloat-abi=hard -mcpu=cortex-m85+nopacbti -O2 -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-strict-aliasing -Wunused -Wuninitialized -Wall -Wextra -Wmissing-declarations -Wconversion -Wpointer-arith -Wshadow -Wlogical-op -Waggregate-return -Wfloat-equal -g -x assembler-with-cpp -D_RENESAS_RA_ -D_RA_CORE=CM85 -D_RA_ORDINAL=1 -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg/bsp" -I"." -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_gen" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra_cfg/fsp_cfg" -I"C:/Users/cnscj/e2_studio/workspace/blinky/src" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/api" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/fsp/inc/instances" -I"C:/Users/cnscj/e2_studio/workspace/blinky/ra/arm/CMSIS_6/CMSIS/Core/Include" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<")
	@echo Building file: $< && arm-none-eabi-gcc @"$@.in"

