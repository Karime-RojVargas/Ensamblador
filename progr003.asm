;Programa 3.- Inicializa graficos, enciende el puntero y despliega en pantalla coordenadas de posicion
org 0100h
jmp eti1
numero macro num
mov ax,num
mov bl,100d
div bl
mov dl,al
add dl,30h
push ax
mov ah,02h
int 21h
pop ax
shr ax,8d
mov bl,10d
div bl
mov dl,al
add dl,30h
push ax
mov ah,02h
int 21h
pop ax
shr ax,8d
mov dl,al
add dl,30h
mov ah,02h
int 21h
endm ;Fin de la MACRO
col dw 0 ;Declaracion de identificadores tipo variable DW  cOLUMNA
ren dw 0                                                   ;RENGLON
bot dw 0                                                   ;bOTON
;Inicio del Programa Principal
eti1:
mov ah,00h
mov al,18d
int 10h ;Inicializa graficos
mov ax,1d
int 33h ;Enciende el Raton
eti0: ;Ciclo Principal
    mov ax,3d ;Para la funcion 03H de la INT 33H
    int 33h ;Llama a la INT 33H de la función 03H, devuelve en BX numero de boton oprimido, 0=Ningun Boton
    mov bot,bx ;1=Boton Izquierdo, 2=Boton Derecho, 3=Los 2 Botones; CX=Columna Actual, DX=Renglon
    mov col,cx ;Actual
    mov ren,dx
    call posC ;Llama al procedimiento POSC
    numero col ;Llama a la macro NUMERO enviando un dato en COL
    call posR
    numero ren
    cmp bot,0d ;Compara BOT con 2 (botón derecho)
    je eti0 ;Si se oprime el botón derecho el programa termina
mov ax,2d
int 33h ;Apaga el Raton
mov ah,00h
mov al,3d
int 10h ;Cierra graficos (devolver a modo Texto)
int 20h ;Fin del Programa
;Inicio de PROCEDIMIENTOS
posC proc
mov ah,02h ;Para la funcion 02H de la INT 10H
mov dl,65d ;DL=Columna donde se desea ubicar el cursor (empieza desde 0)
mov dh,29d ;DH=Renglon donde se desea ubicar el cursor (empieza desde 0)
mov bh,0h ;BH=Pagina de despliegue (la primera es la cero)
int 10h ;INT 10H de la función 02H, ubicar el cursor en la posición indicada (solo coordenadas 80x25)
ret
endp
posR proc
mov ah,02h
mov dl,70d ;Columna
mov dh,29d ;Renglon
mov bh,0h ;Pagina de despliegue
int 10h
ret
endp