################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_cortex.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dcmipp.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma_ex.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_exti.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_gpio.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c_ex.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_icache.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ltdc.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr_ex.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ramcfg.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc_ex.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rif.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart.c \
../Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart_ex.c 

OBJS += \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_cortex.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dcmipp.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma_ex.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_exti.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_gpio.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c_ex.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_icache.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ltdc.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr_ex.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ramcfg.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc_ex.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rif.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart.o \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart_ex.o 

C_DEPS += \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_cortex.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dcmipp.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma_ex.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_exti.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_gpio.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c_ex.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_icache.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ltdc.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr_ex.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ramcfg.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc_ex.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rif.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart.d \
./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart_ex.d 


# Each subdirectory must supply rules for building sources it contributes
Drivers/STM32N6xx_HAL_Driver/%.o Drivers/STM32N6xx_HAL_Driver/%.su Drivers/STM32N6xx_HAL_Driver/%.cyclo: ../Drivers/STM32N6xx_HAL_Driver/%.c Drivers/STM32N6xx_HAL_Driver/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g3 -DSTM32N657xx -DUSE_FULL_ASSERT -DUSE_HAL_DRIVER -D_STM32CUBE_DISCOVERY_N657_ -c -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Core/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/STM32N6570-DK" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc/Legacy" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/CMSIS/Include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/IMX335" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/rk050hr18" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Middlewares/STM32_ISP/inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/config" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Drivers-2f-STM32N6xx_HAL_Driver

clean-Drivers-2f-STM32N6xx_HAL_Driver:
	-$(RM) ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_cortex.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_cortex.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_cortex.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_cortex.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dcmipp.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dcmipp.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dcmipp.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dcmipp.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma_ex.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma_ex.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma_ex.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_dma_ex.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_exti.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_exti.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_exti.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_exti.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_gpio.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_gpio.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_gpio.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_gpio.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c_ex.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c_ex.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c_ex.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_i2c_ex.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_icache.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_icache.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_icache.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_icache.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ltdc.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ltdc.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ltdc.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ltdc.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr_ex.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr_ex.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr_ex.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_pwr_ex.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ramcfg.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ramcfg.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ramcfg.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_ramcfg.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc_ex.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc_ex.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc_ex.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rcc_ex.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rif.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rif.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rif.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_rif.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart.su ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart_ex.cyclo ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart_ex.d ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart_ex.o ./Drivers/STM32N6xx_HAL_Driver/stm32n6xx_hal_uart_ex.su

.PHONY: clean-Drivers-2f-STM32N6xx_HAL_Driver

