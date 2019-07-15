;Programa proyecto unidad 3
org 100h
jmp eti0

col dw 0
ren dw 479d
bot dw ?
c db ?
r db ?
color db 0d
area db 0

ponpix macro c r color;Macro que recibe dos paramentros
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
;Zona declaracion de Cadenas
cad db 'Error, archivo no encontrado'
filename db "C:\imagen.bmp" ;Unidad Logica, Ruta, Nombre y Extension del archivo de imagen a utilizar
handle dw ? ;DW=Define Word, para almacenar valores entre 0 y 65535, o sea 16 bits
buffer db ? ;DB=Define Byte, para almacenar valores entre 0 y 255, o sea 8 bits
colo db ? ; ? = Valor NO definido de inicio
;**************************************************************************************************
eti0:
mov ah,3dh
mov al,0
mov dx,offset filename
int 21h
;(Handle)
jc err
mov handle,ax
;*********************************************************************
mov cx,118d
eti1:
push cx
mov ah,3fh
mov bx,handle
mov dx,offset buffer
mov cx,1
int 21h
pop cx
loop eti1
;*********************************************************************
mov ah,00h
mov al,18d
int 10h
;*********************************************************************
eti2:
mov ah,3fh
mov bx,handle
mov dx,offset buffer
mov cx,1
int 21h
mov al,buffer
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
;******************************************************************************************
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
    
    call validarea       ;VALIDAMOS LA ZONA DONDE SE DA CLIC
    cmp area,1d          ;Salir
    je eti5 
    cmp area,2           ;Marron
    jne eti7 
    mov color,6d
    jmp eti8 
eti7:
    cmp area,3      ;3=Azul
    jne eti9
    mov color,9d
    jmp eti8
eti9:
    cmp area,4      ;4=Gris
    jne eti10
    mov color,7d
    jmp eti8
eti10:
    cmp area,5      ;5=Amarillo
    jne eti14
    mov color,14d
    jmp eti8 
eti14:
    cmp area,6
    jne eti17
    mov color,15d
    jmp eti8
eti17:
    cmp area,7
    jne eti8        
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
cmp col,321d
jb eti4
cmp col,365d
ja eti4
cmp ren,40d
jb eti4
cmp ren,67d
ja eti4
mov area,1d    ;1 igual a salir
ret

eti4:
    cmp col,435d
    jb eti6
    cmp col,516d
    ja eti6
    cmp ren,17d
    jb eti6
    cmp ren,45d
    ja eti6
    mov area,2d     ;igual a azul
    ret
     
     
eti6:
    cmp col,521d
    jb eti11
    cmp col,602d
    ja eti11
    cmp ren,17d
    jb eti11
    cmp ren,45d
    ja eti11
    mov area,3d     ;igual a rojo
    ret   

eti11:
    cmp col,435d
    jb eti12
    cmp col,516d
    ja eti12
    cmp ren,50d
    jb eti12
    cmp ren,77d
    ja eti12
    mov area,4d     ;igual a cafe
    ret 
    
eti12:
    cmp col,521d
    jb eti15
    cmp col,602d
    ja eti15
    cmp ren,50d
    jb eti15
    cmp ren,77d
    ja eti15
    mov area,5d     ;igual a cyan
    ret 
    
eti15:
    cmp col,271d
    jb eti16
    cmp col,293d
    ja eti16
    cmp ren,71d
    jb eti16
    cmp ren,96d
    ja eti16
    mov area,6d     ;igual a borrar
    ret 
    
eti16:
    cmp col,272d
    jb eti13
    cmp col,293d
    ja eti13
    cmp ren,42d
    jb eti13
    cmp ren,64d
    ja eti13        ;igual a brocha
    mov area,7d
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