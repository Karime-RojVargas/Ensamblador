org 0100h

jmp eti0
cad0 db '        Hugo',0dh,0ah,'$'
cad1 db '    Hugo',0dh,0ah,'$'
cad2 db 'Hugo',0dh,0ah,'$'
cad3 db 'Paco',0ah,'$'
cad4 db 'Luis$' 
cad5 db 0dh,'$'
eti0:
mov ah,09h
lea dx,cad0
int 21h

mov ah,09h
lea dx,cad1
int 21h

mov ah,09h
lea dx,cad2
int 21h

mov cx,4
eti1:
    mov ah,09h
    lea dx,cad3
    int 21h
    loop eti1

mov ah,09h
lea dx,cad5
int 21h
    
mov cx,5
eti2:
    mov ah,09h
    lea dx,cad4
    int 21h
    loop eti2



mov ah,07h
int 21h

int 20h