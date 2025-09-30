################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../mtk3_bsp2/mtkernel/kernel/sysinit/sysinit.c 

OBJS += \
./mtk3_bsp2/mtkernel/kernel/sysinit/sysinit.o 

C_DEPS += \
./mtk3_bsp2/mtkernel/kernel/sysinit/sysinit.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/mtkernel/kernel/sysinit/%.o mtk3_bsp2/mtkernel/kernel/sysinit/%.su mtk3_bsp2/mtkernel/kernel/sysinit/%.cyclo: ../mtk3_bsp2/mtkernel/kernel/sysinit/%.c mtk3_bsp2/mtkernel/kernel/sysinit/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g1 -DUSE_HAL_DRIVER -DSTM32N657xx -D_STM32CUBE_DISCOVERY_N657_ -c -I../Core/Inc -I../../Secure_nsclib -I../../Drivers/STM32N6xx_HAL_Driver/Inc -I../../Drivers/CMSIS/Device/ST/STM32N6xx/Include -I../../Drivers/STM32N6xx_HAL_Driver/Inc/Legacy -I../../Drivers/CMSIS/Include -I"D:/dev/mtkernel/msp2_samples/mtk3bsp2_stm32n657/Appli/mtk3_bsp2" -I"D:/dev/mtkernel/msp2_samples/mtk3bsp2_stm32n657/Appli/mtk3_bsp2/config" -I"D:/dev/mtkernel/msp2_samples/mtk3bsp2_stm32n657/Appli/mtk3_bsp2/include" -I"D:/dev/mtkernel/msp2_samples/mtk3bsp2_stm32n657/Appli/mtk3_bsp2/mtkernel/kernel/knlinc" -Os -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysinit

clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysinit:
	-$(RM) ./mtk3_bsp2/mtkernel/kernel/sysinit/sysinit.cyclo ./mtk3_bsp2/mtkernel/kernel/sysinit/sysinit.d ./mtk3_bsp2/mtkernel/kernel/sysinit/sysinit.o ./mtk3_bsp2/mtkernel/kernel/sysinit/sysinit.su

.PHONY: clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysinit

