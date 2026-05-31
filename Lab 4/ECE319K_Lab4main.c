/* ECE319K_Lab4main.c
 * Traffic light FSM
 * ECE319H students must use pointers for next state
 * ECE319K students can use indices or pointers for next state
  */

  // Ronit Verma
  // ECE 319H: Dr. Holt
  // Last modified 2/23/2026

#include <ti/devices/msp/msp.h>
#include "../inc/LaunchPad.h"
#include "../inc/Clock.h"
#include "../inc/UART.h"
#include "../inc/Timer.h"
#include "../inc/Dump.h"  // student's Lab 3
#include <stdio.h>
#include <string.h>
// put your EID in the next line
const char EID1[] = "RV24923"; //  ;replace abc123 with your EID

// Struct forward declaration
typedef struct state {
  uint8_t id;
  uint8_t southOutput; 
  uint8_t westOutput; 
  uint8_t walkOutput; 
  uint16_t delayTime;
  const struct state *Next[8];
} state;

// declare states
state driveSouth;
state slowdownSouth;
state driveWest;
state slowdownWest;
state walk;
state warningwalk11;
state warningwalk12;
state warningwalk21;
state warningwalk22;
state warningwalk31;
state warningwalk32;
state warningwalk40;
state hold;
state holdafterSouth;
state holdafterWest;
state holdafterWalk;
const state* curr;


// Hint implement Traffic_Out before creating the struct, make struct match your Traffic_Out

