
 include mip115.lib
cpila 100h  
datos SEGMENT       
secuencia db 0AH, 0DH," ======================================"
          db 0AH, 0DH,"|°°°°°°°°°°°°°°° MIP115 °°°°°°°°°°°°°°|"
          db 0AH, 0DH,"|°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°|"  
          db 0AH, 0DH," ======================================","$"
          
     MENU db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°OPCIONES°°°°°°°°°°°°°°°°" 
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°A-CAMBIAR COLOR °°°°°°°°°°°" 
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°B-ABOUT ME    °°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°" 
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
          db 0AH, 0DH,"°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°","$" 
   



       Mensaje db " Presione la tecla!","$" 
       submenu db " [M] Menu  [R]Cambiar color [Esc]Mouse","$"   
       cpu db " 5-10MHz","$"   
       RAM db " 500Mb","$"   
       barra db "°","$"
       inicio db "Iniciando","$"  
       nom db 0AH, 0DH,"BIOS FABRICADA PARA MIP115" 
           db 0AH, 0DH,"Ligia Hernandez","$"     
          
X db  5   ;Coordenadas X
Y db  0   ;Coordenadas Y
gris db 01111111b,"$" 
gris2 db 01111111b,"$"
blanc db 11100100b,"$"
clogo1 db  1110110b,"$" 
clogo2 db  1000100b,"$"
antX dw -1   ;tipo word de 16 bits
antY dw  0   ;bandera para validar que se mueve el cursor


    

datos ENDS

codigo SEGMENT 
    assume CS:codigo,DS:datos,SS:pila 
    
principal proc
      iniseg        
          mov ah,00H   ;Resolucion  40x25   
          mov al,00h   ;  
          int 10h      ;Interrupcion video modo texto 4025  
            push dx
          call pinguino
          xycursor  10,20  
          imprime Mensaje   
          esperar
          
         inicializar:   
                       
                       ClearS;limpia pantalla
               mov ah,00H   ;Resolucion  40x25   
          mov al,00h   ;  
          int 10h 
        
          cuadro 0,0,39,5,00011100b
          xycursor  15,0 
          imprime secuencia 
         
           
          cuadro 0,5,18,25,00011111b 
          xycursor 0 ,5
          imprime menu  
          
            
          
          
           xycursor 18 ,20
           imprime Mensaje     
            ;cuadro 18,5,39,25,00011111b
         ini:    
           
           MOV AH,00 
           INT 16H 
           CMP AL, 65  
           je  dibuja 
            
           CMP AL, 66  
           je   carga  
           jmp ini 
            
         dibuja:
            
            
          ClearS;limpia pantalla 
          dibuja2:
             call pinguino ;muestra pinguino  
             cuadro 0,24,40,25,gris2
              xycursor 0 ,24
              imprime submenu  
         
             ;-------------------------------------   
             
         escucha_teclado: 
         ;comprobar que tecla presiono
              MOV AH,00 
              INT 16H    
              
              CMP AL, 82  
              
              JE cambio 
                   
               CMP al,27
               JE pintarmouse    
              
              CMP AL, 77  
              JE INICIALIZAR   
           
             
             
             pintarmouse:
             
              mov ax,0000h; Obtiene estado de mouse
              int 33h  
              mov ax,01 ;Muestra el Mouse
              int 33h 
             
            escucha_mouse: 
              mov ax,0003h; Obtiene estado de mouse
              int 33h 
               push cx       ;Guarda coordenadas en la pila en caso de movimiento del mouse
                 push dx
                    
              cmp bx,1 ; compara bX con 1 ya que si esta presionado el boton izquierdo BX=01
              jne pintarmouse; si no esta pulsado escucha teclado
               ;si se presiona.
               
               Shr cx,1  ;division entre dos por medio de rotacion de bits 
               POP CX
               POP DX   
                  
                cuadro cl,dl,cl,dl,00011111b
                cuadro cH,dH,cH,dH,00011111b
                 mov cx,antX             ; 
                 mov dx,antY 
               
              jmp escucha_mouse
             ;---------------------------------- 
            
             
             
           
             
             cambio: 
             
              ADD  clogo1,20   ;CAMBIA LOS COLORES
              ADD clogo2,20
             jmp dibuja   ;REGRESA A DIBUJAR EL PINGUINO
              
                             
           
           carga:  
            
                 clearS  
                  
                 cuadro 0,0,39,25,00011111b
                 xycursor 5 ,6
                 imprime inicio
                 xycursor 15 ,0
                  imprime nom  
                  
                  cuadro 5,7,31,7,gris
                 mov cx,26
                 
                 bar: 
                  
                  xycursor X ,7
                  imprime barra 
                  add X,1  
                 

              loop bar 
                Mov X,5 
                 esperar
                 jmp inicializar
              
        Resetmen:  
        
        
        jmp ini    
        
      
 FIN                   
principal endp 
                      
                  
pinguino proc near 
     cuadro 16,5,24,5,clogo1  
     cuadro 15,6,15,12,clogo1
     cuadro 13,9,14,9,clogo1 
     cuadro 25,6,25,12,clogo1 
     cuadro 26,9,27,9,clogo1   
     cuadro 16,13,24,13,clogo1 
      cuadro 18,7,18,7,clogo1
      cuadro 22,7,22,7,clogo1
      cuadro 19,8,21,8,clogo1 
      cuadro 17,13,18,13,clogo2   
      cuadro 22,13,23,13,clogo2
      RET
endm

codigo ENDS 
end principal







