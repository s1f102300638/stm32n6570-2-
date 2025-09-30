################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (13.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../Application/UserMain/app_main.c \
../Application/UserMain/libcam.c \
../Application/UserMain/tglib.c 

OBJS += \
./Application/UserMain/app_main.o \
./Application/UserMain/libcam.o \
./Application/UserMain/tglib.o 

C_DEPS += \
./Application/UserMain/app_main.d \
./Application/UserMain/libcam.d \
./Application/UserMain/tglib.d 


# Each subdirectory must supply rules for building sources it contributes
Application/UserMain/%.o Application/UserMain/%.su Application/UserMain/%.cyclo: ../Application/UserMain/%.c Application/UserMain/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m55 -std=gnu11 -g3 -DSTM32N657xx -DUSE_FULL_ASSERT -DUSE_HAL_DRIVER -D_STM32CUBE_DISCOVERY_N657_ -c -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Application/Inc" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Drivers/BSP/STM32N6570-DK" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Drivers/STM32N6xx_HAL_Driver/Inc" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Drivers/CMSIS/Device/STM32N6xx/Include" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Drivers/STM32N6xx_HAL_Driver/Inc/Legacy" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Drivers/CMSIS/Include" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Drivers/BSP/Components/IMX335" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Drivers/BSP/Components/Common" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Drivers/BSP/Components/rk050hr18" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Middlewares/STM32_ISP/evision/inc" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/Middlewares/STM32_ISP/inc" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/mtk3_bsp2" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/mtk3_bsp2/config" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/mtk3_bsp2/include" -I"D:/dev/mtkernel/msp2_samples/LCD_CAM/prj_stm32n6_cam/STM32CubeIDE/FSBL/mtk3_bsp2/mtkernel/kernel/knlinc" -O0 -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -mcmse -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Application-2f-UserMain

clean-Application-2f-UserMain:
	-$(RM) ./Application/UserMain/app_main.cyclo ./Application/UserMain/app_main.d ./Application/UserMain/app_main.o ./Application/UserMain/app_main.su ./Application/UserMain/libcam.cyclo ./Application/UserMain/libcam.d ./Application/UserMain/libcam.o ./Application/UserMain/libcam.su ./Application/UserMain/tglib.cyclo ./Application/UserMain/tglib.d ./Application/UserMain/tglib.o ./Application/UserMain/tglib.su

.PHONY: clean-Application-2f-UserMain

