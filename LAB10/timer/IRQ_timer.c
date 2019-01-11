/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_timer.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    timer.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"
#include "../led/led.h"


int moves[255];
int i;
int j;
int n;
int flag = 0;


/******************************************************************************
** Function name:		Timer0_IRQHandler
**
** Descriptions:		Timer/Counter 0 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/



void TIMER0_IRQHandler (void)
{

	if( ((i+1)%2 != 0) ) {
		
		int sel = LPC_TIM1->TC % 3;
		LED_On(sel);
		moves[i/2] = sel;
		i++;
		enable_timer(0);
		
	} else {
		
		LPC_GPIO2->FIOCLR = 0x000000FF;
		
		if( (i+1)/2 < n) {
			i++;
			enable_timer(0);
		}
	
	}
	
	
  LPC_TIM0->IR = 1;			/* clear interrupt flag */
  
	return;
	
}


/******************************************************************************
** Function name:		Timer1_IRQHandler
**
** Descriptions:		Timer/Counter 1 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void TIMER1_IRQHandler (void)
{
  LPC_TIM1->IR = 1;			/* clear interrupt flag */
  return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
