;Programa 9.- Hace que el programa termine (validacion), si el raton se intenta ubicar en el cuadrante izquierdo inferior 
;de la pantalla 
org 0100h 
col dw ?
ren dw ? 
bot dw ? 
 
numero macro num  ;Macro para desplegar números (3 digitos)     
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
int 21h endm 
 
;Inicia Programa Principal 
mov ah,00h 
mov al,18d 
int 10h   
mov ax,4d ;Para la funcion 04H de la INT 33H 
mov cx,10d ;CX=Columna de encendido del raton (empieza en cero) 
mov dx,300d ;DX=Renglon de encendido del raton (empieza en cero) 
int 33h  ;INT 33H, funcion 04H, indicar la posicion de encendido del raton (ojo: no lo enciende, solo indica) 
mov ax,1d 
int 33h  ;INT 33H, funcion 01H, enciende el puntero del raton (en la posicion antes indicada) 
eti0:    
mov ax,3d    
int 33h    
mov col,cx    
mov ren,dx    
mov bot,bx    
call pos    
numero col    
mov ah,02h    
mov dl,' ' ;Almacena en DL un espacio en blanco    
int 21h ;Despliega un espacio en blanco    
numero ren    
cmp col,320d    
jae fin  ;JAE=Jump if Above or Equal (Brinca si esta arriba, o si es igual)    
cmp ren,239d    
jbe fin  ;JBE=Jump if Below or Equal (Salta si esta abajo, o si es Igual)
jmp eti0 
fin:  
mov ah,00h   
mov al,3d   
int 10h   
int 20h 
 
pos proc     
mov ah,02h     
mov dl,65d     
mov dh,1d     
mov bh,0d     
int 10h     
ret 
endp 