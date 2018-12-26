#include <stdlib.h>
#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"

void EINT0_IRQHandler (void)	  
{
	unsigned int gen = rand() % 2 + 4;  // 1010-1000  or  0101-0100
	unsigned int res;
	
	LED_On(gen);
	
	res = LPC_GPIO2->FIOSET; 
	
	if( (res == 0x000000A8) || (res == 0x00000054) )
		LED_On(7);
	else
		LED_On(6);
	
  LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	unsigned int gen = rand() % 2;
	
	LPC_GPIO2->FIOPIN = 0x00000000;
	
	LED_On(gen);
	
  LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	unsigned int gen = rand() % 2 + 2;
	
	LED_On(gen);
	
  LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */  
}


