org 0100h

jmp eti0
cad0 db 'Deme cadena: $'
cad1 db 0ah,0dh,'$'
cad2 db 'La longitud es: $'
buff db 10,?,10 dup(' ') 
eti0:
mov ah,09h
lea dx,cad0
int 21h            ;Despliega deme cadena

mov ah,0ah
lea dx,buff 
int 21h            ;Pide la cadena

mov ah,09h
lea dx,cad1
int 21h            ;Salto de linea

mov ah,09h
lea dx,cad2
int 21h            ;Despliega la longitud es:

lea bx,buff+1      ;Pide el espacio donde tiene la longitud de la cadena
mov dl,[bx]        ;Se guarda la longitud de la cadena en dl

add dl,30h         ;Añade 30 para obtener el ascii del número
mov ah,02h
int 21h            ;Se despliega el número

mov ah,07h
int 21h            ;Getch

int 20h