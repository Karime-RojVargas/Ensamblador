org 0100h

jmp eti0
cad0 db 'Teclee Password: $'
cad1 db 0dh,0ah,'$'
cad2 db 'Su password es: $'
buf db "                              "
eti0:
mov ah,09h
lea dx,cad0
int 21h                         ;Despliega cad0

lea bx,buf                      ;Almacena la dirección inicial del buffer
eti1:
mov ah,07h
int 21h
mov [bx],al
inc bx
cmp al,13d
je eti3
mov ah,02h
mov dl,'*'
int 21h
jmp eti1 

eti3:
mov ah,09h
lea dx,cad1
int 21h 

mov ah,09h
lea dx,cad2
int 21h

lea bx,buf
eti2:
mov dl,[bx]
mov ah,02h
int 21h
inc bx
cmp dl,13d
jne eti2


int 20h