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
					
					
myArea_size		EQU		0x00000018
				
				AREA 	myArea, NOINIT, READWRITE
myArea_mem		SPACE	myArea_size
myArea_p


N				EQU		0x00000003
N_sq			EQU		0x00000009
				
				AREA 	myVec, READWRITE
myVec_mem		SPACE	N_sq
myVec_p





                AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                
				LDR r0, =0x7A30458D
				LDR r1, =0xC3159EAA
				
				; Ex1
				;BL myUADD8				
				
				; Ex2
				;LDR r6, =myArea_p
				;STMIA r6, {r0, r1}
				;BL myUSAD8
				;LDR r5, [r6]
				
				; Ex3A
				;PUSH {r0,r1,r6}
				;BL mySMUAD
				;POP {r0,r1,r6}
				
				
				; Ex3B
				;PUSH {r0,r1,r7}
				;BL mySMUSD
				;POP {r0,r1,r7}
				
				; Ex4
				LDR r0, =matrix
				LDR r1, =N
				
				PUSH {r0-r2}
				BL magicSquare
				POP {r0-r2}
				
stop			B stop				

matrix			DCB 4,9,2,3,5,7,8,1,6

                ENDP
					
					
					
					
myUADD8			PROC
				PUSH {r0,r1,LR}
				LSR r2, r0, #24
				LSR r3, r1, #24
				
				ADD r5, r2, r3
				
				LSL r5, r5, #24
				LSR r5, r5, #24
				
				LSL r4, r4, #8
				ADD r4, r4, r5
				
				LSR r2, r0, #16
				LSL	r2, r2, #24
				LSR r2, r2, #24
				LSR r3, r1, #16
				LSL	r3, r3, #24
				LSR r3, r3, #24
				
				ADD r5, r2, r3
				
				LSL r5, r5, #24
				LSR r5, r5, #24
				
				LSL r4, r4, #8
				ADD r4, r4, r5
				
				LSR r2, r0, #8
				LSL	r2, r2, #24
				LSR r2, r2, #24
				LSR r3, r1, #8
				LSL	r3, r3, #24
				LSR r3, r3, #24
				
				ADD r5, r2, r3
				
				LSL r5, r5, #24
				LSR r5, r5, #24
				
				LSL r4, r4, #8
				ADD r4, r4, r5
				
				MOV r2, r0
				LSL	r2, r2, #24
				LSR r2, r2, #24
				MOV r3, r1
				LSL	r3, r3, #24
				LSR r3, r3, #24
				
				ADD r5, r2, r3
				
				LSL r5, r5, #24
				LSR r5, r5, #24
				
				LSL r4, r4, #8
				ADD r4, r4, r5
				
				POP {r0,r1,PC}
	
				ENDP
					

myUSAD8			PROC
				
				PUSH {r0-r6,LR}
	
				LDMIA r6, {r0,r1}
				
				MOV r4, #0
				
				LSR r2, r0, #24
				LSR r3, r1, #24
				
				SUBS r5, r2, r3			; Caculate the absolute 
				NEGMI r5, r5			; value of the sub
				
				ADD r4, r4, r5
				
				LSR r2, r0, #16
				LSL	r2, r2, #24
				LSR r2, r2, #24
				LSR r3, r1, #16
				LSL	r3, r3, #24
				LSR r3, r3, #24
				
				SUBS r5, r2, r3			; Caculate the absolute 
				NEGMI r5, r5			; value of the sub
				
				LSL r5, r5, #24
				LSR r5, r5, #24
				
				ADD r4, r4, r5
				
				LSR r2, r0, #8
				LSL	r2, r2, #24
				LSR r2, r2, #24
				LSR r3, r1, #8
				LSL	r3, r3, #24
				LSR r3, r3, #24
				
				SUBS r5, r2, r3			; Caculate the absolute 
				NEGMI r5, r5			; value of the sub
				
				LSL r5, r5, #24
				LSR r5, r5, #24
				
				ADD r4, r4, r5
				
				MOV r2, r0
				LSL	r2, r2, #24
				LSR r2, r2, #24
				MOV r3, r1
				LSL	r3, r3, #24
				LSR r3, r3, #24
				
				SUBS r5, r2, r3			; Caculate the absolute 
				NEGMI r5, r5			; value of the sub
				
				LSL r5, r5, #24
				LSR r5, r5, #24
				
				ADD r4, r4, r5
				
				STMIA r6, {r4}
				
				POP {r0-r6,PC}
				
				ENDP
					
					
