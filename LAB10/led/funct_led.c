#include "lpc17xx.h"
#include "led.h"
#include <math.h>


/*----------------------------------------------------------------------------
  Used defined functions
 *----------------------------------------------------------------------------*/

/* Ex1 */
void led4and11_On(void) {

	LPC_GPIO2->FIOSET   |= 0x00000081;
	
};

/* Ex 2 */
void voidled4_Off(void) {

	LPC_GPIO2->FIOCLR   |= 0x00000080;
	
};

/* Ex 3 */
void ledEvenOn_OddOf(void) {
	
	/*
	* In order to avoid modifications on other PINs, we use FIOMASK
	* with 0s at the interested bits that must change. Then we use
	* FIOMASK in WRITE mode to change the PINs.
	*/
	
	LPC_GPIO2->FIOMASK  |= 0xFFFFFF00;	// Ensure that all initial PINs are on 1
	LPC_GPIO2->FIOMASK  &= 0xFFFFFF00;	// Ensure that the 8 final bits are on 0
	LPC_GPIO2->FIOPIN  = 0x000000AA;	  // Set every odd PIN in ON  1010 1010
	
};

/* Ex 4 */
void LED_On(unsigned int num) {

	if(num > 7)
		return;
	else
		LPC_GPIO2->FIOSET |= 0x00000080 >> num;

}

/* Ex 5 */
void LED_Off(unsigned int num) {
	
	if(num > 7)
		return;
	else
		LPC_GPIO2->FIOCLR |= 0x00000080 >> num;
	
}
