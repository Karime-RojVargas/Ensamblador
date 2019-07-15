org 0100h

jmp eti0
cad0 db 'Tecno$'
cad1 db 0dh,0ah,'$'
eti0:
mov cx,10d  
eti2:
push cx

mov ah,09h
lea dx,cad0
int 21h         ;Despliega cadena cad0

mov cx,40d
eti1:
    mov ah,02h
    mov dl,'$'
    int 21h
    loop eti1
    
mov ah,09h
lea dx,cad1
int 21h         ;Despliega ENTER (cad1)

pop cx
loop eti2

mov ah,07h
int 21h         ;Getch
int 20h    