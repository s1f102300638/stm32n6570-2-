################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/BSP/Components/IMX335/imx335.c \
../Drivers/BSP/Components/IMX335/imx335_reg.c 

OBJS += \
./Drivers/BSP/Components/IMX335/imx335.o \
./Drivers/BSP/Components/IMX335/imx335_reg.o 

C_DEPS += \
./Drivers/BSP/Components/IMX335/imx335.d \
./Drivers/BSP/Components/IMX335/imx335_reg.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/BSP/Components/IMX335/%.o Drivers/BSP/Components/IMX335/%.su Drivers/BSP/Components/IMX335/%.cyclo: ../Drivers/BSP/Components/IMX335/%.c Drivers/BSP/Components/IMX335/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g3 -DSTM32N657xx -DUSE_FULL_ASSERT -DUSE_HAL_DRIVER -D_STM32CUBE_DISCOVERY_N657_ -c -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Core/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/STM32N6570-DK" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc/Legacy" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/CMSIS/Include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/IMX335" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/rk050hr18" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Middlewares/STM32_ISP/inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/config" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-BSP-2f-Components-2f-IMX335

clean-Drivers-2f-BSP-2f-Components-2f-IMX335:
	-$(RM) ./Drivers/BSP/Components/IMX335/imx335.cyclo ./Drivers/BSP/Components/IMX335/imx335.d ./Drivers/BSP/Components/IMX335/imx335.o ./Drivers/BSP/Components/IMX335/imx335.su ./Drivers/BSP/Components/IMX335/imx335_reg.cyclo ./Drivers/BSP/Components/IMX335/imx335_reg.d ./Drivers/BSP/Components/IMX335/imx335_reg.o ./Drivers/BSP/Components/IMX335/imx335_reg.su

.PHONY: clean-Drivers-2f-BSP-2f-Components-2f-IMX335

