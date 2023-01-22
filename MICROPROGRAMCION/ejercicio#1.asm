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
    
datos ENDS ;termina el segmento de datos

codigo SEGMENT;comienza el segmento de codigo
    
    assume CS:codigo,DS:datos,SS:PILA  ;se asumen los segmentos de datos codigo y pila antes definidos 
principal proc ;inicia el proceso principal
    iniseg ;inicializa los segmentos
     xycursor 0,19  ;mueve el cursor para que quede en el centro del hongo
     ; enla posicion actual del cursor 
     call Dibujo
    esperar
    ClearS    ;limpia la pantalla  
    xycursor 0,19  ;mueve el cursor para que quede en el centro del hongo
    call HONGO  ;llama el proceso de dibujar el hongo
    xycursor 0,19  ;cambia la posicion del cursor 
    fin ;funcion para finalizar el programa 
principal endp   ;fin del proceso principal 
;FUNCION PARA DIBUJAR AL HONGO
HONGO PROC NEAR ;inicia el proceso de dibujar al hongo  
    ;se usa la funcion bloque para imprimir bloques de 2x2 con el mismo color 
    
    ;linea1   
    bloque 0,1,0,1,blanc ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 2,3,0,1,blanc
    bloque 4,6,0,1,blanc
    bloque 6,9,0,1,blanc
    bloque 8,12,0,1,blanc
    bloque 10,15,0,1,blanc
    bloque 12,18,0,1,blanc
    bloque 14,21,0,1,blanc
    bloque 16,23,0,1,blanc
  
    ;linea2
    bloque 0,1,2,3,blanc ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 2,3,2,3,gris
    bloque 4,6,2,3,gris
    bloque 6,9,2,3,gris
    bloque 6,12,2,3,gris
    bloque 8,13,2,3,blanc
    bloque 10,15,2,3,gris
    bloque 12,18,2,3,gris
    bloque 14,21,2,3,gris
    
  
    bloque 16,23,2,3,blanc
    
    ;linea3   
    
    bloque 0,1,4,5,blanc ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 2,3,4,5,gris
    bloque 4,6,4,5,gris
    bloque 6,9,4,5,gris
    bloque 6,12,4,5,gris
    bloque 8,13,4,5,gris
    bloque 10,15,4,5,gris
    bloque 12,18,4,5,gris
    bloque 14,21,4,5,gris  
       bloque 16,23,4,5,blanc             
    ;linea4
    bloque 0,1,6,7,blanc ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 2,3,6,7,blanc
    bloque 4,6,6,7,gris
    bloque 6,9,6,7,gris
    bloque 6,12,6,7,gris
    bloque 8,13,6,7,gris
    bloque 10,15,6,7,gris
    bloque 12,18,6,7,gris
    bloque 14,21,6,7,blanc  
       bloque 16,23,6,7,blanc
     ;linea5  
     bloque 0,1,8,9,blanc ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 2,3,8,9,blanc
    bloque 4,6,8,9,blanc
    bloque 6,9,8,9,gris
    bloque 6,12,8,9,gris
    bloque 8,13,8,9,gris
    bloque 10,15,8,9,gris
    bloque 12,18,8,9,blanc
    bloque 14,21,8,9,blanc  
    bloque 16,23,8,9,blanc
     
     ;linea6
     bloque 0,1,10,11,blanc ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 2,3,10,11,blanc
    bloque 4,6,10,11,blanc
    bloque 6,9,10,11,blanc
    bloque 6,12,10,11,blanc
    bloque 8,13,10,11,gris
    bloque 10,15,10,11,blanc
    bloque 12,18,10,11,blanc
    bloque 14,21,10,11,blanc  
    bloque 16,23,10,11,blanc
     ;linea7
     bloque 0,1,12,13,blanc
     bloque 2,3,12,13,blanc
     bloque 4,5,12,13,blanc
     bloque 6,7,12,13,blanc 
     bloque 8,13,12,13,blanc
     bloque 10,15,12,13,blanc
     bloque 12,18,12,13,blanc
     bloque 14,21,12,13,blanc
     bloque 16,23,12,13,blanc
                      
     ;linea8
    
     bloque 2,3,14,15,gris
     bloque 4,6,14,15,gris
     bloque 6,9,14,15,gris
     bloque 8,12,14,15,gris
    
     ;linea9 
     bloque 2,3,16,17,gris
     ;linea 10
     bloque 2,3,18,19,gris
     bloque 4,6,18,19,gris
     bloque 6,9,18,19,gris
     bloque 8,12,18,19,gris 
     
     ;linea20  
     bloque 2,3,20,21,gris
     bloque 8,12,20,21,gris 
     
     ;linea21
     bloque 2,3,22,23,gris
     bloque 4,6,22,23,gris
     bloque 6,9,22,23,gris
     bloque 8,12,22,23,gris 
     
     
   
    esperar          ;se usa esperar para que tenga que presionar enter para continuar
    ret ;se usa ret a modo de break 
