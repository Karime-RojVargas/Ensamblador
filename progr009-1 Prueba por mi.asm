org 0100h

jmp eti0
cad0 db 'Tecno$'
cad1 db 0dh,0ah,'$'
eti0:

mov bx,10d 

eti2:
mov ah,09h
lea dx,cad0
int 21h                 ;Despiega cadena cad0

mov cx,40d
mov dl,'$'
int 21h                 ;ciclo de la primera
loop eti1

mov ah,09h
lea dx cad1             ;Enter
int 21h

dec bx
cmp bx,0                ;Ciclo para hacer lo mismo 10 veces
jne eti2

mov ah,07h               ;Getch
int 21h

int 20h