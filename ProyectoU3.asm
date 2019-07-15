;Proyecto Unidad 3
org 0100h
jmp eti0

col dw 0 
ren dw 479 
bot dw 0
c db ?
r db ?   

ponpix macro c r color
mov ah,0Ch
mov al,color
mov cx,c
mov dx,r
int 10h
endm

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




;Zona de declaracion de Cadenas e Identificadores creados por el usuario (variables)
cad db 'Error, archivo no encontrado!...presione una tecla para terminar.$'
filename db "C:\imagen.bmp" ;Unidad Logica, Ruta, Nombre y Extension del archivo de imagen a utilizar
cadd db 'SALIR$'
handle dw ? ;DW=Define Word, para almacenar valores entre 0 y 65535, o sea 16 bits
est dw ?
her dw ?
buffer db ? ;DB=Define Byte, para almacenar valores entre 0 y 255, o sea 8 bits
color db ? ; ? = Valor NO definido de inicio
ciclo db ?
col1 dw ?
ren1 dw ?
col2 dw ?
ren2 dw ?


;**************************************************************************************************************************
eti0:
mov ah,3dh ;Funcion 3DH, abre un archivo existente
mov al,0 ;AL=Modos de Acceso, 0=Solo Lectura, 1=Escritura, 2=Lectura/Escritura
mov dx,offset filename ;DX=Direccion de la cadena de RUTA
int 21h ;INT 21H función 3DH, abre un archivo. Esta funcion altera la bandera CF (Carry
;Flag), si el archivo se pudo abrir sin error CF=0, y en AX esta el Manejador de Archivo
;(Handle), caso contrario CF=1, y en AX esta el codigo de error
jc err ;Si hay error, salta a la etiqueta ERR
mov handle,ax ;Caso contrario HANDLE=Manejador de Archivo
;*************************************************************************************************************************
mov cx,118d ;Se prepara ciclo de 118 vueltas (Para leer archivo en formato BMP)
eti1:
push cx
mov ah,3fh ;3FH=Leer del archivo
mov bx,handle
mov dx,offset buffer
mov cx,1 ;CX=Numero de Bytes a leer
int 21h ;INT 21H funcion 3FH, leer del archivo
pop cx
loop eti1
;*************************************************************************************************************************
mov ah,00h ;Funcion 00H para la INT 10H (Resolucion de Pantalla)
mov al,18d ;AL=Modo de despliegue o resolución, 18 = 640x480 a 16 colores
int 10h ;INT 10H funcion 00H, inicializar resolucion
;***********************************************************************************************************************
eti2:
mov ah,3fh ;3FH=Leer del archivo
mov bx,handle
mov dx,offset buffer
mov cx,1
int 21h ;INT 21H funcion 3FH, leer del archivo. En BUFFER se almacenaran los datos leidos

mov al,buffer ;AL=BUFFER, en los 4 bits superiores esta el color de un PRIMER Pixel
and al,11110000b
ror al,4
mov color,al ;COLO=Color de un PRIMER Pixel
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,color ;AL=Atributos del Pixel
mov cx,col ;CX=Columna de despliegue del Pixel
mov dx,ren ;DX=Renglon de desplieguie del Pixel
int 10h ;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX

mov al,buffer ;AL=BUFFER, en los 4 bits inferiores esta el color de un SEGUNDO Pixel
and al,00001111b
mov color,al ;COLO=Color de un SEGUNDO Pixel
inc col
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,color ;AL=Atributos del Pixel
mov cx,col ;CX=Columna de despliegue del Pixel
mov dx,ren ;DX=Renglon de desplieguie del Pixel
int 10h ;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
inc col ;Se debe desplegar otro Pixel para dar FORMATO a la imagen
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,color ;AL=Atributos del Pixel
mov cx,col ;CX=Columna de despliegue del Pixel
mov dx,ren ;DX=Renglon de desplieguie del Pixel
int 10h ;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX

cmp col,639d
jbe eti2 ;JBE=Jump if Below or Equal (salta si esta abajo o si es igual)

mov col,0
dec ren
cmp ren,-1 ;Se compara con -1 para llegar hasta el ultimo renglon, que es el CERO
jne eti2 JNE=Jump if Not Equal (salta si no es igual)
;***********************************************************************************************************************
mov ax,1d
mov color,0000b
int 33h ;Enciende el Raton
eti3: ;Ciclo Principal
mov ax,3d ;Para la funcion 03H de la INT 33H
int 33h ;Llama a la INT 33H de la función 03H, devuelve en BX numero de boton oprimido, 0=Ningun Boton
mov bot,bx ;1=Boton Izquierdo, 2=Boton Derecho, 3=Los 2 Botones; CX=Columna Actual, DX=Renglon
mov col,cx ;Actual
mov ren,dx
call posC ;Llama al procedimiento POSC
numero col ;Llama a la macro NUMERO enviando un dato en COL
call posR
numero ren
cmp bot,1d ;Compara BOT con 1 (botón derecho)
je click
cmp bot, 3d
jne eti3 ;Si se oprime el botón derecho el programa termina
mov ax,2d
int 33h ;Apaga el Raton
mov ah,00h
mov al,3d
int 10h ;Cierra graficos (devolver a modo Texto)
mov ah,07h
int 21h ;Espera que se oprima una tecla
int 20h ;Fin del Programa (Cuando se carga la imagen)

