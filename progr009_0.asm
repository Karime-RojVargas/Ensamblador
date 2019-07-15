org 0100h

jmp eti0
cad0 db 'Deme numero: $'
cad1 db 'La suma es: $'
cad2 db 0dh,0ah,'$'

eti0:
mov ah,09h
lea dx,cad0
int 21h

mov ah,01h
int 21h

mov bl,al       ;BL = ASCII del primer numero

mov ah,09h
lea dx,cad2
int 21h

mov ah,09h
lea dx,cad0
int 21h

mov ah,01h
int 21h     ;AL = ASCII del segundo numero

sub bl,30h
sub al,30h
add al,bl
add al,30h
push ax

mov ah,09h
lea dx,cad2
int 21h

mov ah,09h
lea dx,cad1
int 21h  
        
pop ax        
mov dl,al
mov ah,02h
int 21h         
           
int 20h           