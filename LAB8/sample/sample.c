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

/* Led external variables from funct_led */

/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main (void) {
  
  SystemInit();  												/* System Initialization (i.e., PLL)  */
  LED_init();                           /* LED Initialization                 */
	
	led4and11_On();
	
	voidled4_Off();
	
	ledEvenOn_OddOf();
	
	LED_On(1);
	LED_On(5);
	LED_On(10);
	
	LED_Off(1);
	LED_Off(5);
	LED_Off(10);
  
	//BUTTON_init();												/* BUTTON Initialization              */
	
  while (1) {                           /* Loop forever                       */	
  }

}
