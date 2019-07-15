;Programa 11.- Programa que pide un numero de 3 cifras, y lo despliega en BINARIO
org 0100h
jmp eti0
cad0 db "Deme un numero (a 3 cifras): $"
cad1 db "El numero en Binario es: $"
cad2 db 0dh,0ah,'$'
buffer db " "   ;Buffer para almacenar las 3 cifras
eti0:
mov ah,09h
lea dx,cad0
int 21h         ;Despliega cad0
mov cx,3        ;Ciclo de 3 vueltas (para preguntar 3 digitos)
lea bx,buffer   ;Direccion del buffer donde se almacenaran los 3 digitos
eti1:           ;Pregunta y almacenamiento de los números o digitos
mov ah,1
int 21h         ;INT 21h de la funcion 01h, pregunta por un caracter (se almacena en AL)
mov [bx],al     ;Almacena caracter en el BUFFER
inc bx
loop eti1
;***************************************************************************************
lea bx,buffer   ;Carga direccion inicial del BUFFER
mov al,[bx]     ;Almacena en AL el PRIMER valor o digito ASCII
sub al,30h      ;Se obtiene el valor numerico
mov ah,00h
mov cl,100d
mul cl          ;Obtiene Centenas en AX
push ax         ;Almacena Centenas
inc bx          ;BUFFER+1
mov al,[bx]     ;Almacena en AL el SEGUNDO valor o digito ASCII
sub al,30h
mov cl,10d
mul cl          ;Obtiene Decenas en AX
mov cx,ax       ;Se respalda en CX el valor de AX
pop ax          ;Se restaura el valor de AX de la PILA
add cx,ax       ;Suma Decenas + Centenas en CX
inc bx          ;BUFFER+2
mov al,[bx]     ;Almacena en AL el TERCER valor o digito ASCII
sub al,30h
mov ah,0
add cx,ax       ;En CX queda finalmente el valor numerico original de 3 digitos
mov bx,cx       ;Se respalda CX en BX
;***************************************************************************************
mov ah,09h
lea dx,cad2
int 21h         ;Despliega cad2
mov ah,09h
lea dx,cad1
int 21h         ;Despliega cad1
;***************************************************************************************
mov cx,16d      ;Se prepara ciclo de 16 vueltas, analisis de BITS y despliegue
eti3:
push bx
and bx,1000000000000000b ;Filtra con AND el contenido de BX con 8000H (1000000000000000b)
cmp bx,8000h
je uno
mov ah,02h
mov dl,'0'
int 21h         ;Se despliega el simbolo '0'
jmp eti2
uno:
mov ah,02h
mov dl,'1'
int 21h         ;Se despliega el simbolo '1'
eti2:
pop bx
rol bx,1
loop eti3
;***************************************************************************************
mov ah,07h
int 21h
int 20h