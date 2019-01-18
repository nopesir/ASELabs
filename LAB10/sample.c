/*----------------------------------------------------------------------------
 * Name:    sample.c
 * Purpose: to control led through EINT buttons
 * Note(s):
 *----------------------------------------------------------------------------
 *
 * This software is supplied "AS IS" without warranties of any kind.
 *
 * Copyright (c) 2017 Politecnico di Torino. All rights reserved.
 *----------------------------------------------------------------------------*/
                  
#include <stdio.h>
#include "LPC17xx.H"                    /* LPC17xx definitions                */
#include "led/led.h"
#include "button_EXINT/button.h"
#include "timer/timer.h"

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main (void) {
  	
	SystemInit();  												/* System Initialization (i.e., PLL)   */
  LED_init();                           /* LED Initialization                  */
  BUTTON_init();												/* BUTTON Initialization               */
	init_timer(0,0x023C3460);							/* TIMER0 Initialization to 25MHz*1.5s 0x00103460 0x023C3460 */		
	init_timer(1,0xFFFA3460);							/* TIMER1 as random seed 							 */
	
	i = 0;
	j = 0;
	n = 1;
	
	enable_timer(0);
	enable_timer(1);
		
  while (1) {                           /* Loop forever                        */	
		
		
		
  }

}
