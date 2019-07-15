;Proyecto U3
org 100h 
jmp eti0
col dw 0
ren dw 479d
bot dw ? 
c db ?
r db ?
color db 0d  
area db 0
 
ponpix macro c r color ;Macro que recibe dos parámetros, en C y en R
mov ah,0Ch ;Funcion 12d=0Ch para pintar o desplegar PIXEL
mov al,color ;AL=Atributos de color, parte baja: 1010b=10d=Color Verde (vea Paleta de Color)
mov cx,c ;Cx=Columna donde se despliega PIXEL (empieza desde cero)
mov dx,r ;Dx=Renglon donde se despliega PIXEL (empieza desde cero)
int 10h ;INT 10H funcion 0CH, despliega PIXEL de color en posicion CX (Columna), DX (Renglon)
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
shr ax,8
mov bl,10d
div bl
mov dl,al
add dl,30h
push ax
mov ah,02h
int 21h
pop ax
shr ax,8
mov dl,al
add dl,30h
mov ah,02h
int 21h
endm 
;Zona de declaracion de Cadenas e Identificadores creados por el usuario (variables)
cad db 'Error, archivo no encontrado!...presione una tecla para terminar.$'
filename db "C:\imagen.bmp" ;Unidad Logica, Ruta, Nombre y Extension del archivo de imagen a utilizar
handle dw ? ;DW=Define Word, para almacenar valores entre 0 y 65535, o sea 16 bits
buffer db ? ;DB=Define Byte, para almacenar valores entre 0 y 255, o sea 8 bits
colo db ? ; ? = Valor NO definido de inicio
;**************************************************************************************************************************
eti0:
mov ah,3dh ;Funcion 3DH, abre un archivo existente
mov al,0 ;AL=Modos de Acceso, 0=Solo Lectura, 1=Escritura, 2=Lectura/Escritura
mov dx,offset filename ;DX=Direccion de la cadena de RUTA
int 21h ;INT 21H función 3DH, abre un archivo. Esta funcion altera la bandera CF (Carry ;Flag), si el archivo se pudo abrir sin error CF=0, y en AX esta el Manejador de Archivo
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
mov colo,al ;COLO=Color de un PRIMER Pixel
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,colo ;AL=Atributos del Pixel
mov cx,col ;CX=Columna de despliegue del Pixel
mov dx,ren ;DX=Renglon de desplieguie del Pixel
int 10h ;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
mov al,buffer ;AL=BUFFER, en los 4 bits inferiores esta el color de un SEGUNDO Pixel
and al,00001111b
mov colo,al ;COLO=Color de un SEGUNDO Pixel
inc col
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,colo ;AL=Atributos del Pixel
mov cx,col ;CX=Columna de despliegue del Pixel
mov dx,ren ;DX=Renglon de desplieguie del Pixel
int 10h ;INT 10H funcion 0CH, pinta Pixel en coordenadas CX, DX
inc col ;Se debe desplegar otro Pixel para dar FORMATO a la imagen
mov ah,0ch ;Funcion 0CH para despliegue de un solo PIXEL con atributos
mov al,colo ;AL=Atributos del Pixel
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
call prende

eti3:
mov ax,3d
int 33h
mov col,cx
mov ren,dx
mov bot,bx
mov c,4d
mov r,1d        ;   A QUE E USUARIO OPRIMA EL BOTON IZQUIERDO
call pos
numero col
mov ah,02h
mov dl,' ' ;Mover a DL un espacio en blanco
int 21h
numero ren
cmp bot,1d                                       ;29
jne eti3

call validarea                 ;VALIDAMOS LA ZONA DONDE SE DIÓ CLIC
cmp area,1d          ;Salir
je eti5 
cmp area,2           ;Azul
jne eti7 
mov color,1
jmp eti8
    
eti7:
cmp area,3           ;Azul
jne eti9 
mov color,4
jmp eti8

eti9:
cmp area,4           ;Azul
jne eti10 
mov color,6
jmp eti8

eti10:
cmp area,5           ;Azul
jne eti8 
mov color,11    
        
eti8:        
     call apaga
     ponpix col ren color
     call prende
     jmp eti3 
     
eti5:
call apaga
mov ah,00h ;Funcion 00H para devolver al modo TEXTO
mov al,3d ;AL=Modo de despliegue o resolución, 3 = 80x25 a 16 colores (Modo TEXTO)
int 10h ;INT 10H funcion 00H, inicializar resolucion
int 20h ;Fin del Programa (Cuando se carga la imagen)
;***********************************************************************************************************************
err: ;Se llega hasta aqui solo si hay error en la lectura del archivo
mov ah,09h
lea dx,cad
int 21h ;Despliega cad
mov ah,07h
int 21h ;Espera a que se oprima tecla
int 20h ;Fin del Programa (Cuando NO se carga la imagen)           

;INICIA ZONA DE PROCEDIMIENTO  
proc validarea
cmp col,320d
jb eti4
cmp col,366d
ja eti4
cmp ren,40d
jb eti4
cmp ren,66d
ja eti4
mov area,1d    ;1 igual a salir
ret

eti4:

cmp col,434d
jb eti6
cmp col,516d
ja eti6
cmp ren,16d
jb eti6
cmp ren,45d
ja eti6
mov area,2d     ;igual a azul
ret
     
     
eti6:
cmp col,510d
jb eti11
cmp col,621d
ja eti11
cmp ren,14d
jb eti11
cmp ren,61d
ja eti11
mov area,3d     ;igual a rojo
ret   

eti11:
cmp col,398d
jb eti12
cmp col,509d
ja eti12
cmp ren,61d
jb eti12
cmp ren,109d
ja eti12
mov area,4d     ;igual a cafe
ret
eti12:

cmp col,510d
jb eti13
cmp col,621d
ja eti13
cmp ren,61d
jb eti13
cmp ren,109d
ja eti13
mov area,5d     ;igual a cyan
ret
eti13:

   
    ret
endp  



proc prende
    mov ax,1d
    int 33h
ret
endp
proc apaga
    mov ax,2d
    int 33h
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