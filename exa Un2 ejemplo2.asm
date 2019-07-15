org 0100h

jmp eti0
cad0 db 'Deme numero (menor a 10): $'
cad1 db 'Tecno',0dh,0ah,'$'
cad2 db 0dh,0ah,'$'
eti0:
mov ah,09h
lea dx,cad0
int 21h

mov ah,01h
int 21h
cmp al,30h
je fin
cmp al,0dh
je fin
push ax

mov ah,09h
lea dx,cad2
int 21h  

pop ax
sub al,30

mov cl,al
mov ch,00h

eti1:
    mov ah,09h
    lea dx,cad1
    int 21h
    loop eti1

fin:
mov ah,07h
int 21h

int 20h