/* UART2.cpp
 * Ronit Verma, Arianna Pascual
 * April 7th, 2026
 * PA22 UART2 Rx from other microcontroller PA8 IR output<br>
 */


#include <ti/devices/msp/msp.h>
#include "UART2.h"
#include "../inc/Clock.h"
#include "../inc/LaunchPad.h"
#include "../inc/FIFO2.h"

uint32_t LostData = 0;
Queue FIFO2;

// power Domain PD0
// for 80MHz bus clock, UART2 clock is ULPCLK 40MHz
// initialize UART2 for 2375 baud rate
// no transmit, interrupt on receive timeout
void UART2_Init(void){
    // RSTCLR to GPIOA and UART2 peripherals
   // write this
   LostData = 0;
   UART2->GPRCM.RSTCTL = 0xB1000003; // reset 
   UART2->GPRCM.PWREN = 0x26000001; // activate 
   Clock_Delay(24); // time for uart to activate
   IOMUX->SECCFG.PINCM[PA22INDEX] = 0x40082;
   UART2->CLKSEL = 0x08; // bus clock
   UART2->CLKDIV = 0x00; // no divideDisable 
   UART2->CTL0 &= ~0x01; //Enable FIFOs, Rx
   UART2->CTL0 = 0x00020008;
   UART2->IBRD = 1052;  // Establish baud rate = 2375 bps
   UART2->FBRD = 40;    // Establish baud rate = 2375 bps
   UART2->LCRH = 0x00000030; //enable 
   UART2->IFLS &= 0xFFFFF0FF;
   UART2->IFLS |= 0x0400;
   UART2->CPU_INT.IMASK |= 0x0401;
   UART2->CTL0 |= 0x01; // enable UART0
   NVIC->ICPR[0] = 1<<14;
   NVIC->ISER[0] = 1<<14;
   NVIC->IP[3] = (NVIC->IP[3]&(~0xFF000000)) | (2<<30);
   
   }
//------------UART2_InChar------------
// Get new serial port receive data from FIFO2
// Input: none
// Output: Return 0 if the FIFO2 is empty
//         Return nonzero data from the FIFO1 if available
char UART2_InChar(void){
  char out;
  bool tf;

//  while (FIFO2.IsEmpty() == true) { }

  tf = FIFO2.Get(&out);
  return out;

}

uint32_t RxCounter = 0;
extern "C" void UART2_IRQHandler(void);
void UART2_IRQHandler(void){ 
  uint32_t status; 
  char letter;
  bool tf;
  status = UART2->CPU_INT.IIDX; // reading clears bit in RTOUT
  if(status == 0x01){   // 0x01 receive timeout
    GPIOB->DOUTTGL31_0 = BLUE; // toggle PB22 (minimally intrusive debugging)
    GPIOB->DOUTTGL31_0 = BLUE; // toggle PB22 (minimally intrusive debugging)
    // read all data, putting in FIFO
    // finish writing this
    while ((UART2->STAT & 0x04) == 0) { 
      letter = UART2->RXDATA;
      tf = FIFO2.Put(letter);
      if (tf == false) {
        LostData++;
      }
    }

    RxCounter++;
    status = UART2->CPU_INT.IIDX;
   
    GPIOB->DOUTTGL31_0 = BLUE; // toggle PB22 (minimally intrusive debugging)
  }
}
