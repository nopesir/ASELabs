#include <stdio.h>
#include <stdlib.h>
#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"

int i;
int check = 0;

void EINT0_IRQHandler (void)	  
{
  LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
	LPC_GPIO2->FIOPIN = 0x00000000;
	LPC_GPIO2->FIOPIN = (1 << 3);

}

void EINT1_IRQHandler (void)	  
{
	unsigned int state;
	state = LPC_GPIO2->FIOSET;
	
  if(check) {
		check = 0;
	
	LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */ 
	return;
	
	}
	
	if(state == 0x00000080)
		LPC_GPIO2->FIOPIN = (1 << 0);
	else
		LPC_GPIO2->FIOPIN = (state << 1); 
	
	for(i = 0; i < 1000000; i++);
	i = 0;
	LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
	
	check = !check;
}

void EINT2_IRQHandler (void)	  
{
	unsigned int state; 
	state = LPC_GPIO2->FIOSET;
  
	if(check) {
		check = 0;
		LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */ 
		return;	
	}
	if(state == 0x00000001)
		LPC_GPIO2->FIOPIN = (1 << 7);
	else
		LPC_GPIO2->FIOPIN = (state >> 1);  
	
	for(i = 0; i < 1000000; i++);
	i = 0;
	LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */ 
	
	check = !check;
}


