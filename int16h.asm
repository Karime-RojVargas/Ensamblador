org 0100h
   ;AX = 4800h FLECHA ARRIBA , 5000h Flecha abajo  4b00h flecha izquierda, 4d00h flecha derecha
jmp eti0
izq db 'IZQUIERDA$'
der db 'DERECHA$'
arr db 'ARRIBA$'
aba db 'ABAJO$'

eti0:
  mov ah,02h
  mov dl,'.'
  int 21h
  
  mov ah,01h
  int 16h             ;Deteccion de las teclas, buffer del teclado
  jz eti0             ;Si BUFFER vacio, entonces ZF=0
  
  mov bx,ax           ;Hacer una copia de ax en bx
  
  mov ah,07h          ;Saca lo que está en el buffer del teclado
  int 21h
  
  
  
  
  cmp bl,1bh          ;1bh = ESC    Compara si lo que oprimiste es ESC
  je fin   
  
  cmp bx,4800h        ;Compara si lo que oprimiste es la flecha hacía arriba
  je arriba
  
  cmp bx,5000h
  je abajo
  
  cmp bx,4b00h
  je izqui
  
  cmp bx,4d00h
  je dere
  
  jmp eti0
  
arriba:
     mov ah,09h
     lea dx,arr
     int 21h
     jmp eti0
     
abajo:
     mov ah,09h
     lea dx,aba
     int 21h
     jmp eti0

izqui:
     mov ah,09h
     lea dx,izq
     int 21h
     jmp eti0
     
dere:
     mov ah,09h
     lea dx,der
     int 21h
     jmp eti0
     
     

fin:    
int 20h