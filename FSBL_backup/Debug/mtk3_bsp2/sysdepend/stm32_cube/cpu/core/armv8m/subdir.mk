################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/cpu_cntl.c \
../mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/exc_hdr.c \
../mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/interrupt.c \
../mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/sys_start.c 

S_UPPER_SRCS += \
../mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/dispatch.S 

OBJS += \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/cpu_cntl.o \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/dispatch.o \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/exc_hdr.o \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/interrupt.o \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/sys_start.o 

S_UPPER_DEPS += \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/dispatch.d 

C_DEPS += \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/cpu_cntl.d \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/exc_hdr.d \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/interrupt.d \
./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/sys_start.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/%.o mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/%.su mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/%.cyclo: ../mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/%.c mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g3 -DSTM32N657xx -DUSE_FULL_ASSERT -DUSE_HAL_DRIVER -D_STM32CUBE_DISCOVERY_N657_ -c -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Core/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/STM32N6570-DK" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/STM32N6xx_HAL_Driver/Inc/Legacy" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/CMSIS/Include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/IMX335" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Drivers/BSP/Components/rk050hr18" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/Middlewares/STM32_ISP/inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/config" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/%.o: ../mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/%.S mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m55 -g3 -D_STM32CUBE_DISCOVERY_N657_ -c -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/config" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL_backup/mtk3_bsp2/mtkernel/kernel/knlinc" -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-cpu-2f-core-2f-armv8m

clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-cpu-2f-core-2f-armv8m:
	-$(RM) ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/cpu_cntl.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/cpu_cntl.d ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/cpu_cntl.o ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/cpu_cntl.su ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/dispatch.d ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/dispatch.o ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/exc_hdr.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/exc_hdr.d ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/exc_hdr.o ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/exc_hdr.su ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/interrupt.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/interrupt.d ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/interrupt.o ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/interrupt.su ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/sys_start.cyclo ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/sys_start.d ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/sys_start.o ./mtk3_bsp2/sysdepend/stm32_cube/cpu/core/armv8m/sys_start.su

.PHONY: clean-mtk3_bsp2-2f-sysdepend-2f-stm32_cube-2f-cpu-2f-core-2f-armv8m

