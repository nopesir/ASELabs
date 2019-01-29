.MODEL small
.STACK
.DATA  

; min 20 chars, max 50
prima_riga DB 50 DUP  (?)
seconda_riga DB  50 DUP  (?)
terza_riga DB 50 DUP  (?)
quarta_riga DB 50 DUP (?)
vett_1 DB 52 DUP (0)
vett_2 DB 52 DUP (0)
vett_3 DB 52 DUP (0)
vett_4 DB 52 DUP (0)
.CODE
.STARTUP

; load in Cx the dim of the MAX row
MOV BX, 0                   ; Bx is used to count the memory
MOV DX, 0
MOV SI, 0                   ; SI is used for the chars count


; BX e DI used to access the position in the memory
; corresponding to 4 rows

loop1:
MOV DI, 0                   ; initialise DI
MOV CX, 50                  ; used everytime to read up to 50 chars

labLETT:
MOV AH,1                    ; AH set as char in read

; read a char
INT 21H 
CMP AL,13                   ; check if the char is a \n
JZ exit1                    ; if it is, jump to exit1
MOV prima_riga[BX][DI],AL   ; store the char

CMP AL,32                   ; check if it is a space
JZ salto                    ; if it is, do nothing

CMP AL,'A'                  ; if it is not an alphanumeric, jump
JB salto

CMP AL,'z'                  ; sam as before
JA salto                    ; salto alla fine
CMP AL,'a'                  ; check if the letter is MAIUSC or not
JB maiuscolo
JMP minuscolo

; add 1 at the inserted char
maiuscolo:                  ; (if it is MAIUSC)
push DI                     ; save DI value to be used next
MOV DL,AL
SUB DL,'A'                  ; minus 'A'
MOV DI, DX                  ; in DI there'll be the position in the alphabet A...Za..z
                            ; of the inserted char
PUSH BX                     
MOV BX,SI                   ; mantain in SI a separate char to do the count
ADD vett_1[BX][DI],AH
POP BX
POP DI
JMP salto

minuscolo:                  ; (if it is not MAIUSC)
PUSH DI 
MOV DL,AL
SUB DL,'G'                  ; subtract G to lose the middle char
MOV DI, DX
PUSH BX 
MOV BX,SI
ADD vett_1[BX][DI],AH
POP BX
POP DI

salto:
INC DI                      ; increment of DI to save in the correct position
                            ; the next char
LOOP labLETT


exit1:
CMP DI,20
JB labLETT

ADD BX, 50                  ; sum 50
ADD SI, 52
CMP BX, 200                 ; check if the last row is inserted
JB loop1

; Find the MAX and next initialise the registers
MOV BX,0
MOV DX,0
MOV AX,0
MOV BP,10
max:
MOV DI,0
MOV CX,52

itero:
CMP AL,vett_1[BX][DI]
JAE succ
MOV AL, vett_1[BX][DI]
succ:
INC DI
loop itero

CMP AL, 0
JZ  fuori

MOV DI,0
MOV AH,2
SHR AL,1                    ; divide the max result found so far
stampoLett:
CMP AL, vett_1[BX][DI]
JA dopo
PUSH AX                     ; push AX on the stack

; do ops to print correctly the chars
MOV DX,DI
CMP DL, 26
JAE min
ADD DL, 'A'
INT 21H
MOV AH,0
MOV DL,10
MOV AL,vett_1[BX][DI]
CMP AL,9
JBE div1
DIV DL
ADD AL,48
MOV DL,AL
MOV DH, AH
MOV AH,2
INT 21H
MOV AL, DH
div1:
MOV DL, AL
ADD DL,48
MOV AH,2
INT 21H
POP AX
JMP dopo
min:
ADD DL,'G'
INT 21H
MOV AH,0
MOV DL,10
MOV AL,vett_1[BX][DI]
CMP AL,9
JBE div2
DIV DL
ADD AL,48
MOV DL,AL
MOV DH,AH
MOV AH,2
INT 21H
MOV AL, DH
div2:
MOV DL,AL
ADD DL,48
MOV AH,2
INT 21H
POP AX
dopo:
INC DI
CMP DI, 52
JNZ stampoLett

fuori:
ADD BX, 52
MOV AX,0
CMP BX, 52*4
JB max



; scrittura
MOV BX, 0
MOV DL, 1

loopStampa:
MOV DI, 0                   ; initialise DI
MOV CX, 50

Print_Char:
MOV AL,prima_riga[BX][DI]
ADD AL,DL
CMP AL,'z'                  ; check if it is > or < wrt 0
JBE evita1                  
SUB AL,'z'
ADD AL,'A'-1

evita1:
CMP AL,'A'                  ; prepare AL to print in the correct mode
CMP AL,'Z'
JBE stamp
CMP AL,'a'
JAE stamp
SUB AL,'Z'
ADD AL,'a'-1

stamp:
MOV AH, 2
PUSH DX
MOV DL, AL
INT 21H
POP DX

saltoqui:
INC DI
LOOP Print_Char

loop2:
ADD BX, 50
INC DL
CMP BX, 200
JB loopStampa

exit:
.EXIT


END