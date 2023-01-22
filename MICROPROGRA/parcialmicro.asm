;MICROPROGRAMACION
include mip115.lib  ;libreria para comodidad en este programa
cpila 100h ;funcion para inicializar el segmento de pila con 100h (256) de espacio

datos SEGMENT  ;comienza segmento de datos         
  ;variables a usar con los datos personales y colores
  nombre db 'UES$'   
  nombre2 db " FMO$"  
  piel db 01100000b,"$"  ;colores para mario
  pelo db 00110000b,"$"
  gorra db 11000000b,"$"
  blanc db 11111111b,"$" ;colores para el hongo
  gris db  01011101b,"$" 
  
  ;variables para funcion mostrar menu
  
  opciones db "opciines","$"
  a db "A-VER CPU","$"
  b db "B-VER RAM","$"
  c db "C-ABOUT ME","$" 
  respuesta db 2 dup(''),'$'
  long db 2
    
datos ENDS ;termina el segmento de datos

codigo SEGMENT;comienza el segmento de codigo
    
    assume CS:codigo,DS:datos,SS:PILA  ;se asumen los segmentos de datos codigo y pila antes definidos 
principal proc ;inicia el proceso principal
    iniseg ;inicializa los segmentos
     xycursor 0,19  ;mueve el cursor para que quede en el centro del hongo
     ; enla posicion actual del cursor 
      ;limpia la pantalla  
    xycursor 0,19  ;mueve el cursor para que quede en el centro del hongo
    call HONGO  ;llama el proceso de dibujar el hongo 
    esperar 
     
    
    
    call MENU  
    call opcMenu
    ret
    esperar
    xycursor 0,19  ;cambia la posicion del cursor 
    fin ;funcion para finalizar el programa 
principal endp   ;fin del proceso principal 
;FUNCION PARA DIBUJAR AL HONGO
HONGO PROC NEAR ;inicia el proceso de dibujar al hongo  
    ;se usa la funcion bloque para imprimir bloques de 2x2 con el mismo color 
    
    ;linea1   
    ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
  
    

    ;linea2 
  
    ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 2,3,2,3,gris
    bloque 4,6,2,3,blanc
    bloque 6,9,2,3,gris
    bloque 8,12,2,3,blanc
    bloque 10,13,2,3,gris
    bloque 12,15,2,3,blanc
    bloque 14,17,2,3,gris 
    ;linee 3 
    ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 0,1,4,5,gris
    bloque 2,3,4,5,gris
    bloque 4,6,4,5,blanc
    bloque 6,9,4,5,gris
    bloque 8,12,4,5,blanc
    bloque 10,13,4,5,gris
    bloque 12,15,4,5,blanc
    bloque 14,17,4,5,gris
    ;linea 4
    bloque 0,1,6,7,blanc
    bloque 2,3,6,7,gris
    bloque 4,6,6,7,gris
    bloque 6,9,6,7,gris
    bloque 8,12,6,7,gris
    bloque 10,13,6,7,gris
    bloque 12,15,6,7,gris
    bloque 14,17,6,7,blanc 
    ;linea 5 
    
    bloque 0,1,8,9,gris
    bloque 2,3,8,9,gris
    bloque 4,6,8,9,gris
    bloque 6,9,8,9,gris
    bloque 8,12,8,9,gris
    bloque 10,13,8,9,gris
    bloque 12,15,8,9,gris
    bloque 14,17,8,9,gris
    ;linea 6 
     bloque 0,1,10,11,blanc
    bloque 2,3,10,11,gris
    bloque 4,6,10,11,gris
    bloque 6,9,10,11,gris
    bloque 8,12,10,11,gris
    bloque 10,13,10,11,gris
    bloque 12,15,10,11,gris
    bloque 14,17,10,11,blanc 
    ;linea 7 
    bloque 0,1,12,13,gris
    bloque 2,3,12,13,gris
    bloque 4,6,12,13,gris
    bloque 6,9,12,13,gris
    bloque 8,12,12,13,gris
    bloque 10,13,12,13,gris
    bloque 12,15,12,13,gris
    bloque 14,17,12,13,gris
    ;linea 8
    bloque 0,1,14,15,blanc
    bloque 2,3,14,15,gris
    bloque 4,6,14,15,gris
    bloque 6,9,14,15,gris
    bloque 8,12,14,15,gris
    bloque 10,13,14,15,gris
    bloque 12,15,14,15,gris
    bloque 14,17,14,15,blanc
    ;linea 9
    bloque 0,1,16,17,gris
    bloque 2,3,16,17,gris
    bloque 4,6,16,17,blanc
    bloque 6,9,16,17,gris
    bloque 8,12,16,17,blanc
    bloque 10,13,16,17,gris
    bloque 12,15,16,17,blanc
    bloque 14,17,16,17,gris 
    ;linea 10
    bloque 0,1,18,19,gris
    bloque 2,3,18,19,gris
    bloque 4,6,18,19,blanc
    bloque 6,9,18,19,gris
    bloque 8,12,18,19,blanc
    bloque 10,13,18,19,gris
    bloque 12,15,18,19,blanc
    bloque 14,17,18,19,gris 
    ;linea 10
    
    
  

     
                        
                        
    
    
    
  
  
   
    esperar          ;se usa esperar para que tenga que presionar enter para continuar
    ret ;se usa ret a modo de break 
HONGO ENDP ;finaliza el proceso de dibujar al hongo
;FUNCION PARA DIBUJAR A MARIO

   opcMenu proc near 
    
    xycursor 20,6
     
 mov ah, 09h
mov dx, offset opciones
int 21h


   
    
   opcMenu endp  

  MENU PROC NEAR 
   
    mov ax,0600h
    mov bh,31h
    mov cx,0514h
    mov dx,143ch
    int 10h 
    ret
  
    MENU ENDP

 


codigo ends ;finaliza el segmento de codigo
end principal  ;finaliza el proceso principal