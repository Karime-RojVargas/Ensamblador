;Programa 6.- Programa que despliega 10 veces la cadena 'TECNO' (de forma vertical)
org 0100h
jmp eti0
cad0 db 'TECNO',0Dh,0Ah,'$'
eti0:
mov cx,10d
eti1:
mov ah,09h
lea dx,cad0
int 21h                     ;Despliega cad0 una vez
loop eti1                   ;LOOP=Espiral. Decrementa a CX, si CX=0, continua con la siguiente instruccion, caso
;contrario, salta al destino (en este caso la etiqueta ETI1)
mov ah,07h
int 21h
int 20h