// initialize all 6 LED outputs and 3 switch inputs
// assumes LaunchPad_Init resets and powers A and B
void Traffic_Init(void){ // assumes LaunchPad_Init resets and powers A and B
 // Initializing GPIO Pins

 // PINCM Initializaion
 IOMUX->SECCFG.PINCM[PB0INDEX] = 0x81;
 IOMUX->SECCFG.PINCM[PB1INDEX] = 0x81;
 IOMUX->SECCFG.PINCM[PB2INDEX] = 0x81;
 IOMUX->SECCFG.PINCM[PB6INDEX] = 0x81;
 IOMUX->SECCFG.PINCM[PB7INDEX] = 0x81;
 IOMUX->SECCFG.PINCM[PB8INDEX] = 0x81;
 IOMUX->SECCFG.PINCM[PB22INDEX] = 0x81;
 IOMUX->SECCFG.PINCM[PB26INDEX] = 0x81;
 IOMUX->SECCFG.PINCM[PB27INDEX] = 0x81;

 IOMUX->SECCFG.PINCM[PB15INDEX] = 0x40081;
 IOMUX->SECCFG.PINCM[PB16INDEX] = 0x40081;
 IOMUX->SECCFG.PINCM[PB17INDEX] = 0x40081;

 // DOE Initialization
 GPIOB->DOE31_0 |= 0x0C4001C7; 

 // State Initialization
 
 //driveSouth
 driveSouth.id = 0x00;
 driveSouth.southOutput = 0x01;
 driveSouth.westOutput = 0x04;
 driveSouth.walkOutput = 0x01;
 driveSouth.delayTime = 200;
 driveSouth.Next[0] = &driveSouth;
 driveSouth.Next[1] = &slowdownSouth;
 driveSouth.Next[2] = &driveSouth;
 driveSouth.Next[3] = &slowdownSouth;
 driveSouth.Next[4] = &slowdownSouth;
 driveSouth.Next[5] = &slowdownSouth;
 driveSouth.Next[6] = &slowdownSouth;
 driveSouth.Next[7] = &slowdownSouth;

 //slowdownSouth
 slowdownSouth.id = 0x01;
 slowdownSouth.southOutput = 0x02;
 slowdownSouth.westOutput = 0x04;
 slowdownSouth.walkOutput = 0x01;
 slowdownSouth.delayTime = 200;
 slowdownSouth.Next[0] = &holdafterSouth;
 slowdownSouth.Next[1] = &holdafterSouth;
 slowdownSouth.Next[2] = &holdafterSouth;
 slowdownSouth.Next[3] = &holdafterSouth;
 slowdownSouth.Next[4] = &holdafterSouth;
 slowdownSouth.Next[5] = &holdafterSouth;
 slowdownSouth.Next[6] = &holdafterSouth;
 slowdownSouth.Next[7] = &holdafterSouth;

 //driveWest
 driveWest.id = 0x02;
 driveWest.southOutput = 0x04;
 driveWest.westOutput = 0x01;
 driveWest.walkOutput = 0x01;
 driveWest.delayTime = 200;
 driveWest.Next[0] = &driveWest;
 driveWest.Next[1] = &slowdownWest;
 driveWest.Next[2] = &slowdownWest;
 driveWest.Next[3] = &slowdownWest;
 driveWest.Next[4] = &driveWest;
 driveWest.Next[5] = &slowdownWest;
 driveWest.Next[6] = &slowdownWest;
 driveWest.Next[7] = &slowdownWest;

 //slowdownWest
 slowdownWest.id = 0x03;
 slowdownWest.southOutput = 0x04;
 slowdownWest.westOutput = 0x02;
 slowdownWest.walkOutput = 0x01;
 slowdownWest.delayTime = 200;
 slowdownWest.Next[0] = &holdafterWest;
 slowdownWest.Next[1] = &holdafterWest;
 slowdownWest.Next[2] = &holdafterWest;
 slowdownWest.Next[3] = &holdafterWest;
 slowdownWest.Next[4] = &holdafterWest;
 slowdownWest.Next[5] = &holdafterWest;
 slowdownWest.Next[6] = &holdafterWest;
 slowdownWest.Next[7] = &holdafterWest;

 //walk
 walk.id = 0x04;
 walk.southOutput = 0x04;
 walk.westOutput = 0x04;
 walk.walkOutput = 0x07;
 walk.delayTime = 200;
 walk.Next[0] = &walk;
 walk.Next[1] = &walk;
 walk.Next[2] = &warningwalk11;
 walk.Next[3] = &warningwalk11;
 walk.Next[4] = &warningwalk11;
 walk.Next[5] = &warningwalk11;
 walk.Next[6] = &warningwalk11;
 walk.Next[7] = &warningwalk11;

 //warningwalk11
 warningwalk11.id = 0x05;
 warningwalk11.southOutput = 0x04;
 warningwalk11.westOutput = 0x04;
 warningwalk11.walkOutput = 0x01;
 warningwalk11.delayTime = 25;
 warningwalk11.Next[0] = &warningwalk12;
 warningwalk11.Next[1] = &warningwalk12;
 warningwalk11.Next[2] = &warningwalk12;
 warningwalk11.Next[3] = &warningwalk12;
 warningwalk11.Next[4] = &warningwalk12;
 warningwalk11.Next[5] = &warningwalk12;
 warningwalk11.Next[6] = &warningwalk12;
 warningwalk11.Next[7] = &warningwalk12;

 //warningwalk12
 warningwalk12.id = 0x06;
 warningwalk12.southOutput = 0x04;
 warningwalk12.westOutput = 0x04;
 warningwalk12.walkOutput = 0x00;
 warningwalk12.delayTime = 25;
 warningwalk12.Next[0] = &warningwalk21;
 warningwalk12.Next[1] = &warningwalk21;
 warningwalk12.Next[2] = &warningwalk21;
 warningwalk12.Next[3] = &warningwalk21;
 warningwalk12.Next[4] = &warningwalk21;
 warningwalk12.Next[5] = &warningwalk21;
 warningwalk12.Next[6] = &warningwalk21;
 warningwalk12.Next[7] = &warningwalk21;

 //warningwalk21
 warningwalk21.id = 0x07;
 warningwalk21.southOutput = 0x04;
 warningwalk21.westOutput = 0x04;
 warningwalk21.walkOutput = 0x01;
 warningwalk21.delayTime = 25;
 warningwalk21.Next[0] = &warningwalk22;
 warningwalk21.Next[1] = &warningwalk22;
 warningwalk21.Next[2] = &warningwalk22;
 warningwalk21.Next[3] = &warningwalk22;
 warningwalk21.Next[4] = &warningwalk22;
 warningwalk21.Next[5] = &warningwalk22;
 warningwalk21.Next[6] = &warningwalk22;
 warningwalk21.Next[7] = &warningwalk22;

 //warningwalk22
 warningwalk22.id = 0x08;
 warningwalk22.southOutput = 0x04;
 warningwalk22.westOutput = 0x04;
 warningwalk22.walkOutput = 0x00;
 warningwalk22.delayTime = 25;
 warningwalk22.Next[0] = &warningwalk31;
 warningwalk22.Next[1] = &warningwalk31;
 warningwalk22.Next[2] = &warningwalk31;
 warningwalk22.Next[3] = &warningwalk31;
 warningwalk22.Next[4] = &warningwalk31;
 warningwalk22.Next[5] = &warningwalk31;
 warningwalk22.Next[6] = &warningwalk31;
 warningwalk22.Next[7] = &warningwalk31;

 //warningwalk31
 warningwalk31.id = 0x09;
 warningwalk31.southOutput = 0x04;
 warningwalk31.westOutput = 0x04;
 warningwalk31.walkOutput = 0x01;
 warningwalk31.delayTime = 25;
 warningwalk31.Next[0] = &warningwalk32;
 warningwalk31.Next[1] = &warningwalk32;
 warningwalk31.Next[2] = &warningwalk32;
 warningwalk31.Next[3] = &warningwalk32;
 warningwalk31.Next[4] = &warningwalk32;
 warningwalk31.Next[5] = &warningwalk32;
 warningwalk31.Next[6] = &warningwalk32;
 warningwalk31.Next[7] = &warningwalk32;

 //warningwalk32
 warningwalk32.id = 0x0A;
 warningwalk32.southOutput = 0x04;
 warningwalk32.westOutput = 0x04;
 warningwalk32.walkOutput = 0x00;
 warningwalk32.delayTime = 25;
 warningwalk32.Next[0] = &warningwalk40;
 warningwalk32.Next[1] = &warningwalk40;
 warningwalk32.Next[2] = &warningwalk40;
 warningwalk32.Next[3] = &warningwalk40;
 warningwalk32.Next[4] = &warningwalk40;
 warningwalk32.Next[5] = &warningwalk40;
 warningwalk32.Next[6] = &warningwalk40;
 warningwalk32.Next[7] = &warningwalk40;

 //warningwalk40
 warningwalk40.id = 0x0B;
 warningwalk40.southOutput = 0x04;
 warningwalk40.westOutput = 0x04;
 warningwalk40.walkOutput = 0x01;
 warningwalk40.delayTime = 25;
 warningwalk40.Next[0] = &holdafterWalk;
 warningwalk40.Next[1] = &holdafterWalk;
 warningwalk40.Next[2] = &holdafterWalk;
 warningwalk40.Next[3] = &holdafterWalk;
 warningwalk40.Next[4] = &holdafterWalk;
 warningwalk40.Next[5] = &holdafterWalk;
 warningwalk40.Next[6] = &holdafterWalk;
 warningwalk40.Next[7] = &holdafterWalk;

 //hold
 hold.id = 0x0C;
 hold.southOutput = 0x04;
 hold.westOutput = 0x04;
 hold.walkOutput = 0x01;
 hold.delayTime = 100;
 hold.Next[0] = &driveSouth;
 hold.Next[1] = &walk;
 hold.Next[2] = &driveSouth;
 hold.Next[3] = &driveSouth;
 hold.Next[4] = &driveWest;
 hold.Next[5] = &driveWest;
 hold.Next[6] = &driveWest;
 hold.Next[7] = &driveSouth;

 //holdafterSouth
 holdafterSouth.id = 0x0D;
 holdafterSouth.southOutput = 0x04;
 holdafterSouth.westOutput = 0x04;
 holdafterSouth.walkOutput = 0x01;
 holdafterSouth.delayTime = 50;
 holdafterSouth.Next[0] = &hold;
 holdafterSouth.Next[1] = &hold;
 holdafterSouth.Next[2] = &driveSouth;
 holdafterSouth.Next[3] = &walk;
 holdafterSouth.Next[4] = &hold;
 holdafterSouth.Next[5] = &hold;
 holdafterSouth.Next[6] = &hold;
 holdafterSouth.Next[7] = &walk;

 //holdafterWest
 holdafterWest.id = 0x0E;
 holdafterWest.southOutput = 0x04;
 holdafterWest.westOutput = 0x04;
 holdafterWest.walkOutput = 0x01;
 holdafterWest.delayTime = 50;
 holdafterWest.Next[0] = &hold;
 holdafterWest.Next[1] = &hold;
 holdafterWest.Next[2] = &hold;
 holdafterWest.Next[3] = &hold;
 holdafterWest.Next[4] = &hold;
 holdafterWest.Next[5] = &walk;
 holdafterWest.Next[6] = &driveSouth;
 holdafterWest.Next[7] = &hold;

 //holdafterWalk
 holdafterWalk.id = 0x0F;
 holdafterWalk.southOutput = 0x04;
 holdafterWalk.westOutput = 0x04;
 holdafterWalk.walkOutput = 0x01;
 holdafterWalk.delayTime = 50;
 holdafterWalk.Next[0] = &hold;
 holdafterWalk.Next[1] = &hold;
 holdafterWalk.Next[2] = &hold;
 holdafterWalk.Next[3] = &hold;
 holdafterWalk.Next[4] = &hold;
 holdafterWalk.Next[5] = &hold;
 holdafterWalk.Next[6] = &hold;
 holdafterWalk.Next[7] = &driveWest;

}


