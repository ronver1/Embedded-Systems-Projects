################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Each subdirectory must supply rules for building sources it contributes
Clock.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/Clock.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Clock.d_raw" -MT"Clock.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

LaunchPad.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/LaunchPad.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"LaunchPad.d_raw" -MT"LaunchPad.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

TExaS.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/TExaS.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"TExaS.d_raw" -MT"TExaS.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

%.o: ../%.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"$(basename $(<F)).d_raw" -MT"$(@)" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '

Timer.o: C:/Users/ronit/Desktop/School\ Work/Spring\ 26/ECE\ 319H/MSPM0_Valvanoware/inc/Timer.c $(GEN_OPTS) | $(GEN_FILES) $(GEN_MISC_FILES)
	@echo 'Building file: "$<"'
	@echo 'Invoking: Arm Compiler'
	"C:/TI/ccs2040/ccs/tools/compiler/ti-cgt-armllvm_4.0.4.LTS/bin/tiarmclang.exe" -c -march=thumbv6m -mcpu=cortex-m0plus -mfloat-abi=soft -mlittle-endian -mthumb -O0 -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug" -I"C:/TI/mspm0_sdk_2_09_00_01/source/third_party/CMSIS/Core/Include" -I"C:/TI/mspm0_sdk_2_09_00_01/source" -D__MSPM0G3507__ -gdwarf-3 -MMD -MP -MF"Timer.d_raw" -MT"Timer.o" -I"C:/Users/ronit/Desktop/School Work/Spring 26/ECE 319H/MSPM0_Valvanoware/TExaS/Debug/syscfg"  $(GEN_OPTS__FLAG) -o"$@" "$<"
	@echo 'Finished building: "$<"'
	@echo ' '


