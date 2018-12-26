																			 /*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           timer.h
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        Prototypes of functions included in the lib_led, funct_led .c files
** Correlated files:    lib_led.c, funct_led.c
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/

/* lib_led */
void LED_init(void);
void LED_deinit(void);

/* func_led (Ex 1 to Ex 5) */
void led4and11_On(void);
void voidled4_Off(void);
void ledEvenOn_OddOf(void);
void LED_On(unsigned int num);
void LED_Off(unsigned int num);
