;Programa 2.- Inicializa graficos (640x480) y enciende puntero de raton usando PROCEDIMIENTOS
org 0100h
call inigraf        ;CALL=Llamada al procedimiento INIGRAF
call prende
call pausa
call apaga
call pausa
call prende
call pausa
call apaga
call cierragraf
int 20h
;Inicio de declaracion de PROCEDIMIENTOS
inigraf proc        ;Declaracion del Procedimiento
mov ah,00h          ;Para la funcion 00H de la INT 10h
mov al,18d          ;AL=numero de resolucion (18=640x480 pixeles a 16 colores)
int 10h             ;Llamada a la funcion 00H de la INT 10H, inicializa modo de despliegue
ret                 ;RET=Return, algunos procedimientos retornan valores
endp                ;Fin del Procedimiento
cierragraf proc
mov ah,00h
mov al,3d           ;3=80x25 a 16 colores (Modo Texto MSDOS)
int 10h
ret
endp
prende proc
mov ax,1d           ;Para la funcion 01h de la INT 33H
int 33h             ;Funcion 01H de la INT 33H, enciende puntero del raton
ret
endp
apaga proc
mov ax,2d           ;Para la funcion 02h de la INT 33H
int 33h             ;Funcion 02H de la INT 33H, apaga puntero del raton
ret
endp
pausa proc
mov ah,07h
int 21h
ret
endp