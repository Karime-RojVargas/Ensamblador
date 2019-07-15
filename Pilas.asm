org 0100h


jmp eti0
cad0 db 'Tecno',0ah,0dh,'$'
eti0:
mov dx,10d

eti1:
push dx
mov ah,09h 
lea dx,cad0
int 21h
pop dx
dec dx
cmp dx,0
jne eti1



int 20h