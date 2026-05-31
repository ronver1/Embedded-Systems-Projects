// BusyWait.s
// BusyWait.s
// Student names: Ronit Verma
// Last modification date: 3/7/26

// Note: these functions do not actually output to SPI or Port A. 
// They are called by the grader to see if the functions would work

// As part of Lab 6, students need to implement these two functions

      .global   SPIOutCommand
      .global   SPIOutData
      .text
      .align 2

// ***********SPIOutCommand*****************
// This is a helper function that sends an 8-bit command to the LCD.
// Inputs: R0 = 32-bit command (number)
//         R1 = 32-bit SPI1->STAT, SPI status register address
//         R2 = 32-bit SPI1->TXDATA, SPI tx data register address
//         R3 = 32-bit GPIOA->DOUTCLR31_0, PA13 is D/C
// Outputs: none
// Assumes: SPI and GPIO have already been initialized and enabled
// Note: must be AAPCS compliant
// Note: using the clear register to clear will make it friendly
// --UUU-- Code to write a command to the LCD
//1) Read the SPI status register (R1 has address of SPI1->STAT) and check bit 4,
//2) If bit 4 is high, loop back to step 1 (wait for BUSY bit to be low)
//3) Clear D/C (GPIO PA13) to zero, be friendly (R3 has address of GPIOA->DOUTCLR31_0)
//    Hint: simply write 0x2000 to GPIOA->DOUTCLR31_0
//4) Write the command to the SPI data register (R2 has address of SPI1->TXDATA)
//5) Read the SPI status register (R1 has address of SPI1->STAT) and check bit 4,
//6) If bit 4 is high, loop back to step 5 (wait for BUSY bit to be low)

SPIOutCommand:
        PUSH {R4-R7, LR}
        
Step1:  MOVS R4, 0x10
        LDR R5, [R1]
        ANDS R4, R5
        LSRS R4, R4, #4
        CMP R4, #1
        BHS Step1               // Check SPI1->STAT Register Contents and see if LCD is busy

        LDR R4, =0x2000
        STR R4, [R3]            // Clear Bit 13 in GPIOA->DOUT
        STR R0, [R2]            // Write command to D/C

Step5:  MOVS R4, 0x10
        LDR R5, [R1]
        ANDS R4, R5
        LSRS R4, R4, #4
        CMP R4, #1
        BHS Step5               // Check SPI1->STAT Register Contents and see if LCD is busy
        
        POP {R4-R7, PC} 



// ***********SPIOutData*****************
// This is a helper function that sends an 8-bit data to the LCD.
// Inputs: R0 = 32-bit data (number)
//         R1 = 32-bit SPI1->STAT, SPI status register address
//         R2 = 32-bit SPI1->TXDATA, SPI data register address
//         R3 = 32-bit GPIOA->DOUTSET31_0, PA13 is D/C
// Outputs: none
// Assumes: SPI and GPIO have already been initialized and enabled
// Note: must be AAPCS compliant
// Note: using the set register to clear will make it friendly

// --UUU-- Code to write data to the LCD
//1) Read the SPI status register (R1 has address of SPI1->STAT) and check bit 1,
//2) If bit 1 is low, loop back to step 1 (wait for TNF bit to be high)
//3) Set D/C (GPIO PA13) to one, be friendly (R3 has address of GPIOA->DOUTSET31_0)
//    Hint: simply write 0x2000 to GPIOA->DOUTSET31_0
//4) Write the data to the SPI data register (R2 has address of SPI1->TXDATA)
SPIOutData:    
        PUSH {R4-R7, LR}

Check:  LDR R4, [R1]
        LDR R5, =0x02
        ANDS R5, R4
        CMP R5, #0
        BEQ Check

        LDR R4, =0x2000
        STR R4, [R3]

        STR R0, [R2]

        POP {R4-R7, PC}

// ****************************************************

    .end



// StringConversions.s
// StringConversion.s
// Student names: change this to your names or look very silly
// Last modification date: change this to the last modification date or look very silly
// Runs on any Cortex M0
// ECE319K lab 6 number to string conversion
//
// You write udivby10 and Dec2String
     .data
     .align 2
// no globals allowed for Lab 6
    .global OutChar    // virtual output device
    .global OutDec     // your Lab 6 function
    .global Test_udivby10

    .text
    .align 2
// **test of udivby10**
// since udivby10 is not AAPCS compliant, we must test it in assembly
Test_udivby10:
    PUSH {LR}

    MOVS R0,#123
    BL   udivby10
// put a breakpoint here
// R0 should equal 12 (0x0C)
// R1 should equal 3

    LDR R0,=12345
    BL   udivby10
// put a breakpoint here
// R0 should equal 1234 (0x4D2)
// R1 should equal 5

    MOVS R0,#0
    BL   udivby10
// put a breakpoint here
// R0 should equal 0
// R1 should equal 0
    POP {PC}

// ****************************************************
// divisor=10
// Inputs: R0 is 16-bit dividend
// quotient*10 + remainder = dividend
// Output: R0 is 16-bit quotient=dividend/10
//         R1 is 16-bit remainder=dividend%10 (modulus)
// not AAPCS compliant because it returns two values
udivby10:
   PUSH {R4-R7, LR}
   LDR R4, =0x1999   // R4 approx. = 1/10, 16 bits
   MULS R4, R4, R0   // 32-bit fixed-point -> 16 bits on either side of dp
   LSRS R4, R4, #16  // shift right to get quotient - either true q or q-1
   MOVS R5, #10
   MULS R5, R4, R5
   SUBS R1, R0, R5   // subtract quotient from dividend for remainder
   MOVS R0, R4
   CMP R1, #10
   BLT doneUDiv10
   ADDS R0, R0, #1  // correction if the R4 approximation ended up changing the true answer
   SUBS R1, R1, #10
doneUDiv10:
   POP  {R4-R7, PC}
//-----------------------OutDec-----------------------
// Convert a 16-bit number into unsigned decimal format
// Call the function OutChar to output each character
// You will call OutChar 1 to 5 times
// OutChar does not do actual output, OutChar does virtual output used by the grader
// Input: R0 (call by value) 16-bit unsigned number
// Output: none
// Invariables: This function must not permanently modify registers R4 to R11
OutDec2:
   PUSH {LR}
// write this

   POP  {PC}
// * * * * * * * * End of OutDec * * * * * * * *

// ECE319H recursive version
// Call the function OutChar to output each character
// You will call OutChar 1 to 5 times
// Input: R0 (call by value) 16-bit unsigned number
// Output: none
// Invariables: This function must not permanently modify registers R4 to R11
/* Stack frame drawing
32 bit quotient qnt
32 bit remainder rmd
initial push - LR
*/
.equ qnt, 0
.equ rmd, 4
OutDec:
   PUSH {LR}
   BL udivby10
   PUSH {R0, R1}   
   CMP R0, #0     // base: quotient == 0
   BEQ baseCase
   BL OutDec     // recursive call
baseCase:
   LDR R0, [SP, #rmd]   // use stack frame pointer
   ADDS R0, #0x30    // ascii offset
   BL OutChar
   ADD SP, SP, #8
   POP  {PC}
