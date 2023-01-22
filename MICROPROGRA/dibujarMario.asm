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
  gris db 01111111b,"$"
    
datos ENDS ;termina el segmento de datos

codigo SEGMENT;comienza el segmento de codigo
    
    assume CS:codigo,DS:datos,SS:PILA  ;se asumen los segmentos de datos codigo y pila antes definidos 
principal proc ;inicia el proceso principal
    iniseg ;inicializa los segmentos
     xycursor 7,9  ;mueve el cursor para que quede en el centro del hongo
    imprime nombre ;escribe el nombre en la posicion actual del cursor
    imprime nombre2 ; enla posicion actual del cursor
    esperar
    ClearS    ;limpia la pantalla  
    xycursor 7,9  ;mueve el cursor para que quede en el centro del hongo
    call HONGO  ;llama el proceso de dibujar el hongo
    xycursor 0,19  ;cambia la posicion del cursor 
    fin ;funcion para finalizar el programa 
principal endp   ;fin del proceso principal 
;FUNCION PARA DIBUJAR AL HONGO
HONGO PROC NEAR ;inicia el proceso de dibujar al hongo  
    ;se usa la funcion bloque para imprimir bloques de 2x2 con el mismo color 
    
    ;linea1   
    bloque 0,1,0,1,blanc ;usando 2 posiciones en x y 2 en y y los colores definidos arriba
    bloque 2,3,0,1,gris
    bloque 18,19,0,1,gris
    bloque 20,21,0,1,blanc
    bloque 22,23,0,1,gris
    ;linea2
    bloque 0,1,2,3,gris  ;cada linea representa 2 filas enrealidad y dos columnas
    bloque 4,5,2,3,gris
    bloque 6,7,2,3,blanc 
    bloque 8,9,2,3,gris
    bloque 10,11,2,3,blanc
    bloque 12,13,2,3,gris
    bloque 14,15,2,3,blanc
    bloque 16,17,2,3,gris
    bloque 20,21,2,3,gris 
    bloque 22,23,2,3,blanc
    ;linea3
     bloque 2,3,4,5,gris
     bloque 4,5,4,5,blanc
     bloque 6,7,4,5,gris
     bloque 8,9,4,5,blanc
     bloque 10,11,4,5,gris
     bloque 12,13,4,5,blanc
     bloque 14,15,4,5,gris
     bloque 16,17,4,5,blanc
     bloque 18,19,4,5,gris
     bloque 22,23,4,5,gris               
    ;linea4
     bloque 2,3,6,7,blanc
     bloque 4,5,6,7,gris
     bloque 6,7,6,7,blanc
     bloque 8,9,6,7,gris
     bloque 10,11,6,7,blanc
     bloque 12,13,6,7,gris
     bloque 14,15,6,7,blanc
     bloque 16,17,6,7,gris
     bloque 18,19,6,7,blanc
     bloque 22,23,6,7,blanc
     ;linea5
     bloque 22,23,8,9,gris
     ;linea6
     bloque 6,7,10,11,blanc
     bloque 10,11,10,11,blanc 
     bloque 14,15,10,11,blanc
     bloque 22,23,10,11,blanc
     ;linea7
     bloque 0,1,12,13,blanc
     bloque 4,5,12,13,blanc
     bloque 6,7,12,13,gris 
     bloque 8,9,12,13,blanc
     bloque 10,11,12,13,gris
     bloque 12,13,12,13,blanc
     bloque 14,15,12,13,gris
     bloque 16,17,12,13,blanc
     bloque 20,21,12,13,blanc
     bloque 22,23,12,13,gris                     
     ;linea8
     bloque 0,1,14,15,gris
     bloque 2,3,14,15,blanc
     bloque 18,19,14,15,blanc
     bloque 20,21,14,15,gris 
     bloque 22,23,14,15,blanc
     ;linea9
     bloque 0,1,16,17,blanc
     bloque 2,3,16,17,gris
     bloque 4,5,16,17,blanc
     bloque 6,7,16,17,gris
     bloque 8,9,16,17,blanc
     bloque 10,11,16,17,gris
     bloque 12,13,16,17,blanc
     bloque 14,15,16,17,gris
     bloque 16,17,16,17,blanc
     bloque 18,19,16,17,gris
     bloque 20,21,16,17,blanc
     bloque 22,23,16,17,gris 
    esperar          ;se usa esperar para que tenga que presionar enter para continuar
    ret ;se usa ret a modo de break 
HONGO ENDP ;finaliza el proceso de dibujar al hongo
;FUNCION PARA DIBUJAR A MARIO


codigo ends ;finaliza el segmento de codigo
end principal  ;finaliza el proceso principal



