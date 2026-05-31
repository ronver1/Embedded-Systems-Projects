# Embedded Systems Projects

A collection of labs completed for **ECE319H (Honors Embedded Systems)** at UT Austin. All projects run on the **TI MSPM0G3507 LaunchPad** and are written in ARM Assembly, C, and C++, built with **Code Composer Studio (CCS)** using the TI clang toolchain.

Each lab builds progressively on the last — from low-level assembly and GPIO to ADC/DAC, SPI displays, and wireless IR communication.

> **Note:** The final project (Lab 9H — Wizard Blast) lives in its own repository: [ronver1/Wizard-Blast](https://github.com/ronver1/Wizard-Blast)

---
## Academic Integrity Notice
- This repository is shared for educational and portfolio purposes only.
- If you are currently enrolled in ECE 319H or a similar course, please do not copy this code directly.
---

## Labs

### Lab 1 — ARM Assembly: String Search
**Language:** ARM Assembly  
Implemented a function in assembly that searches a linked list of EID strings for a match. Exercises low-level ARM Cortex-M0+ register usage, pointer dereferencing, conditional branches, and AAPCS calling conventions.

**Key concepts:** ARM assembly, pointer arithmetic, string comparison, PUSH/POP, AAPCS

---
## Overview
This repository contains my lab assignments and projects from ECE319H: Embedded Systems (Honors) at The University of Texas at Austin. The course develops strong foundations in:

- ARM Cortex-M0+ assembly and register-level hardware programming
- GPIO, SPI, ADC, DAC, UART, and IR peripheral interfacing
- Finite state machine design and interrupt-driven programming
- Fixed-point arithmetic, timing analysis, and real-time constraints
- C/C++ embedded development with classes, pointers, and memory management

These projects emphasize direct hardware control, low-level debugging, and the systems thinking required for embedded firmware, microcontroller programming, and real-time application development.
---

### Lab 2H — Morse Code Output (Honors)
**Language:** ARM Assembly  
Built a Morse code transmitter in assembly. A switch input triggers transmission of a letter via an LED using dot/dash timing encoded in a lookup table. The Honors variant required handling the full A–Z alphabet and precise timing via busy-wait loops.

**Key concepts:** GPIO input/output, lookup tables in assembly, timing loops, LED control

**Files of note:** `ECE319K_Lab2H.s`, `morse.csv`, `Morse Code` reference image

---

### Lab 3 — Debug Dump (Data & Time Logging)
**Language:** C  
Implemented `Debug_Init` and `Debug_Dump` functions that record timestamped data values into circular buffers (`DataBuffer`, `TimeBuffer`). Used SysTick as a hardware timer to capture bus-cycle-accurate timestamps. Validated via UART output.

**Key concepts:** SysTick timer, circular buffers, UART debugging, hardware timing

---

### Lab 4 — Traffic Light Finite State Machine
**Language:** C  
Designed and implemented a traffic light controller using a **Finite State Machine (FSM)** with pointer-based next-state logic (required for the Honors section). The FSM manages south/west/pedestrian signals across multiple states including warning and hold modes, responding to sensor inputs.

**Key concepts:** FSM design, structs with function pointers, GPIO output, switch debouncing, UART grader

**Files of note:** `ECE319K_Lab4main.c`, `traffic.jpg` (hardware setup reference)

---

### Lab 5 — DAC Music Synthesizer
**Language:** C  
Implemented a **5-bit binary-weighted DAC** using GPIO pins PB0–PB4 to synthesize musical tones. A 4-key keyboard input selects from four frequencies (varying by EID-assigned mode), with waveforms generated via periodic timer interrupts and a sine wave lookup table.

**Key concepts:** DAC output, periodic interrupts, sine wave synthesis, keyboard input, fixed-point math

**Files of note:** `ECE319K_Lab5main.c`, `dac_Guitar.xls`, `dac_flute.xls`, `dac_trumpet.xls` (waveform data)

---

### Lab 6 — SPI LCD Driver (ST7735R)
**Language:** ARM Assembly + C  
Implemented SPI communication routines in assembly (`SPIOutCommand`, `SPIOutData`) to drive an **ST7735R 160×128 LCD**. Functions poll the SPI status register for busy/ready states and toggle the D/C line to distinguish commands from data. Built on top of a C-based LCD initialization framework.

**Key concepts:** SPI protocol, busy-wait polling, assembly-level hardware register access, LCD initialization

**Files of note:** `BusyWait.s`, `Lab6.s`, `Lab6Main.c`, `StringConversion.s`

---

### Lab 7H — Slide Potentiometer & ADC (Honors)
**Language:** C++  
Interfaced a **slide potentiometer** with the 12-bit ADC (PB18, ADC1 Channel 5) and displayed the position on the ST7735R LCD. Implemented a `SlidePot` class with calibration support and a fixed-point output function (`OutFix`) that formats position in cm without floating-point. Benchmarked ADC read time vs. floating-point vs. fixed-point conversion.

**Key concepts:** 12-bit ADC, fixed-point arithmetic, C++ classes, LCD output, performance benchmarking

**Partner:** Arianna Pascual  
**Files of note:** `Lab7HMain.cpp`, `Calibration.xls`, `Lab7Circuit.png`

---

### Lab 8H — IR Wireless Communication (Honors)
**Language:** C++  
Built a two-microcontroller communication system using **IR (infrared) wireless transmission** at 2375 baud with 38 kHz carrier modulation. Implemented `IRxmt` (transmitter on PA8) and `UART2` (receiver on PA22) along with a circular **FIFO queue** class for buffering incoming data. The system transmits slide potentiometer position from one board and displays it on the other's LCD.

**Key concepts:** IR modulation (38 kHz), UART reception via interrupts, FIFO queue (C++ class), multi-board communication, fixed-point data encoding

**Partner:** Arianna Pascual  
**Files of note:** `Lab8HMain.cpp`, `IRxmt.cpp/.h`, `UART2.cpp/.h`, `Lab8Circuit.png`

---

## Shared Library (`inc/`)

A common library used across all labs, derived from UT Austin's MSPM0 ValvanoWare framework:

| Module | Description |
|---|---|
| `Clock.h` | PLL initialization (40/80 MHz) |
| `LaunchPad.h` | GPIO initialization for LEDs and switches |
| `UART.h` | UART0 serial output for debugging/grading |
| `Timer.h` | SysTick and timer peripheral drivers |
| `Dump.h` | Debug data/time logging buffers |
| `ST7735.h` | ST7735R LCD SPI driver |
| `SlidePot.h` | ADC slide potentiometer driver |
| `TExaS.h` | TExaS logic analyzer and oscilloscope interface |
| `FIFO2.h` | Circular FIFO queue (Lab 8H) |

---

## Hardware

All labs use the **TI MSPM0G3507 LaunchPad (LP-MSPM0G3507)**. Additional peripherals vary by lab:

| Lab | Additional Hardware |
|---|---|
| 1 | None |
| 2H | LED + tactile switch |
| 3 | UART terminal (via J25/J26 jumpers) |
| 4 | 3 LEDs (south/west/walk) + 3 switches |
| 5 | 5-bit DAC resistor network, 4-key keyboard, speaker |
| 6 | ST7735R 160×128 LCD |
| 7H | ST7735R LCD + Bourns slide potentiometer (PB18) |
| 8H | ST7735R LCD + slide potentiometer + IR LED (PA8) + IR receiver (PA22) |

---

## Building & Flashing

1. Open **Code Composer Studio (CCS)**
2. Import the desired lab folder as a project
3. Connect the LP-MSPM0G3507 via USB
4. Build (`Ctrl+B`) and flash via the CCS debug interface

The `inc/` folder must be accessible at `../inc/` relative to each lab project.

---

## Course Info

**Course:** ECE319H — Embedded Systems (Honors Section)  
**University:** The University of Texas at Austin  
**Semester:** Spring 2026  
**Instructor:** Dr. Holt  
**Student:** Ronit Verma

Framework and grader code by **Jonathan Valvano** — http://users.ece.utexas.edu/~valvano/

---
## Author
### Ronit Verma

The University of Texas at Austin

Electrical & Computer Engineering Honors + Business Honors

LinkedIn: https://www.linkedin.com/in/ronit-verma-b0a80a383/
---

## License

Base framework: Simplified BSD License © 2026 Jonathan W. Valvano. Student lab implementations © 2026 Ronit Verma.