;***********************************************************************************************************************
err: ;Se llega hasta aqui solo si hay error en la lectura del archivo
mov ah,09h
lea dx,cad
int 21h ;Despliega cad
mov ah,07h
int 21h ;Espera a que se oprima tecla
int 20h ;Fin del Programa (Cuando NO se carga la imagen)
;***********************************************************************************************************************

click:
call comp1
call comp2
cmp est,1d
jne eti3
cmp her,1d
je pencil
cmp her,2d
je eraser
cmp her,3d
je square
cmp her,4d
je tool1
cmp her,5d
je sali
pencil:
call lapiz
jmp eti3
eraser:
call goma
jmp eti3
square:
call cuadro
jmp eti3
tool1:
call brocha
jmp eti3 
sali:
call exit
jmp eti3




;Procedimietos
posC proc
mov ah,02h ;Para la funcion 02H de la INT 10H
mov dl,70d ;DL=Columna donde se desea ubicar el cursor (empieza desde 0)
mov dh,29d ;DH=Renglon donde se desea ubicar el cursor (empieza desde 0)
mov bh,0h ;BH=Pagina de despliegue (la primera es la cero)
int 10h ;INT 10H de la función 02H, ubicar el cursor en la posición indicada (solo coordenadas 80x25)
ret
endp
posR proc
mov ah,02h
mov dl,75d 
mov dh,29d 
mov bh,0h 
int 10h
ret
endp
pos proc
mov ah,02h
mov dl,c
mov dh,r
mov bh,0d
int 10h
ret
endp
prende proc
mov ax,1d
int 33h
ret
endp
apaga proc
mov ax,2d
int 33h
ret
endp

exit proc
mov ah,00h 
mov al,3d 
int 10h 
int 20h

lapiz proc
mov ax,3d
int 33h
mov col,cx
mov ren,dx
call apaga
ponpix col ren color
call prende
ret
endp

goma proc
mov ax,3d
int 33h
mov color,15d
mov col,cx
mov ren,dx
mov ciclo, 30d

brocha proc
mov ax,3d
int 33h
mov col,cx
mov ren,dx
mov ciclo, 30d
ponpix col ren color



call apaga
looop:
lop:
ponpix col ren color
inc col
add ciclo, -1d
cmp ciclo, 0d
jne lop
call prende
ret
endp


cuadro proc
eti11:
mov ax,3d
int 33h
cmp bx,1d
jne eti11;Este ciclo (ETI0)solo termina si se oprimeel botón Izquierdo
mov col1,cx
mov ren1,dx
eti12:
mov ax,3d
int 33h
cmp bx,2d
jne eti12;Este ciclo (ETI1)solo termina si se oprimeel botón Derecho
mov col2,cx
mov ren2,dx
call apaga
cuad:
mov cx,col1
mov dx,ren1
eti22:
;Inicia proceso para dibujar linea superior horizontal
ponpix cx dx color
inc cx
cmp cx,col2
jbe eti22;JBE=Jump if Below or Equal(Salta si esta abajo, o si es Igual)
mov cx,col1
mov dx,ren2
eti33:;Inicia proceso para dibujar linea inferiorhorizontal
ponpix cx dx color
inc cx
cmp cx,col2
jbe eti33
mov cx,col1
mov dx,ren1
eti44:;Inicia proceso para dibujar linea izquierda vertical
ponpix cx dx color
inc dx
cmp dx,ren2
jbe eti44
mov cx,col2
mov dx,ren1
eti55:;Inicia proceso para dibujar linea derecha vertical
ponpix cx dx color
inc dx
cmp dx,ren2
jbe eti55
call prende
ret
endp


comp1 proc
cmp col,322d
jb prue
cmp col,365d
ja prue
cmp ren,41d
jb prue
cmp ren,65d
ja prue
mov her,5d    ;Salir
ret
endp

prue:
cmp col,225d
jb pen
cmp col,248d
ja pen
cmp ren,42d
jb pen
cmp ren,64d
ja pen
mov her,1d    ;Lapiz
ret
endp

pen:
cmp col,271d
jb ers
cmp col,293d
ja ers
cmp ren,71d
jb ers
cmp ren,96d
ja ers
mov her, 2d
mov color, 15d  ;Goma
ret
endp

ers:
cmp col,435d
jb gr
cmp col,516d
ja gr
cmp ren,17d
jb gr
cmp ren,45d
ja gr
mov color,6d    ;Marron
ret
endp 

gr:
cmp col,521d
jb rd
cmp col,602d
ja rd
cmp ren,17d
jb rd
cmp ren,45d
ja rd
mov color,1d    ;Azul
ret
endp

rd:
cmp col,435d
jb be
cmp col,516d
ja be
cmp ren,50d
jb be
cmp ren,77d
ja be
mov color,7d       ;Gris
ret
endp

be:
cmp col,521d
jb cyn
cmp col,602d
ja cyn
cmp ren,50d
jb cyn
cmp ren,77d
ja cyn
mov color,14d      ;Amarillo
ret
endp

cyn:
cmp col,227d
jb errr
cmp col,250d
ja errr
cmp ren,79d
jb errr
cmp ren,90d
ja errr
mov her,3d     ;cuadro

errr:
cmp col,272d
jb br
cmp col,293d
ja br
cmp ren,42d
jb br
cmp ren,64d
ja br
mov her, 4d
mov color,0d     ;brocha 

br:
mov est,0
ret
endp

comp2 proc
cmp col,159d
jb zn
cmp col,639d
ja zn
cmp ren,35d
jb zn
cmp ren,479d
ja zn
mov est,1d
ret
endp
zn:
mov est,0d
ret
endp