HONGO ENDP ;finaliza el proceso de dibujar al hongo
;FUNCION PARA DIBUJAR A MARIO 

 Dibujo PROC NEAR ;inicia el proceso de dibujar OTRO DIBUJO 
    ;linea1   
    
    
    bloque 8,12,0,1,blanc
    bloque 10,15,0,1,blanc
    bloque 12,18,0,1,blanc
    bloque 15,21,0,1,blanc
    bloque 16,24,0,1,blanc 
    ;linea 2
    bloque 6,9,2,3 blanc  
    bloque 8,12,2,3,blanc
    bloque 10,15,2,3,blanc
    bloque 12,18,2,3,blanc
    bloque 15,21,2,3,blanc
    bloque 16,24,2,3,blanc 
    bloque 18,27,2,3,blanc
    ;linea 3
    bloque 4,6,4,5,blanc
    bloque 6,9,4,5,blanc  
    bloque 8,12,4,5,blanc
    bloque 10,15,4,5,blanc
    bloque 12,18,4,5,blanc
    bloque 15,21,4,5,blanc
    bloque 16,24,4,5,blanc 
    bloque 18,27,4,5,blanc
    bloque 20,30,4,5,blanc
    ;linea 4 
     bloque 2,3,6,7,blanc
     bloque 12,17,6,7,blanc
     bloque 28,30,6,7,blanc  
     ;linea 5
     bloque 13,16,8,9,blanc  
     bloque 28,30,8,9,blanc
     ;linea6
     bloque 2,3,10,11,gris 
     bloque 4,6,10,11,gris
     bloque 6,9,10,11,gris
     bloque 13,16,10,11,blanc 
     bloque 17,19,10,11,gris
     bloque 19,21,10,11,gris
     bloque 21,24,10,11,gris 
     bloque 28,30,10,11,blanc 
     ;linea7
     bloque 0,1,12,13,blanc
     bloque 2,3,12,13,gris
     bloque 4,6,12,13,gris
     bloque 6,9,12,13,gris
     bloque 13,16,12,13,blanc 
     bloque 17,19,12,13,gris
     bloque 19,21,12,13,gris
     bloque 21,24,12,13,gris 
     bloque 28,30,12,13,blanc 
     ;linea8
     bloque 0,1,14,15,blanc
     bloque 2,3,14,15,blanc 
     bloque 13,16,14,15,blanc 
     bloque 28,30,14,15,blanc 
     ;ninea9 
    bloque 0,1,16,17,blanc
    bloque 2,3,16,17,blanc 
    bloque 4,6,16,17,blanc
    bloque 6,9,16,17,blanc  
    bloque 8,12,16,17,blanc
    bloque 10,15,16,17,blanc
    bloque 12,18,16,17,blanc
    bloque 15,21,16,17,blanc
    bloque 16,24,16,17,blanc 
    bloque 18,27,16,17,blanc
    bloque 20,30,16,17,blanc
   
    ;linea8 
    bloque 0,1,18,19,blanc
    bloque 2,3,18,19,blanc 
    bloque 4,6,18,19,blanc
    bloque 6,9,18,19,blanc  
    bloque 8,12,18,19,blanc
    bloque 10,15,18,19,blanc
    bloque 12,18,18,19,blanc
    bloque 15,21,18,19,blanc
    bloque 16,24,18,19,blanc 
    bloque 18,27,18,19,blanc
    bloque 20,30,18,19,blanc 
    ;linea9 
    bloque 2,3,20,21,blanc 
    bloque 4,6,20,21,blanc
    bloque 6,9,20,21,blanc  
    bloque 8,12,20,21,blanc
    bloque 10,15,20,21,blanc
    bloque 12,18,20,21,blanc
    bloque 15,21,20,21,blanc
    bloque 16,24,20,21,blanc 
    bloque 18,27,20,21,blanc 
     ;linea10
   
    bloque 4,6,22,23,blanc
    bloque 6,9,22,23,blanc  
    bloque 8,12,22,23,blanc
    bloque 10,15,22,23,blanc
    bloque 12,18,22,23,blanc
    bloque 15,21,22,23,blanc
    bloque 16,24,22,23,blanc 
  
     
   
    
   
     
    
   
     
    

              
    
    esperar
    ret
    Dibujo ENDP


codigo ends ;finaliza el segmento de codigo
end principal  ;finaliza el proceso principal