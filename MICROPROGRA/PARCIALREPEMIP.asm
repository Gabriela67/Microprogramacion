
include mip115.lib
cpila 100h  
datos SEGMENT   ;inicio de segmento de datos    

              ;z cambiar color de fondo
     MENU db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°OPCIONES°°°°°°°°°°°" 
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°A-llenar la pantalla°°" 
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°B-Cambiar color°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°C- el apellido   °°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°D-mostrar Carretera°°°" 
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°"
          
   
nombre db "GABRIELA","$"
X db  5   ;Coordenadas X para colocar el cursor
Y db  0   ;Coordenadas Y para colocar el cursor
gris db 01111111b,"$" ;definicion de colores
gris2 db 01111111b,"$"
blanc db 11100100b,"$"
clogo db  00000000b,"$" 
datos ENDS;Fin de segmento de datos

codigo SEGMENT 
    assume CS:codigo,DS:datos,SS:pila 
    
principal proc
      iniseg        
               
       
         
           
         
         
          imprime menu  
          
            
         
        
 ini:    
            MOV AH,00 ;verifica la letra que se presiona en el menu
            INT 16H 
            CMP AL, 65 ;verifica la letra A 
            je   dibuja
            esperar: 
            CMP AL, 66  ; verifica la retra B
            je   dibuja2 ;cambiar fondo   
            CMP AL, 67 ; verifica la letra C  
            je   carga 
            CMP AL, 68 ; verifica la letra C  
            je   carretera
            jmp ini 
            
              carretera: 
              jmp Resetmen
            
            dibuja: ;llenar pantalla con nuestro nombre
              mov ah,00H ; resolucion 40x25
        mov al,00h ;                                 
        int 10h ; interrupcion video modo texto 4025
             fila:     ;selecion para crear una fila
             col: 
             xycursor X,Y ;colocar el cursor
             imprime nombre ; muestra la cadena de caracteres
             add X,8; suma 5 unidades (nukm.letras) a nueva posisicioen de x     
             cmp X,39  ;compara si la posicion x con 39 ya que la resolucion es de 40(0-39)
             jae resetx; si es mayor a 39 salta a resetx para poner en cero x
             loop col   ; si no es mayor que o igual a 39 regresa a colocar
             resetx:
             mov x,0
             add y,1
             cmp y,24
             jae salir
           loop fila
            salir:
             
          
            jmp Resetmen 
            jmp ini
            
            dibuja2:  ;cambiar fondo
              
                     
            cuadro 13,9,15,9,00011100b 
            cuadro 13,11,15,11,11111111b  
            cuadro 13,13,15,13,00011100b
            jmp Resetmen
                                
           
           carga:                      ;desplazar apellido
            cuadro 13,9,15,9,00011100b 
            cuadro 13,11,15,11,00011100b  
            cuadro 13,13,15,13,11111111b
                clearS  
                  
                 
               
              
                
              
        Resetmen:  ;regresa al menu
        
        
        jmp ini 
        
        
      
 FIN                   
principal endp 
                      
                      
logo proc near
       cuadro 0,0,40,25,gris   
       cuadro 10,5,30,5,clogo  ;arriba
       cuadro 10,15,30,16,clogo  
       cuadro 10,15,30,15,clogo ;abajo                                    
       cuadro 10,5,10,15,clogo ;iz
       cuadro 30,5,30,15,clogo ;der    
       cuadro 12,7,28,13,clogo ;CENTRO
       
       cuadro 10,3,10,5,clogo ;detalle superior
       cuadro 15,3,15,5,clogo
       cuadro 20,3,20,5,clogo
       cuadro 25,3,25,5,clogo  
       cuadro 30,3,30,5,clogo 
       
       
       cuadro 10,15,10,17,clogo ;detalle inferior
       cuadro 15,15,15,17,clogo
       cuadro 20,15,20,17,clogo
       cuadro 25,15,25,17,clogo  
       cuadro 30,15,30,17,clogo   
       
       
       cuadro 7,5,10,5,clogo      ;izquierda
       cuadro 7,10,10,10,clogo 
       cuadro 7,15,10,15,clogo         
       
       cuadro 30,5,33,5,clogo      ;derecha
       cuadro 30,10,33,10,clogo 
       cuadro 30,15,33,15,clogo     
       
       ret
    
endp

codigo ENDS 
end principal







