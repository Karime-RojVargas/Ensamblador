;Programa 7.- Programa que despliega 10 veces la cadena 'TECNO' (de forma vertical). Otra forma de hacerlo.
org 0100h
jmp eti0
cad0 db 'TECNO',0Dh,0Ah,'$'
eti0:
mov cx,0ah
mov ah,09h
lea dx,cad0
eti1:
int 21h             ;Despliega cad0 una vez
dec cx              ;Decrementa a CX en 1
cmp cx,0d           ;Compara si CX es 0 (cero). Se compara el Operando Destino respecto al Operando Fuente
jne eti1            ;Si la comparación se cumple (es verdadera), salta al destino (en este caso la etiqueta ETI1)
mov ah,07h
int 21h
int 20h