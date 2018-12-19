#include <stdio.h>
#include <stdlib.h>
#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"


void EINT0_IRQHandler (void)	  
{
  LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
	LPC_GPIO2->FIOPIN = (1 << 7);

}

void EINT1_IRQHandler (void)	  
{
	
	int i;
	unsigned int state;
	state = LPC_GPIO2->FIOSET;
	
  LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
	
	if(state == 0x00000080)
		LPC_GPIO2->FIOPIN = (1 << 0);
	else
		LPC_GPIO2->FIOPIN = (state << 1); 
	
	for(i = 0; i < 1000; i++);
}

void EINT2_IRQHandler (void)	  
{
	
	int i;
	unsigned int state; 
	state = LPC_GPIO2->FIOSET;
  LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */ 
		
	if(state == 0x00000001)
		LPC_GPIO2->FIOPIN = (1 << 7);
	else
		LPC_GPIO2->FIOPIN = (state >> 1);  
	
	for(i = 0; i < 1000; i++);
}


