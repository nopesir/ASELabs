#include "button.h"
#include "lpc17xx.h"

#include "../timer/timer.h"
#include "../led/led.h"

void EINT0_IRQHandler (void)	  
{
	if(moves[j] != 0) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		LPC_GPIO2->FIOPIN = j;
		n = 1;
		i = 0;
		j = 0;
		enable_timer(0);
	} else {
	
		j++;
	
		if(j == n) {
			n++;
			i = 0;
			j = 0;
			enable_timer(0);
		}
	
	}
	
  LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	
	if(moves[j] != 1) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		LPC_GPIO2->FIOPIN = j;
		n = 1;
		i = 0;
		j = 0;
		enable_timer(0);
	} else {
	
		j++;
		
		if(j == n) {
			n++;
			i = 0;
			j = 0;
			enable_timer(0);
		}
	
	}
	
	LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	
	if(moves[j] != 2) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		LPC_GPIO2->FIOPIN = j;
		n = 1;
		i = 0;
		j = 0;
		enable_timer(0);
	} else {
	
		j++;
	
		if(j == n) {
			n++;
			i = 0;
			j = 0;
			enable_timer(0);
		}
	
	
	}
	
  LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */    
}


