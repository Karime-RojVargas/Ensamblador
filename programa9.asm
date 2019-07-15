;Programa 9.- Despliega un numero de 3 digitos en pantalla
org 0100h
mov ax,999d     ;Poner en AX la cantidad que se desea desplegar (0-9)
mov bl,100d     ;Poner en BL el divisor
div bl          ;Se llama a la instruccion de division, y queda en AH = 99d, y en AL =
mov dl,al       ;DL = 09h
add dl,30h      ;DL = 39h (se suma para obtener el valor ASCII)
push ax         ;Se guarda en la pila de AX el valor de 6309h
mov ah,02h
int 21h         ;Se despliega en pantalla el primer simbolo "9"
pop ax          ;Se recupera el valor de AX, o sea 6309h
shr ax,8        ;SHR = Shift Right, rotar a la derecha, quedando AX
mov bl,10d      ;En BL debe estar el divisor de decenas
div bl          ;AH = 09, AL = 09
mov dl,al       ;Pasar a DL el numero 09h
add dl, 30h     ;Calcular el ASCII en DL  
push ax         ;Guarda en la pila AX, osea 0909h
mov ah,02h
int 21h         ;Se despliega en segundo "9"
pop ax          ;Recuperamos el valor de AX, osea 0909h
shr ax,8        ;AX = 0009h
mov dl,al
add dl,30h
mov ah,02h
int 21h         ;Se despliega el tercer "9"
mov ah,07h      
int 21h
int 20h