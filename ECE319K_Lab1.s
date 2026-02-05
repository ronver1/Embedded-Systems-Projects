// ****************** ECE319K_Lab1.s ***************
// Your solution to Lab 1 in assembly code
// Author: Ronit Verma
// Last Modified: 1/23/26
// Spring 2026
        .data
        .align 2
// Declare global variables here if needed
// with the .space assembly directive

        .text
        .thumb
        .align 2
        .global EID
EID:    .string "*******" // Set Student EID here

        .global Phase
        .align 2
Phase:  .long 10 
// These are related to the grader in MSPM0_Valvanoware
// Phase= 0 will display your objective and some of the test cases, 
// Phase= 1 to 5 will run one test case (the ones you have been given)
// Phase= 6 to 7 will run one test case (the inputs you have not been given)
// Phase=10 will run the grader (all cases 1 to 7)
        .global Lab1
// Input: R0 points to the list
// Return: R0 as specified in Lab 1 assignment and terminal window
// According to AAPCS, you must save/restore R4-R7
// If your function calls another function, you must save/restore LR

Lab1: 
        PUSH {R1-R7,LR}
                                // R0 is the pointer to the start of the array
        LDR R1, [R0]            // R1 now holds the EID in the array
        MOVS R5, #0

EID_notfound:
        CMP R1, #0              // Check if struct is terminated
        BEQ No_EID
        B EID_one

EID_one:
        LDRB R2, [R1, R5]       // First letter in R2 and R5 has the offset

Check_End:       
        CMP R2, #0              // Check is string is terminated
        BEQ Next_EID
        B Try_*                // Read code in chronological order
        
Try_*:
        CMP R2, *             // Compares to first letter of EID
        BEQ Try_*
        B Next_EID
Try_*: 
        ADDS R5, #1             // Next character
        LDRB R2, [R1, R5]
        CMP R2, *             // Compares to second letter of EID
        BEQ *
        B Next_EID
Try_*:
        ADDS R5, #1             // Next character
        LDRB R2, [R1, R5]
        CMP R2, *               // Compares to third letter of EID
        BEQ Try_*
        B Next_EID
Try_*:
        ADDS R5, #1             // Next character
        LDRB R2, [R1, R5]
        CMP R2, *               // Compares to fourth letter of EID
        BEQ Try_*
        B Next_EID
Try_*: 
        ADDS R5, #1             // Next character
        LDRB R2, [R1, R5]
        CMP R2, *              // Compares to fifth letter of EID
        BEQ Try_*
        B Next_EID
Try_*: 
        ADDS R5, #1             // Next character
        LDRB R2, [R1, R5]
        CMP R2, *              // Compares to sixth letter of EID
        BEQ Try_*
        B Next_EID
Try_*: 
        ADDS R5, #1             // Next character
        LDRB R2, [R1, R5]
        CMP R2, *              // Compares to seventh letter of EID
        BEQ EID_Found
        B Next_EID
Next_EID:
        ADDS R0, #8             // Increments the EID pointer to next EID
        MOVS R1, #0             // Resets the letter pointer
        MOVS R5, #0             // Resets the letter offset
        LDR R1, [R0]            // Check if the EID is 0 to prevent Hardstop
        CMP R1, #0
        BEQ No_EID
        B EID_one

No_EID:
        LDR R0, =-1             // Returns -1 in R0
        B END
EID_Found: 
        ADDS R0, #4             // Increments to the EID's score
        LDR R0, [R0]            // Returns score in R0
        B END
END:
      POP  {R1-R7,PC}   // return
       


        .align 2
        .global myClass
myClass: .long pAB123  // pointer to EID
         .long 95      // Score
         .long pXYZ1   // pointer to EID
         .long 96      // Score
         .long pAB5549 // pointer to EID
         .long 94      // Score
         .long 0       // null pointer means end of list
         .long 0
pAB123:  .string "AB123"
pXYZ1:   .string "XYZ1"
pAB5549: .string "AB5549"
        .end

