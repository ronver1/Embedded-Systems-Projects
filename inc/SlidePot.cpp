/* SlidePot.cpp
 * Students put your names here
 * Modified: put the date here
 * 12-bit ADC input on ADC1 channel 5, PB18
 */
#include <ti/devices/msp/msp.h>
#include "../inc/Clock.h"
#include "../inc/SlidePot.h"
#include "../inc/LaunchPad.h"
#define ADCVREF_VDDA 0x000
#define ADCVREF_INT  0x200


void ADC1_Init(void) { 
  ADC1->ULLMEM.GPRCM.RSTCTL = 0xB1000003; // 1) reset
  ADC1->ULLMEM.GPRCM.PWREN = 0x26000001;  // 2) activate
  Clock_Delay(24);                        // 3) wait
  ADC1->ULLMEM.GPRCM.CLKCFG = 0xA9000000; // 4) ULPCLK
  ADC1->ULLMEM.CLKFREQ = 7;               // 5) 40-48 MHz
  ADC1->ULLMEM.CTL0 = 0x03010000;         // 6) divide by 8
  ADC1->ULLMEM.CTL1 = 0x00010000;         // 7) mode
  ADC1->ULLMEM.CTL2 = 0x00000000;         // 8) MEMRES
  ADC1->ULLMEM.MEMCTL[0] = 5;             // Step 9
  ADC1->ULLMEM.SCOMP0 = 0;                // 10) 8 sample clocks
  ADC1->ULLMEM.CPU_INT.IMASK = 0;         // 11) no interrupt
}

void ADC0_Init(void){
  ADC0->ULLMEM.GPRCM.RSTCTL = 0xB1000003; // 1) reset
  ADC0->ULLMEM.GPRCM.PWREN = 0x26000001;  // 2) activate
  Clock_Delay(24);                        // 3) wait
  ADC0->ULLMEM.GPRCM.CLKCFG = 0xA9000000; // 4) ULPCLK
  ADC0->ULLMEM.CLKFREQ = 7;               // 5) 40-48 MHz
  ADC0->ULLMEM.CTL0 = 0x03010000;         // 6) divide by 8
  ADC0->ULLMEM.CTL1 = 0x00000000;         // 7) mode
  ADC0->ULLMEM.CTL2 = 0x00000000;         // 8) MEMRES
  ADC0->ULLMEM.MEMCTL[0] = 3;             // 9) channel 6 is PB20
  ADC0->ULLMEM.SCOMP0 = 0;                // 10) 8 sample clocks
  ADC0->ULLMEM.CPU_INT.IMASK = 0;         // 11) no interrupt
}

void SlidePot::Init(uint32_t ADC, uint32_t i, uint32_t c){
  this->ADC = ADC;
  this->index = i;
  this->channel = c;
}

uint32_t SlidePot::In(void){
  if (this->ADC == 1) {
    return ADC1->ULLMEM.MEMRES[this->index];               // 5) 12-bit result
  } else {
    return ADC0->ULLMEM.MEMRES[this->index];
  }
}


// constructor, invoked on creation of class
SlidePot::SlidePot(void) { 
  this->flag = 0;
}

void SlidePot::Trigger(void) {
  if (this->ADC == 1) {
    ADC1->ULLMEM.CTL0 |= 0x00000001;             // 1) enable conversions
    ADC1->ULLMEM.CTL1 |= 0x00000100;             // 2) start ADC
    uint32_t volatile delay=ADC1->ULLMEM.STATUS; // 3) time to let ADC start
    while((ADC1->ULLMEM.STATUS&0x01)==0x01){}    // 4) wait for completion
  } else {
    ADC0->ULLMEM.CTL0 |= 0x00000001;             // 1) enable conversions
    ADC0->ULLMEM.CTL1 |= 0x00000100;             // 2) start ADC
    uint32_t volatile delay=ADC0->ULLMEM.STATUS; // 3) time to let ADC start
    while((ADC0->ULLMEM.STATUS&0x01)==0x01){}    // 4) wait for completion
  }
}


