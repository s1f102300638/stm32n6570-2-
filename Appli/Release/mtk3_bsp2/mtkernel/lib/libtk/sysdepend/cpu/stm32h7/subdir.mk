################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/int_stm32h7.c \
../mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/ptimer_stm32h7.c 

OBJS += \
./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/int_stm32h7.o \
./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/ptimer_stm32h7.o 

C_DEPS += \
./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/int_stm32h7.d \
./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/ptimer_stm32h7.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/%.o mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/%.su mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/%.cyclo: ../mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/%.c mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g1 -DUSE_HAL_DRIVER -DSTM32N657xx -D_STM32CUBE_DISCOVERY_N657_ -c -I../Core/Inc -I../../Secure_nsclib -I../../Drivers/STM32N6xx_HAL_Driver/Inc -I../../Drivers/CMSIS/Device/ST/STM32N6xx/Include -I../../Drivers/STM32N6xx_HAL_Driver/Inc/Legacy -I../../Drivers/CMSIS/Include -I"D:/dev/mtkernel/msp2_samples/mtk3bsp2_stm32n657/Appli/mtk3_bsp2" -I"D:/dev/mtkernel/msp2_samples/mtk3bsp2_stm32n657/Appli/mtk3_bsp2/config" -I"D:/dev/mtkernel/msp2_samples/mtk3bsp2_stm32n657/Appli/mtk3_bsp2/include" -I"D:/dev/mtkernel/msp2_samples/mtk3bsp2_stm32n657/Appli/mtk3_bsp2/mtkernel/kernel/knlinc" -Os -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-mtkernel-2f-lib-2f-libtk-2f-sysdepend-2f-cpu-2f-stm32h7

clean-mtk3_bsp2-2f-mtkernel-2f-lib-2f-libtk-2f-sysdepend-2f-cpu-2f-stm32h7:
	-$(RM) ./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/int_stm32h7.cyclo ./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/int_stm32h7.d ./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/int_stm32h7.o ./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/int_stm32h7.su ./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/ptimer_stm32h7.cyclo ./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/ptimer_stm32h7.d ./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/ptimer_stm32h7.o ./mtk3_bsp2/mtkernel/lib/libtk/sysdepend/cpu/stm32h7/ptimer_stm32h7.su

.PHONY: clean-mtk3_bsp2-2f-mtkernel-2f-lib-2f-libtk-2f-sysdepend-2f-cpu-2f-stm32h7

