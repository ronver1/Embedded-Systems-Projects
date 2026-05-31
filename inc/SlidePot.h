// SlidePot.h
// Runs on MSPM0
// Provide functions that initialize ADC1 channel 5, PB18 and use a slide pot to measure distance
// Created: July 19, 2025
// Student names: change this to your names or look very silly
// Last modification date: change this to the last modification date or look very silly

#ifndef SLIDEPOT_H
#define SLIDEPOT_H
#include <stdint.h>

class SlidePot{ 
public:
  volatile int32_t flag;      // 0 if data is not valid, 1 if valid
  uint32_t ADC;
  uint32_t index;
  uint32_t channel;
  SlidePot(void); // initialize slide pot
  void Init(uint32_t ADC, uint32_t i, uint32_t c);
  uint32_t In(void);                // return last ADC sample value (0 to 4095)
  void Trigger(void);
};

void ADC0_Init(void);
void ADC1_Init(void);

#endif