mySMUAD			PROC
				
				PUSH{r0-r9,LR}
				LDR r0, [sp, #44]
				LDR r1, [sp, #48]
				
				MOV r7, #0 							; INIT to 0
														
				ASR r2, r0, #16						; Shift arithmetically right and save in OpB
				MOV r0, r0, LSL #16					; Shift logically left
				MOV r0, r0, ASR #16					; and then arithmetically right 
														; to take the first MSB halfword
				
				ASR r3, r1, #16						; Do the same with OpD and OpC
				MOV r1, r1, LSL #16
				MOV r1, r1, ASR #16
				
				MUL r4, r0, r1						; Multiply the first pair of halfword
				MUL r5, r2, r3						; and the second one
					
				
				ADD r6, r6, r4		
				ADD r6, r6, r5
				
				STR r6, [sp, #52]
				
				POP{r0-r9,PC}
				
				ENDP
					
mySMUSD			PROC
				
				PUSH{r0-r9,LR}
				LDR r0, [sp, #44]
				LDR r1, [sp, #48]
				
				MOV r7, #0 							; INIT to 0
														
				ASR r2, r0, #16						; Shift arithmetically right and save in OpB
				MOV r0, r0, LSL #16					; Shift logically left
				MOV r0, r0, ASR #16					; and then arithmetically right 
														; to take the first MSB halfword
				
				ASR r3, r1, #16						; Do the same with OpD and OpC
				MOV r1, r1, LSL #16
				MOV r1, r1, ASR #16
				
				MUL r4, r0, r1						; Multiply the first pair of halfword
				MUL r5, r2, r3						; and the second one
					
				
				ADD r6, r6, r4		
				SUB r6, r6, r5
				
				STR r6, [sp, #52]
				
				POP{r0-r9,PC}
				
				ENDP
	

magicSquare		PROC
				
				PUSH {r0-r12, LR}
				MOV r2, #1
				LDR r0, [sp, #56]
				LDR r1, [sp, #60]
				MUL r1, r1, r1
				LDR r3, =myVec_p
				
loop_one				
				SUB r1, r1, #1
				LDRB r4, [r0], #1
				SUB	r4, r4, #1
				STRB r2, [r3, r4]
				CMP r1, #0
				BNE loop_one
				
				LDR r0, [sp, #56]
				LDR r1, [sp, #60]
				MUL r1, r1, r1
				MOV r4, #0
				
loop_two
				SUB r1, r1, #1
				LDRB r2, [r3], #1
				ADD r4, r4, r2
				CMP r1, #0
				BNE loop_two
				
				LDR r0, [sp, #56]
				LDR r1, [sp, #60]
				MUL r1, r1, r1
				MOV r5, r1
				
				CMP r4, r1
				BNE end_bad
				
				LDR r3, =myVec_p

loop_three
				SUB r1, r1, #1
				LDRB r2, [r3], #1
				CMP r2, r5
				BGT end_bad
				CMP r2, #1
				BLT	end_bad
				CMP r1, #0
				BNE loop_three
				
				LDR r0, [sp, #56]
				LDR r1, [sp, #60]
				MUL r1, r1, r1
				B end_good
				

; To finish the last check on magic number
				
				
				
				
end_bad
				MOV r12, #0
				STR r12, [sp, #64]
				B end_end
				
end_good		
				MOV r12, #1
				STR r12, [sp, #64]
				
end_end
				POP {r0-r12, PC}
				
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