/* Activate LEDs
* Inputs: west is 3-bit value to three east/west LEDs
*         south is 3-bit value to three north/south LEDs
*         walk is 3-bit value to 3-color positive logic LED on PB22,PB26,PB27
* Output: none
* - west =1 sets west green
* - west =2 sets west yellow
* - west =4 sets west red
* - south =1 sets south green
* - south =2 sets south yellow
* - south =4 sets south red
* - walk=0 to turn off LED
* - walk bit 22 sets blue color
* - walk bit 26 sets red color
* - walk bit 27 sets green color
* Feel free to change this. But, if you change the way it works, change the test programs too
* Be friendly*/
void Traffic_Out(uint32_t west, uint32_t south, uint32_t walk){
  
  uint32_t west_temp;
  uint32_t walk_temp1;
  uint32_t walk_temp2;
  uint32_t mask;

  west_temp = west<<6;
  walk_temp1 = ((walk & 0x04)<<20);
  walk_temp2 = ((walk & 0x03)<<26);
  walk_temp1 = walk_temp1 | walk_temp2;

  mask = west_temp | walk_temp1 | south;

  GPIOB->DOUT31_0 &= 0xF3BFFE38;

  GPIOB->DOUT31_0 |=  mask;
}

// For Traffic_Out Debug_Dump 
  static inline uint32_t PackOut(uint8_t west, uint8_t south, uint8_t walk){
  return ((uint32_t)west<<16) | ((uint32_t)south<<8) | (uint32_t)walk;
}

