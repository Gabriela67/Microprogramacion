
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
          
   
nombre db "gabriela"
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
     
         
           
          cuadro 0,5,18,25,00011111b ;muestra menu
          xycursor 0 ,5
          imprime menu  
          
            
         
        
 ini:    
            MOV AH,00 ;verifica la letra que se presiona en el menu
            INT 16H 
            CMP AL, 65 ;verifica la letra A 
            je   dibuja 
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
            xycursor 18 ,15
            imprime CPU 
            mov bx,offset CPU   
            cuadro 13,9,15,9,11111111b 
            cuadro 13,11,15,11,00011100b  
            cuadro 13,13,15,13,00011100b
            jmp Resetmen 
            
            dibuja2:  ;cambiar fondo
            cuadro 18,5,39,25,00011111b 
            xycursor 18 ,15 
            mov bx,offset RAM 
            imprime RAM  
                     
            cuadro 13,9,15,9,00011100b 
            cuadro 13,11,15,11,11111111b  
            cuadro 13,13,15,13,00011100b
            jmp Resetmen
                                
           
           carga:                      ;desplazar apellido
            cuadro 13,9,15,9,00011100b 
            cuadro 13,11,15,11,00011100b  
            cuadro 13,13,15,13,11111111b
                clearS  
                  
                 cuadro 0,0,39,25,00011111b ;muestra mensaje
                 xycursor 5 ,6
                 imprime inicio
                 xycursor 15 ,0
                  imprime nom  
                  
                cuadro 5,7,31,7,gris
                 mov cx,26                   ;contador para controlar los cuadros a dibujar
                 
                 bar: 
                  
                  xycursor X ,7
                  imprime barra 
                  add X,1  
 
                  loop bar 

               Mov X,5  ;reinicia la coordenada donde se muestra la barra
                 esperar
                 jmp inicializar
              
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







