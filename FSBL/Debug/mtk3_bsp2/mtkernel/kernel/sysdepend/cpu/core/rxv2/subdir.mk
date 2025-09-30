################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/cpu_cntl.c \
../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/exc_hdr.c \
../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/interrupt.c \
../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_main.c \
../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/vector_tbl.c 

S_UPPER_SRCS += \
../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/dispatch.S \
../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/int_asm.S \
../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_hdl.S 

OBJS += \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/cpu_cntl.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/dispatch.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/exc_hdr.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/int_asm.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/interrupt.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_hdl.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_main.o \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/vector_tbl.o 

S_UPPER_DEPS += \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/dispatch.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/int_asm.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_hdl.d 

C_DEPS += \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/cpu_cntl.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/exc_hdr.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/interrupt.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_main.d \
./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/vector_tbl.d 


# Each subdirectory must supply rules for building sources it contributes
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/%.o mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/%.su mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/%.cyclo: ../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/%.c mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g3 -DSTM32N657xx -DUSE_FULL_ASSERT -DUSE_HAL_DRIVER -D_STM32CUBE_DISCOVERY_N657_ -DLL_ATON_DUMP_DEBUG_API -DLL_ATON_PLATFORM=LL_ATON_PLAT_STM32N6 -DLL_ATON_OSAL=LL_ATON_OSAL_BARE_METAL -DLL_ATON_RT_MODE=LL_ATON_RT_ASYNC -DLL_ATON_SW_FALLBACK -DLL_ATON_EB_DBG_INFO -DLL_ATON_DBG_BUFFER_INFO_EXCLUDED=1 -DHAL_DCMIPP_MODULE_DISABLED -c -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Core/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Drivers/BSP/STM32N6570-DK" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Drivers/STM32N6xx_HAL_Driver/Inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Drivers/CMSIS/Device/STM32N6xx/Include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Drivers/STM32N6xx_HAL_Driver/Inc/Legacy" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Drivers/CMSIS/Include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Drivers/BSP/Components/IMX335" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Drivers/BSP/Components/Common" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Drivers/BSP/Components/rk050hr18" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Middlewares/STM32_ISP/evision/inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/Middlewares/STM32_ISP/inc" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/mtk3_bsp2" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/mtk3_bsp2/config" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/mtk3_bsp2/include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/mtk3_bsp2/mtkernel/kernel/knlinc" -I../../Drivers/STM32N6xx_HAL_Driver/Inc -I../../Middlewares/ST/AI/Npu/Devices/STM32N6XX -I../../FSBL/X-CUBE-AI/App -I../../Middlewares/ST/AI/Inc -I../../Middlewares/ST/AI/Npu/ll_aton -Os -ffunction-sections -fdata-sections -Wall -Wno-strict-aliasing -u _printf_float -Wno-strict-aliasing -Wno-unused-function -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"
mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/%.o: ../mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/%.S mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m55 -g3 -D_STM32CUBE_DISCOVERY_N657_ -c -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/mtk3_bsp2" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/mtk3_bsp2/config" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/mtk3_bsp2/include" -I"C:/Users/iniad/STM32CubeIDE/workspace_2/mtk3bsp2_stm32n657/FSBL/mtk3_bsp2/mtkernel/kernel/knlinc" -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-cpu-2f-core-2f-rxv2

clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-cpu-2f-core-2f-rxv2:
	-$(RM) ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/cpu_cntl.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/cpu_cntl.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/cpu_cntl.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/cpu_cntl.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/dispatch.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/dispatch.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/exc_hdr.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/exc_hdr.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/exc_hdr.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/exc_hdr.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/int_asm.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/int_asm.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/interrupt.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/interrupt.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/interrupt.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/interrupt.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_hdl.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_hdl.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_main.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_main.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_main.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/reset_main.su ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/vector_tbl.cyclo ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/vector_tbl.d ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/vector_tbl.o ./mtk3_bsp2/mtkernel/kernel/sysdepend/cpu/core/rxv2/vector_tbl.su

.PHONY: clean-mtk3_bsp2-2f-mtkernel-2f-kernel-2f-sysdepend-2f-cpu-2f-core-2f-rxv2

