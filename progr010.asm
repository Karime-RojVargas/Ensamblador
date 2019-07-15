;Programa 8.- Obtencion de una cadena con formato
org 0100h
jmp eti0
cad0 db "                    " ;Buffer de 20 espacios
eti0:
lea bx,cad0
eti1:
mov ah,01h
int 21h
mov [bx],al                     ;Almacenar en el buffer (cad0) el carácter obtenido en AL
inc bx
cmp al,'$'                      ;Se piden caracteres hasta que se da el símbolo de ‘$’
jne eti1
lea dx,cad0
mov ah,09h
int 21h                         ;Se despliega la cadena obtenida (cad0)
mov ah,07h
int 21h
int 20h