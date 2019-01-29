;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF

stack_size		EQU  200

dischi_da_spostare EQU 3

				AREA 	myarea, DATA, READWRITE

				SPACE stack_size
	
stack_one		SPACE stack_size
	
stack_two		SPACE stack_size
	
stack_three		SPACE 1

                AREA    |.text|, CODE, READONLY

seq				DCD 9, 6, 3, 2, 1, 8, 7, 0, 5, 4, 0 

; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				
				LDR	R0, =seq			
SP1 			RN R1
SP2 			RN R2
SP3 			RN R3
				LDR SP1, =stack_one
				LDR SP2, =stack_two
				LDR SP3, =stack_three
				
				PUSH{R0, SP1}
				BL fillStack
				POP {R0, SP1}
				
				PUSH{R0, SP2}
				BL fillStack
				POP {R0, SP2}
				
				PUSH{R0, SP3}
				BL fillStack
				POP {R0, SP3}
				
				PUSH{SP1}
				PUSH{SP2}
				PUSH{R4}
				BL move1
				POP{R4}
				POP{SP2}
				POP{SP1}
				
				LDR	R5, =dischi_da_spostare
				
				PUSH{SP1, SP2, SP3, R5}
				BL moveN
				POP{SP1, SP2, SP3, R5}
				

stop 			B stop
                ENDP
					
fillStack 		PROC
				PUSH{R0-R12, LR}
				LDR R0, [SP, #56]		;SEQ
				LDR R1, [SP, #60]		;STACK POINTER
				LDR R2, [R0], #4
				CMP R2, #0
				BEQ	fine_zero
label			STMFD R1!, {R2}
				MOV R3, R2				;r3 used to memoryse the extracted before number and do a comparison
				LDR R2, [R0], #4
				CMP R2, #0
				BEQ	fine_zero
				CMP R2, R3
				BGT fine
				B label
fine			SUB R0, R0, #4			; decrease the pointer to the sequence
										; if I stopped is because the next element is greater than the previous one,
										; otherwise if it is zero it is not necessary to decrease
fine_zero		STR R0, [SP, #56]		;SEQ
				STR R1, [SP, #60]		;STACK POINTER
				POP{R0-R12, PC}
				ENDP

move1			PROC
				PUSH{R0-R12, LR}
				LDR R0, [SP, #56]		;return value
				LDR R2, [SP, #60]		;Stack pointer 2
				LDR R1, [SP, #64]		;Stack pointer 1
				
				LDMFD R1!, {R3}			; last element inserted in stack1
				LDMFD R2, {R4}			; last element inserted in stack2, if no element inserted it would be 0
				CMP R4, #0
				BEQ sposta
				CMP R4, R3
				MOVLE R0, #0
				BLE fine2		
				
sposta			STMFD R2!, {R3}
				MOV R0, #1
fine2
				STR R0, [SP, #56]		;return value
				STR R2, [SP, #60]		;Stack pointer 2
				STR R1, [SP, #64]		;Stack pointer 1
				POP{R0-R12, PC}
				ENDP
					

moveN			PROC
				PUSH{R0-R12, LR}
				LDR R0, [SP, #56]		;stack start
				LDR R1, [SP, #60]		;Stack end
				LDR R2, [SP, #64]		;stack bridge
				LDR R3, [SP, #68]		;number of elements to be moved
				
N				RN R3
				SUB R6, N, #1
N1				RN	R6
M				RN R4 					;number of movements done
X				RN R0
Y				RN R1
Z				RN R2
				MOV M, #0
				CMP N, #1
				BNE	els
				
				PUSH{X}
				PUSH{Y}
				PUSH{R5}
				BL move1
				POP{R5}
				POP{Y}
				POP{X}
				
				ADD M, M, R5
				B fine3
els	
				PUSH{N1}
				PUSH{Y}
				PUSH{Z}
				PUSH{X}
				BL moveN
				POP{X}
				POP{Z}
				POP{Y}
				POP{R7}
				ADD M, M, R7
				
				PUSH{X}
				PUSH{Y}
				PUSH{R5}
				BL move1
				POP{R5}
				POP{Y}
				POP{X}
				
				CMP R5, #0
				BEQ fine3
				ADD M, M, #1
				PUSH{N1}
				PUSH{X}
				PUSH{Y}
				PUSH{Z}
				BL moveN
				POP{Z}
				POP{Y}
				POP{X}
				POP{R8}
				ADD M, M, R8
fine3
				STR R0, [SP, #56]		;stack start
				STR R1, [SP, #60]		;Stack end
				STR R2, [SP, #64]		;stack bridge
				STR R3, [SP, #68]		;number of movements done
				POP{R0-R12, PC}
				ENDP


; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                ;IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
