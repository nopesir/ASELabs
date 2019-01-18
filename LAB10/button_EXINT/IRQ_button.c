#include "button.h"
#include "lpc17xx.h"

#include "../timer/timer.h"
#include "../led/led.h"

int wait = 0;
int wait2 = 0;
unsigned int bounce = 0;
unsigned int bounce2 = 0;


void EINT0_IRQHandler (void)	  
{
	bounce = LPC_TIM1->TC;
	
	if(bounce - bounce2 < 10000000) {
		LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
		return;
	}
	
	if(wait) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		enable_timer(0);
		wait = 0;
		LPC_SC->EXTINT = (1 << 0);
		return;
	} else if(wait2) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		enable_timer(0);
		wait2 = 0;
		LPC_SC->EXTINT = (1 << 0);
		return;
	}
	
	
	if(moves[j] != 0) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		LPC_GPIO2->FIOPIN = j;
		
		n = 1;
		i = 0;
		j = 0;
		
		wait2 = 1;
		//enable_timer(0);
	} else {
	
		j++;
	
		if(j == n) {
			LPC_GPIO2->FIOCLR = 0x000000FF;
			LPC_GPIO2->FIOPIN = n;
			n++;
			if(n > 255) {
				n = 1;
			}
			i = 0;
			j = 0;
			wait = 1;
			//enable_timer(0);
		}
	
	}
	
	bounce = LPC_TIM1->TC;
	bounce2 = bounce;
	
  LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	bounce = LPC_TIM1->TC;
	
	if(bounce - bounce2 < 10000000) {
		LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
		return;
	}
	
	if(wait) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		enable_timer(0);
		wait = 0;
		LPC_SC->EXTINT = (1 << 1);
		return;
	} else if(wait2) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		enable_timer(0);
		wait2 = 0;
		LPC_SC->EXTINT = (1 << 1);
		return;
	}
	
	if(moves[j] != 1) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		LPC_GPIO2->FIOPIN = j;
		n = 1;
		i = 0;
		j = 0;
		wait2 = 1;
		//enable_timer(0);
	} else {
	
		j++;
		
		if(j == n) {
			LPC_GPIO2->FIOCLR = 0x000000FF;
			LPC_GPIO2->FIOPIN = n;
			n++;
			if(n > 255) {
				n = 1;
			}
			i = 0;
			j = 0;
			wait = 1;
			//enable_timer(0);
		}
	
	}
	
	bounce = LPC_TIM1->TC;
	bounce2 = bounce;
	
	LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	bounce = LPC_TIM1->TC;
	
	if(bounce - bounce2 < 10000000) {
		LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */
		return;
	}
	
	if(wait) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		enable_timer(0);
		wait = 0;
		LPC_SC->EXTINT = (1 << 2);
		return;
	} else if(wait2) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		enable_timer(0);
		wait2 = 0;
		LPC_SC->EXTINT = (1 << 2);
		return;
	}
	
	if(moves[j] != 2) {
		LPC_GPIO2->FIOCLR = 0x000000FF;
		LPC_GPIO2->FIOPIN = j;
		n = 1;
		i = 0;
		j = 0;
		wait2 = 1;
		//enable_timer(0);
	} else {
	
		j++;
	
		if(j == n) {
			LPC_GPIO2->FIOCLR = 0x000000FF;
			LPC_GPIO2->FIOPIN = n;
			n++;
			if(n > 255) {
				n = 1;
			}
			i = 0;
			j = 0;
			wait = 1;
			//enable_timer(0);
		}
	
	
	}
	
	bounce = LPC_TIM1->TC;
	bounce2 = bounce;
	
  LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */    
}


