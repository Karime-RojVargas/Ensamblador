;Programa 5.1.- Pide y Compara 2 cadenas, y dice si son iguales o no
org 0100h
cld                             ;CLD es para limpiar la Bandera de Direccion DF
jmp eti0
cad0 db 10,?,'          '       ;10 espacios en blanco
cad1 db 10,?,10 dup(' ')        ;10 espacios en blanco
cad2 db 'Deme cadena: $'
cad3 db 0Dh,0Ah,'$'
cad4 db 'SI son Iguales!$'
cad5 db 'NO son iguales!$'
eti0:
mov ah,09h
lea dx,cad2
int 21h                         ;Despliega CAD2
mov ah,0ah
lea dx,cad0
int 21h                         ;Pregunta y almacena la Primer cadena (CAD0)
mov ah,09h
lea dx,cad3
int 21h                         ;Despliega CAD3 (Retorno y Salto de linea)
mov ah,09h
lea dx,cad2
int 21h                         ;Despliega CAD2
mov ah,0ah
lea dx,cad1
int 21h                         ;Pregunta y almacena la Segunda cadena (CAD1)
mov ah,09h
lea dx,cad3
int 21h                         ;Despliega CAD3 (Retorno y Salto de linea)
lea si,cad0                     ;SI = La direccion inicial de la PRIMERA cadena
lea di,cad1                     ;DI = La direccion inicial de la SEGUNDA cadena
mov cx,11d                       ;CX = Cantidad de caracteres a comparar (longitud de cadenas)
repe cmpsb                      ;Repite la comparación hasta que CX sea igual a 0, o se encuentre una diferencia (SI, DI)
jnz eti1                        ;Salta a ETI1 si la bandera de Zero (ZF) es diferente de cero (o sea ZF=1)
;Si son Iguales aqui sigue el programa
mov ah,09h
lea dx,cad4
int 21h                         ;Despliega CAD4 (Cadena Iguales)
jmp fin                         ;Brinca al fin del programa
eti1:                           ;No son Iguales
mov ah,09h
lea dx,cad5
int 21h                         ;Despliega CAD5 (Cadenas Diferentes)
fin:
mov ah,07h
int 21h                         ;INT 21H funcion 07H, espera que se oprima tecla
int 20h