;Programa 4.- Despliega cadenas según el botón oprimido
org 0100h
c db 10d ;C es de tipo DB (Define Byte) y se inicializa con el valor 10 decimal
r db 10d
jmp eti0
cad1 db 'Boton Izq$'
cad2 db 'Boton Der$'
cad3 db 'Oprima los 2 botones para terminar...$'
eti0: ;Inicio del Programa Principal
mov ah,00h
mov al,18d
int 10h ;Inicializa graficos 640x480
mov ax,1d
int 33h ;Prende puntero del raton
mov ah,09h
lea dx,cad3
int 21h ;Despliega cadena CAD3
eti1: ;Ciclo Principal
mov ax,3d
int 33h ;Detecta coordenadas COL, REN y boton oprimido
cmp bx,0d
je eti1 ;Mientras NO se oprima ningun boton, salta a ETI1
cmp bx,1d
jne eti2 ;Si se oprime boton izquierdo NO salta a ETI2
call pos ;Llama al procedimiento POS
mov ah,09h
lea dx,cad1
int 21h ;Despliega cadena CAD1
jmp eti1 ;Brinca sin condicion a ETI1
eti2:
cmp bx,2d
jne fin ;Si se oprimen los 2 botones salta a FIN
call pos ;Llama al procedimiento POS
mov ah,09h
lea dx,cad2
int 21h ;Despliega cadena CAD2
jmp eti1 ;Brinca sin condicion a ETI1
fin:
mov ax,2d
int 33h ;Apaga puntero de raton
;mov ah,00h
;mov al,3d
mov ax,0003h
int 10h ;Retorna pantalla a modo texto 80x30 (80x25 segun resolucion)
int 20h ;FIN del Programa Principal
pos proc
mov ah,02h ;Funcion 2 de la INT 10h=posiciona el CURSOR
mov dl,c ;DL=Columna
mov dh,r ;DH=Renglon
mov bh,0d ;BH=Pagina de despliegue
int 10h
ret
endp