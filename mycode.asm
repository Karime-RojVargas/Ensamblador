;Programa que invierte una cadena
org 0100h
jmp eti0       
;Cadenas a usar
cad0 db "Inserta una cadena a invertir:$"   
cad1 db 0dh,0ah,'$'
cad2 db "Cadena invertida:$" 
eti0:
mov ah,09h      ;Despliega cad0
lea dx,cad0
int 21h
mov cx,35d      ;Prepara el registro contador para un ciclo
mov dx,0d       ;Uso dx para contar los caracteres ingresados
eti1:
mov ah,01h      ;Funcion 01h de la int 21 que pide un caracter mostrandolo en pantalla
int 21h
cmp al,0dh      ;Compara si el caracter introducido no es el enter
je eti2         ;Si es el enter se va a eti2 y sale del ciclo
mov bx,ax       ;movemos ax a bx para recuperar el ascii de la tecla presionada que esta en al
push bx         ;Guardamos el ascii en la pila   
inc dx          ;Se incrementa dx
loop eti1       ;Cicla para pedir otro caracter

eti2:           
push dx         ;Guardamos en pila el numero de caracteres
mov ah,09h      ;Desplegamos la cadena para saltar linea
lea dx,cad1
int 21h
mov ah,09h      ;Desplegamos cad2
lea dx,cad2
int 21h
pop dx          ;Recuperamos el numero de caracteres
mov cx,dx       ;Volvemos a iniciar el contador del ciclo esta vez con el num de caracteres ingresados 

eti3:           
pop bx          ;Sacamos el primer ascii de la pila que es el ultimo que ingresamos
mov ah,02h      ;Funcion 02h de la int 21h que despliega caracter en pantalla
mov dl,bl       ;Movemos el ascii a dl para que se despliegue
int 21h         
loop eti3       ;Ciclo para desplegar todos los caracteres de la pila
mov ah,07h      ;getch
int 21h
int 20h         ;fin