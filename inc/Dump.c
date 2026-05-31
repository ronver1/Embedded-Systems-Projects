// Dump.c
// Your solution to ECE319K Lab 3 Spring 2026
// Author: Ronit Verma
// Last Modified: 2/10/26


#include <ti/devices/msp/msp.h>
#include "../inc/Timer.h"
#define MAXBUF 50
uint32_t DataBuffer[MAXBUF];
uint32_t TimeBuffer[MAXBUF];
uint32_t DebugCnt; // 0 to MAXBUF (0 is empty, MAXBUF is full)

// *****Debug_Init******
// Initializes your index or pointer.
// Input: none
// Output:none
void Debug_Init(void){
// students write this for Lab 3
// This function should also initialize Timer G12, call TimerG12_Init.
DebugCnt = 0;
TimerG12_Init();
}

// *****Debug_Dump******
// Records one data and one time into the two arrays.
// Input: data is value to store in DataBuffer
// Output: 1 for success, 0 for failure (buffers full)
uint32_t Debug_Dump(uint32_t data){
// students write this for Lab 3
// The software simply reads TIMG12->COUNTERREGS.CTR to get the current time in bus cycles.
if (DebugCnt >= MAXBUF) {
  return 0;                             // No space in array
}

DataBuffer[DebugCnt] = data;            
TimeBuffer[DebugCnt] = TIMG12->COUNTERREGS.CTR;
DebugCnt = DebugCnt + 1;
return 1;

}
// *****Debug_Dump2******
// Always record data and time on the first call to Debug_Dump2
// However, after the first call
//    Records one data and one time into the two arrays, only if the data is different from the previous call.
//    Do not record data or time if the data is the same as the data from the previous call
// Input: data is value to store in DataBuffer
// Output: 1 for success (saved or skipped), 0 for failure (buffers full)
uint32_t Debug_Dump2(uint32_t data){
// students write this for Lab 3
// The software simply reads TIMG12->COUNTERREGS.CTR to get the current time in bus cycles.
if (DebugCnt >= MAXBUF) {
  return 0;
}  

if (DebugCnt == 0) {
  DataBuffer[DebugCnt] = data;            
  TimeBuffer[DebugCnt] = TIMG12->COUNTERREGS.CTR;
  DebugCnt = DebugCnt + 1;
  return 1;
} 

if (DataBuffer[DebugCnt - 1] == data) {
  return 1;
  }

DataBuffer[DebugCnt] = data;            
TimeBuffer[DebugCnt] = TIMG12->COUNTERREGS.CTR;
DebugCnt = DebugCnt + 1;
return 1;
}

// *****Debug_Period******
// Calculate period of the recorded data using mask
// Input: mask specifies which bit(s) to observe
// Output: period in bus cycles
// Period is defined as rising edge (low to high) to the next rising edge.
// Return 0 if there is not enough collected data to calculate period .
uint32_t Debug_Period(uint32_t mask){
// students write this for Lab 3
// This function should not alter the recorded data.
// AND each recorded data with mask,
//    if nonzero the signal is considered high.
//    if zero, the signal is considered low.

// Must check for Low->High(t1)->Low->High(t2)
// Period = t2-t1

uint32_t i, time1 = 0, haveFirstRise = 0, lastRiseTime = 0, period = 0, SumPeriod = 0, PeriodCnt = 0, AvgPeriod = 0, currHigh, prevHigh;

for (i = 1; i < DebugCnt; i++) {
  currHigh = ((DataBuffer[i] & mask) != 0);
  prevHigh = ((DataBuffer[i - 1] & mask) != 0);

  if (currHigh != 0 && prevHigh == 0 ) {      // if rising edge occurs
    if (haveFirstRise == 0) {
      lastRiseTime = TimeBuffer[i];
      haveFirstRise = 1;
    } else {
      period = lastRiseTime - TimeBuffer[i];
      SumPeriod += period;
      PeriodCnt++;
      lastRiseTime = TimeBuffer[i];
    }
  }
}
if (PeriodCnt == 0) {
  return 0;
} else {
  AvgPeriod = SumPeriod / PeriodCnt;
  return AvgPeriod;
}
}


// *****Debug_Duty******
// Calculate duty cycle of the recorded data using mask
// Input: mask specifies which bit(s) to observe
// Output: period in percent (0 to 100)
// Period is defined as rising edge (low to high) to the next rising edge.
// High is defined as rising edge (low to high) to the next falling edge.
// Duty cycle is (100*High)/Period
// Return 0 if there is not enough collected data to calculate duty cycle.
uint32_t Debug_Duty(uint32_t mask){
// students write this for Lab 3
// This function should not alter the recorded data.
// AND each recorded data with mask,
//    if nonzero the signal is considered high.
//    if zero, the signal is considered low.

uint32_t i, time1 = 0, haveFirstRise = 0, lastRiseTime = 0, period = 0, SumPeriod = 0, PeriodCnt = 0, AvgPeriod = 0, currHigh, prevHigh;
uint32_t haveRise = 0, lastFallTime = 0, haveFirstFall = 0, pulse_width = 0, SumPulseWidth = 0, PulseWidthCnt = 0, AvgPulseWidth = 0, Duty_Cycle = 0;
for (i = 1; i < DebugCnt; i++) {
  currHigh = ((DataBuffer[i] & mask) != 0);
  prevHigh = ((DataBuffer[i - 1] & mask) != 0);

  if (currHigh != 0 && prevHigh == 0 ) {      // if rising edge occurs
    if (haveFirstRise == 0) {
      lastRiseTime = TimeBuffer[i];
      haveFirstRise = 1;
    } else {
      period = lastRiseTime - TimeBuffer[i];
      SumPeriod += period;
      PeriodCnt++;
      lastRiseTime = TimeBuffer[i];
    }
  }

  if (currHigh != 0 && prevHigh == 0 ) {     
    lastRiseTime = TimeBuffer[i];
    haveRise = 1;
  }

  if (((prevHigh != 0 && currHigh == 0) && haveRise == 1)) {      
    pulse_width = lastRiseTime - TimeBuffer[i];
    SumPulseWidth += pulse_width;
    PulseWidthCnt++;
    haveRise = 0;
  }
    }

    if (PulseWidthCnt == 0 || PeriodCnt == 0) {
      return 0;
      } else {
        AvgPeriod = SumPeriod / PeriodCnt;
        AvgPulseWidth = SumPulseWidth / PulseWidthCnt;
        Duty_Cycle = (100 * AvgPulseWidth) / AvgPeriod;
        return Duty_Cycle;
}
  }


// Lab2 specific debugging code
uint32_t Theperiod;
uint32_t TheDuty;
void Dump(void){
  uint32_t out = GPIOB->DOUT31_0&0x0040000; // PB18-PB16 outputs
  uint32_t in = GPIOB->DIN31_0&0x04;        // PB3-PB0 inputs
  uint32_t data = out|in;                   // PB18-PB16, PB3-PB0
  uint32_t result = Debug_Dump(data);       // calls your Lab3 function
  if(result == 0){ // 0 means full
    Theperiod = Debug_Period(1<<18);        // calls your Lab3 function
    TheDuty = Debug_Duty(1<<18);
//   __asm volatile("bkpt; \n"); // breakpoint here
// observe Theperiod
  }
}




