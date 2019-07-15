;Programa 4.- Otra forma de pedir una cadena y desplegarla
org 100h 
mov dx,offset buffer 
mov ah,0ah 
int 21h 
jmp print                     
buffer db 10,?, 10 dup(' ')         ;Declaracion del buffer para almacenar una cadena de maximo 10 caracteres 
print: 
xor bx, bx                          ;Aplicacion de la compuerta logica XOR con el contenido de BX y BX 
mov bl, buffer[1]                   ;Almacena en BL la longitud de la cadena buffer 
mov buffer[bx+2], '$'               ;Almacena al final d ela cadena buffer el simbolo de ‘$’ 
mov dx, offset buffer + 2           ;DX=Direccion de la cadena buffer + 2 (primer caracter de la cadena) 
mov ah, 9 
int 21h                             ;INT 21H de la función 09, despliega cadena en pantalla 
ret