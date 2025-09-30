################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f4.c \
../mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f7.c \
../mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32g4.c \
../mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32h7.c \
../mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32l4.c \
../mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32n6.c 

OBJS += \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f4.o \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f7.o \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32g4.o \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32h7.o \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32l4.o \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32n6.o 

C_DEPS += \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f4.d \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f7.d \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32g4.d \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32h7.d \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32l4.d \
./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32n6.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/%.o mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/%.su mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/%.cyclo: ../mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/%.c mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g3 -DSTM32N657xx -DUSE_FULL_ASSERT -DUSE_HAL_DRIVER -D_STM32CUBE_DISCOVERY_N657_ -c -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Core/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/STM32N6570-DK" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc/Legacy" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/CMSIS/Include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/IMX335" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/rk050hr18" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Middlewares/STM32_ISP/inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/config" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-device-2f-hal_adc-2f-sysdepend

clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-device-2f-hal_adc-2f-sysdepend:
	-$(RM) ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f4.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f4.d ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f4.o ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f4.su ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f7.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f7.d ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f7.o ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32f7.su ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32g4.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32g4.d ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32g4.o ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32g4.su ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32h7.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32h7.d ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32h7.o ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32h7.su ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32l4.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32l4.d ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32l4.o ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32l4.su ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32n6.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32n6.d ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32n6.o ./mtk3_bsp2/sysdepend/stm32_cube/device/hal_adc/sysdepend/hal_adc_stm32n6.su

.PHONY: clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-device-2f-hal_adc-2f-sysdepend

