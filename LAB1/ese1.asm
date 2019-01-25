.MODEL small
.STACK
.DATA  

; minimo di 20 caratteri max di 50
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

; carica in CX la dim della riga MAX
MOV BX, 0                   ; BX mi serve per contare bene nella memoria
MOV DX, 0
MOV SI, 0                   ; SI mi serve per il conteggio delle lettere 


; con i registri BX e DI accedo alle posizioni nella memoria
; che corrispondono alle 4 righe

loop1:
MOV DI, 0                   ; azzero DI
MOV CX, 50                  ; utilizzato ogni volta per leggere fino a 50 car.

labLETT:
MOV AH,1                    ; predispongo AH per la lettura di un carattere

; lettura di un carattere
INT 21H 
CMP AL,13                   ; controllo se il carattere scritto è uguale al carattere di invio
JZ exit1                    ; nel caso sia uguale salto alla funzione exit1.
MOV prima_riga[BX][DI],AL   ; MEMORIZZO CARATTERE

CMP AL,32                   ; controllo se è uno spazio
JZ salto                    ; nel caso sia uno spazio non faccio nulla

CMP AL,'A'                  ; se non è un carattere alfabetico o uno spazio salto
JB salto

CMP AL,'z'                  ; se non è un carattere alfabetico o uno spazio
JA salto                    ; salto alla fine
CMP AL,'a'                  ; controllo se è una lettera maiuscola o minuscola
JB maiuscolo
JMP minuscolo

; in questa funzione aggiungo 1 al contatore della lettere inserita
maiuscolo:                  ; (nel caso sia maiuscolo)
push DI                     ; salvo il valore di DI per poterlo utilizzare
MOV DL,AL
SUB DL,'A'                  ; sottraggo 'A'
MOV DI, DX                  ; in DI ora ho la posizione nell'alfabeto A...Za..z
                            ; del carattere inserito.
PUSH BX                     ; uguale movimenti di DX
MOV BX,SI                   ; in Si mantengo un contatore separato per il conteggio 
ADD vett_1[BX][DI],AH
POP BX
POP DI
JMP salto

minuscolo:                  ; (nel caso sia minuscolo)
PUSH DI 
MOV DL,AL
SUB DL,'G'                  ; tolgo G per perdere quei caratteri a meta
MOV DI, DX
PUSH BX 
MOV BX,SI
ADD vett_1[BX][DI],AH
POP BX
POP DI

salto:
INC DI                      ; incremento DI cosi da poter salvare nella posizione corretta 
                            ; il prossimo carattere.
LOOP labLETT


exit1:
CMP DI,20
JB labLETT

ADD BX, 50                  ; sommo a BX 52
ADD SI, 52
CMP BX, 200                 ;controllo se abbiamo inserito l'ultima riga
JB loop1

; Cerco il massimo e successivamente stampo / azzero i registri
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
SHR AL,1                    ; divido il massimo valore trovato
stampoLett:
CMP AL, vett_1[BX][DI]
JA dopo
PUSH AX                     ; metto nello stack AX

; faccio operazioni per stampare nel modo corretto il carattere
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
MOV DI, 0                   ; azzero DI
MOV CX, 50

Print_Char:
MOV AL,prima_riga[BX][DI]
ADD AL,DL
CMP AL,'z'                  ; controllo per prima cosa che se è
JBE evita1                  ; maggiore o minore di z
SUB AL,'z'
ADD AL,'A'-1

evita1:
CMP AL,'A'                  ; preparo nel registro AL per 
JB saltoqui                 ; stampare nel modo corretto
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