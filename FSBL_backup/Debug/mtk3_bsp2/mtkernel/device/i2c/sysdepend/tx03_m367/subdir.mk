################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/i2c_m367.c 

OBJS += \
./mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/i2c_m367.o 

C_DEPS += \
./mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/i2c_m367.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/%.o mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/%.su mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/%.cyclo: ../mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/%.c mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g3 -DSTM32N657xx -DUSE_FULL_ASSERT -DUSE_HAL_DRIVER -D_STM32CUBE_DISCOVERY_N657_ -c -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Core/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/STM32N6570-DK" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc/Legacy" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/CMSIS/Include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/IMX335" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/rk050hr18" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Middlewares/STM32_ISP/inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/config" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-mtkernel-2f-device-2f-i2c-2f-sysdepend-2f-tx03_m367

clean-mtk3_bsp2-2f-mtkernel-2f-device-2f-i2c-2f-sysdepend-2f-tx03_m367:
	-$(RM) ./mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/i2c_m367.cyclo ./mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/i2c_m367.d ./mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/i2c_m367.o ./mtk3_bsp2/mtkernel/device/i2c/sysdepend/tx03_m367/i2c_m367.su

.PHONY: clean-mtk3_bsp2-2f-mtkernel-2f-device-2f-i2c-2f-sysdepend-2f-tx03_m367

