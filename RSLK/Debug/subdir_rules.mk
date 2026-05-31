################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
ADC.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/ADC.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"ADC.d_raw" -MT"ADC.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

Bump.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/Bump.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Bump.d_raw" -MT"Bump.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

Clock.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/Clock.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Clock.d_raw" -MT"Clock.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

I2C.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/I2C.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"I2C.d_raw" -MT"I2C.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

InputCapture.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/InputCapture.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"InputCapture.d_raw" -MT"InputCapture.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

LaunchPad.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/LaunchPad.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"LaunchPad.d_raw" -MT"LaunchPad.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

Motor.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/Motor.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Motor.d_raw" -MT"Motor.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

PWM1.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/PWM1.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"PWM1.d_raw" -MT"PWM1.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

%.o: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

SSD1306.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/SSD1306.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"SSD1306.d_raw" -MT"SSD1306.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

Timer.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/Timer.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Timer.d_raw" -MT"Timer.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/RSLK/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


