;Programa 1.- Despliega un numero en pantalla (3 digitos) utilizando una MACRO
org 0100h
valor dw 0          ;Declaración de un identificador tipo variable (“valor”) de tamaño palabra (DW=Define Word)
;Una MACRO debe ir ANTES del codigo que la manda llamar
numero macro num    ;Declaracion de la macro NUMERO con un dato de parametro (NUM)
mov ax,num
mov bl,100d
div bl
mov dl,al
add dl,30h
push ax
mov ah,02h
int 21h
pop ax
shr ax,8
mov bl,10d
div bl
mov dl,al
add dl,30h
push ax
mov ah,02h
int 21h
pop ax
shr ax,8
mov dl,al
add dl,30h
mov ah,02h
int 21h
endm                ;Fin de la Macro

;Inicio del Programa
mov valor,999d
numero valor        ;Llamada a la macro NUMERO enviando el dato en VALOR
mov ah,07h
int 21h
int 20h