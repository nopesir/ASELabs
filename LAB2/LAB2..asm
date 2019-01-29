N EQU 4
M EQU 7
P EQU 5

.MODEL small
.STACK
.DATA


A DB  3, 14, -15, 9, 26, -53, 5, 89, 79,  3, 23, 84, -6, 26, 43, -3, 83, 27, -9, 50, 28, -88, 41, 97, -103, 69, 39, -9
B DB  37, -101, 0, 58, -20, 9, 74, 94, -4, 59, -23, 90, -78, 16, -4, 0, -62, 86, 20, 89, 9, 86, 28, 0, -34, 82, 5, 34, -21, 1,70, -67, 9, 82, 14
C DW  N*P DUP (?)

.CODE
.STARTUP

; 3 nested cycles
MOV CX, N ; assign the initial number of the result vector C
XOR AX, AX
MOV BX, 0
MOV SI,0 ; uset to index a cell of the result vector

ciclo_esterno:

    MOV DI,0
    MOV C[SI],0
    PUSH CX ; push Cx in the stack to be used after
    MOV CX, P ; internal middle cycle (C columns)

        ciclo_medio:
            
            PUSH CX ; push the counter to initialise with, for the intern intern cycle
            MOV CX, M ;rows of A ancd columns of B (Ai*Bj)
            PUSH BX ; save it, it will be modified next
            PUSH DI
            ciclo_int:
             ; calculate the value of a cell of the result vector
             ; doing the summation of products of rows by columns
             MOV DX,0
             MOV AX,0
             MOV AL,A[BX]
             CBW ; translate the bythe signed (8bit) from AL in the word with signed 16bit (AH)
             PUSH AX  ; save the value of AX, used later
             MOV DL, B[DI]
             MOV AX,DX
             CBW
             MOV DX, AX
             POP AX
             IMUL DX ; multiply row by column
             Call controllo; overflow management
             ADD C[SI], AX ; sum the result + what I had before
             Call controllo2
             INC BX
             ADD DI, P

        LOOP ciclo_int
        ; some checks to do in the right way the summations
        POP DI
        POP BX
        INC DI
        
        POP CX
        ADD SI, 2
    LOOP ciclo_medio
    ADD BX, M
    POP CX
   
LOOP ciclo_esterno




.EXIT
; overflow control between the procedures
controllo PROC
JNO ok
JNS cambio
MOV AX, 32767
JMP ok
cambio:
MOV AX, -32768
ok:
RET

controllo2 PROC
JNO ok2
JNS cambio2
MOV AX, 32767
MOV C[SI],AX
JMP ok2
cambio2:
MOV AX, -32768
MOV C[SI],AX
ok2:
RET

controllo2 ENDP
END