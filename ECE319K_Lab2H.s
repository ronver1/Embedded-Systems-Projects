// ****************** ECE319K_Lab2H.s ***************
// Your solution to Lab 2 in assembly code
// Author: Ronit Verma
// Last Modified: 2/1/2026
// ECE319H Spring 2026 (ECE319K students do Lab2)

    .include "../inc/msp.s"

        .data
        .align 2
// Declare global variables here if needed
// with the .space assembly directive

        .text
        .thumb
        .align 2
        .global EID
EID:    .string "RV24923" // replace ZZZ123 with your EID here
        .align 2
  .equ dot,100
  .equ dash,(3*dot)
  .equ shortgap,(2*dot)  // because it will send an interelement too
  .equ interelement,dot
  Morse:
  .long  dot,  dash,    0,    0, 0 // A
  .long  dash,  dot,  dot,  dot, 0 // B
  .long  dash,  dot, dash,  dot, 0 // C
  .long  dash,  dot,  dot,    0, 0 // D
  .long  dot,     0,    0,    0, 0 // E
  .long  dot,   dot, dash,  dot, 0 // F
  .long  dash, dash,  dot,    0, 0 // G
  .long  dot,   dot,  dot,  dot, 0 // H
  .long  dot,   dot,    0,    0, 0 // I
  .long  dot,  dash, dash, dash, 0 // J
  .long  dash,  dot, dash,    0, 0 // K
  .long  dot,  dash,  dot,  dot, 0 // L
  .long  dash, dash,    0,    0, 0 // M
  .long  dash,  dot,    0,    0, 0 // N
  .long  dash, dash, dash,    0, 0 // O
  .long  dot,  dash, dash,  dot, 0 // P
  .long  dash, dash,  dot, dash, 0 // Q
  .long  dot,  dash,  dot,    0, 0 // R
  .long  dot,   dot,  dot,    0, 0 // S
  .long  dash,    0,    0,    0, 0 // T
  .long  dot,   dot, dash,    0, 0 // U
  .long  dot,   dot,  dot, dash, 0 // V
  .long  dot,  dash, dash,    0, 0 // W
  .long  dash,  dot,  dot, dash, 0 // X
  .long  dash,  dot, dash, dash, 0 // Y
  .long  dash, dash,  dot,  dot, 0 // Z

  .align 2
  .global Lab2Grader
  .global Lab2
  .global Debug_Init // Lab3 programs
  .global Dump       // Lab3 programs

// Switch input: PB2 PB1 or PB0, depending on EID
// LED output:   PB18 PB17 or PB16, depending on EID
// logic analyzer pins PB18 PB17 PB16 PB2 PB1 PB0
// analog scope pin PB20
Lab2:
// Initially the main program will
//   set bus clock at 80 MHz,
//   reset and power enable both Port A and Port B
// Lab2Grader will
//   configure interrupts  on TIMERG0 for grader or TIMERG7 for TExaS
//   initialize ADC0 PB20 for scope,
//   initialize UART0 for grader or TExaS
    BL   Lab2Init   // you initialize input pin and output pin
Loop:   
    MOVS R0, #10  // 0 for info, 1 debug with logic analyzer, 2 debug with scope, 10 for grade   
    BL   Lab2Grader      
    BL   Button_on_then_off     // Use polling to check when the button is on and then off
    BL   Letter_To_Morse
    B Loop




// make switch an input, LED an output
// PortB is already reset and powered
// Set IOMUX for your input and output
// Set GPIOB_DOE31_0 for your output (be friendly)
Lab2Init:
// ***do not reset/power Port A or Port B, already done****
    push {R0-R2, R4-R7, LR}

    LDR R0, =GPIOB_DOE31_0
    LDR R1, [R0]
    LDR R2, =0x00040000
    ORRS R1, R2
    STR R1, [R0]            // Sets PB18 (LED) as an Output and PB2 as Input

    MOVS R0, #0
    MOVS R1, #0
    MOVS R2, #0

    LDR R0, =IOMUXPB2
    LDR R1, =0x000040081     
    STR R1, [R0]

    MOVS R0, #0
    MOVS R1, #0

    LDR R0, =IOMUXPB18
    LDR R1, =0x00000081     
    STR R1, [R0]

    pop {R0-R2, R4-R7, PC}

Button_on_then_off:
    push {R0-R7, LR}

    First_Read:
        LDR R0, =GPIOB_DIN31_0
        LDR R1, [R0]
        LDR R2, =0x00000004
        ANDS R1, R2
        MOVS R2, #0
        CMP R1, #0
        BNE Second_Read
        B First_Read
    Second_Read:
        LDR R0, =GPIOB_DIN31_0
        LDR R1, [R0]
        LDR R2, =0x00000004
        ANDS R1, R2
        CMP R1, #0
        BEQ Poll_Complete
        B Second_Read
    Poll_Complete:
    pop {R0-R7, PC}

Letter_To_Morse:
    push {R0, R1, R4-R7, LR}

    SUBS R0, 0x41        // Subtract Ascii Letter to find the Index
    LDR R1, =Morse
    MOVS R3, #20
    MULS R0, R3

Check_Zero:
    LDR R2, [R1, R0]    // Calculates the proper offset for the letter
    CMP R2, #0
    BEQ End_of_Morse
    B Check_Dot
Check_Dot:
    CMP R2, #100
    BEQ Output_Dot
    B Check_Dash
Check_Dash:
    LDR R6, =300
    CMP R2, R6
    BEQ Output_Dash
    B Increment
Increment:
    ADDS R0, #4         // Increments R2 to the next dot, dash, or 0
    B Check_Zero

Output_Dot:
    LDR R4, =GPIOB_DOUT31_0
    LDR R5, =0x00040000
    STR R5, [R4]
    BL Delay_Dot
    MOVS R5, #0
    STR R5, [R4]
    BL Delay_Dot
    B Increment

Output_Dash:
    LDR R4, =GPIOB_DOUT31_0
    LDR R5, =0x00040000
    STR R5, [R4]
    BL Delay_Dash
    MOVS R5, #0
    STR R5, [R4]
    BL Delay_Dot
    B Increment

Delay_Dot:
    push {R0, R4-R7, LR}
    LDR R0, =1600000        // 100ms Delay
 Subtract_Dot:   
    SUBS R0, #1
    CMP R0, #0
    BEQ End_Delay_Dot
    B Subtract_Dot
End_Delay_Dot:
    pop {R0, R4-R7, PC}

Delay_Dash:
    push {R0, R4-R7, LR}
    LDR R0, =4800000        // 300ms Delay
 Subtract_Dash:   
    SUBS R0, #1
    CMP R0, #0
    BEQ End_Delay_Dash
    B Subtract_Dash
End_Delay_Dash:
    pop {R0, R4-R7, PC}

End_of_Morse:
    pop {R0, R1, R4-R7, PC}


End:
    .end