/* Read sensors
 * Input: none
 * Output: sensor values
 * - bit 2 is west car sensor
 * - bit 1 is south car sensor
 * - bit 0 is walk people sensor
 * Feel free to change this. But, if you change the way it works, change the test programs too
 * I changed the bit pattern here - I need to change the test program as well
 */
uint32_t Traffic_In(void){

  uint32_t walk_temp;
  uint32_t south_temp;
  uint32_t west_temp;
  uint32_t input;

  walk_temp = (GPIOB->DIN31_0 & (1<<17));
  south_temp = (GPIOB->DIN31_0 & (1<<16));
  west_temp = (GPIOB->DIN31_0 & (1<<15));

  walk_temp = walk_temp>>17;
  south_temp = south_temp>>15;
  west_temp = west_temp>>13;

  input = walk_temp | south_temp | west_temp;

  return input;
}

// FSM debugging
static inline uint32_t PackFSM(const state *s){
  return ((uint32_t)s->id<<24) |
         ((uint32_t)s->westOutput<<16) |
         ((uint32_t)s->southOutput<<8) |
         ((uint32_t)s->walkOutput);
}


// use main1 to determine Lab4 assignment
void Lab4Grader(int mode);
void Grader_Init(void);
int main1(void){ // main1
  Clock_Init80MHz(0);
  LaunchPad_Init();
  Lab4Grader(0); // print assignment, no grading
  while(1){
  }
}
// use main2 to debug LED outputs
// at this point in ECE319K you need to be writing your own test functions
// modify this program so it tests your Traffic_Out  function
int main2(void){ // main2
  Clock_Init80MHz(0);
  LaunchPad_Init();
  Grader_Init(); // execute this line before your code
  LaunchPad_LED1off();
  Traffic_Init(); // your Lab 4 initialization
  Debug_Init();
  SysTick_Init();
  if((GPIOB->DOE31_0 & 0x20)==0){
    UART_OutString("access to GPIOB->DOE31_0 should be friendly.\n\r");
  }
  UART_Init();
  UART_OutString("Lab 4, Spring 2026, Step 1. Debug LEDs\n\r");
  UART_OutString("EID1= "); UART_OutString((char*)EID1); UART_OutString("\n\r");
  while(1){
      while(1){
        // SOUTH traffic light test (Green, Yellow, Red) 
    Traffic_Out(0x00, 0x01, 0x00);   // South Green
    Debug_Dump(PackOut(0x00,0x01,0x00));
    SysTick_Wait10ms(100);           // 1s

    Traffic_Out(0x00, 0x02, 0x00);   // South Yellow
    Debug_Dump(PackOut(0x00,0x02,0x00));
    SysTick_Wait10ms(100);

    Traffic_Out(0x00, 0x04, 0x00);   // South Red
    Debug_Dump(PackOut(0x00,0x04,0x00));
    SysTick_Wait10ms(100);

    // WEST traffic light test (Green, Yellow, Red) 
    Traffic_Out(0x01, 0x00, 0x00);   // West Green
    Debug_Dump(PackOut(0x01,0x00,0x00));
    SysTick_Wait10ms(100);

    Traffic_Out(0x02, 0x00, 0x00);   // West Yellow
    Debug_Dump(PackOut(0x02,0x00,0x00));
    SysTick_Wait10ms(100);

    Traffic_Out(0x04, 0x00, 0x00);   // West Red
    Debug_Dump(PackOut(0x04,0x00,0x00));
    SysTick_Wait10ms(100);

    //  WALK light test (Walk, Don't Walk)
    Traffic_Out(0x00, 0x00, 0x01);   // Don't Walk 
    Debug_Dump(PackOut(0x00,0x00,0x01));
    SysTick_Wait10ms(100);

    Traffic_Out(0x00, 0x00, 0x07);   // Walk
    Debug_Dump(PackOut(0x00,0x00,0x07));
    SysTick_Wait10ms(100);

    // All off pause
    Traffic_Out(0x00, 0x00, 0x00);
    Debug_Dump(PackOut(0x00,0x00,0x00));
    SysTick_Wait10ms(100);
  }
  }
}
// use main3 to debug the three input switches
// at this point in ECE319K you need to be writing your own test functions
// modify this program so it tests your Traffic_In  function
int main3(void){ // main3
  uint32_t last=0,now;
  Clock_Init80MHz(0);
  LaunchPad_Init();
  Traffic_Init(); // your Lab 4 initialization
  Debug_Init();   // Lab 3 debugging
  UART_Init();
  __enable_irq(); // UART uses interrupts
  UART_OutString("Lab 4, Spring 2026, Step 2. Debug switches\n\r");
  UART_OutString("EID1= "); UART_OutString((char*)EID1); UART_OutString("\n\r");
  UART_OutString("Press buttons, watch values change.\n\r");
  UART_OutString("Bits: [2]=West [1]=South [0]=Walk\n\r");
  while(1){
    now = Traffic_In() & 0x07; // Force input to be 0x07
    if(now != last){ // change
      UART_OutString("Switch= 0x"); UART_OutUHex(now); UART_OutString("\n\r");
      Debug_Dump(now);
    }
    Debug_Dump2(now);
    last = now;
    Clock_Delay(800000); // 10ms, to debounce switch
  }
}
// use main4 to debug using your dump
// proving your machine cycles through all states
int main4(void){// main4
uint32_t input;
  Clock_Init80MHz(0);
  LaunchPad_Init();
  LaunchPad_LED1off();
  Traffic_Init(); // your Lab 4 initialization
 // set initial state
  Debug_Init();   // Lab 3 debugging
  UART_Init();
  __enable_irq(); // UART uses interrupts
  UART_OutString("Lab 4, Spring 2026, Step 3. Debug FSM cycle\n\r");
  UART_OutString("EID1= "); UART_OutString((char*)EID1); UART_OutString("\n\r");
// initialize your FSM
  SysTick_Init();   // Initialize SysTick for software waits
  const state *curr = &driveSouth;
  uint32_t input2 = 7; 

  while(1){
      // 1) output depending on state using Traffic_Out
      // call your Debug_Dump logging your state number and output
      // 2) wait depending on state
      // 3) hard code this so input always shows all switches pressed
      // 4) next depends on state and input
      Traffic_Out(curr->westOutput, curr->southOutput, curr->walkOutput);
      Debug_Dump(PackFSM(curr));
      SysTick_Wait10ms(curr->delayTime);
      uint32_t input = Traffic_In();
      curr = curr->Next[input];
  }
}
// use main5 to grade
int main5(void){// main5
  Clock_Init80MHz(0);
  LaunchPad_Init();
  Grader_Init(); // execute this line before your code
  LaunchPad_LED1off();
  Traffic_Init(); // your Lab 4 initialization
// initialize your FSM
curr = &driveSouth;
  SysTick_Init();   // Initialize SysTick for software waits
  // initialize your FSM
  Lab4Grader(1); // activate UART, grader and interrupts
  while(1){
      // 1) output depending on state using Traffic_Out
      Traffic_Out(curr->westOutput, curr->southOutput, curr->walkOutput);
      // 2) wait depending on state
      SysTick_Wait10ms(curr->delayTime);
      // 3) input from switches
      uint32_t input = Traffic_In();
      // 4) next depends on state and input
      curr = curr->Next[input];
  }
}

