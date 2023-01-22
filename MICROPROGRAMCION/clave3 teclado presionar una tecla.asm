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
          db 0AH, 0DH,"°°°°°°°°°°°°A-VER TECLA   °°°°°°°°°°°°°" 
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
       Mensaje2 db " La tecla es:","$"  
       MENU2 db 0AH, 0DH, " [R]-REGRESAR      ","$"     
       barra db "°","$"
       inicio db "Iniciando","$"  
       nom db 0AH, 0DH,"BIOS FABRICADA PARA MIP115" 
           db 0AH, 0DH,"Ligia Hernandez","$"     
X db  5   ;Coordenadas X
Y db  0   ;Coordenadas Y 
xb db 10   ;maneja coordenadas de la barra
amarillo db 11100100b,"$" ;colores para el hongo
otrocolor db 01011110b,"$" ;o 
continua db "Presione una tecla para continuar...","$"
datos ENDS

codigo SEGMENT 
    assume CS:codigo,DS:datos,SS:pila 
    
principal proc
      iniseg        
          mov ah,00H   ;Resolucion  40x25   
          mov al,00h   ;  
          int 10h      ;Interrupcion video modo texto 4025  
         inicializar:
           call teclado   
           xycursor 15,20  ;posiciona cursor
           esperar         ;espera a que se presione una tecla
         menup:            ;inicia seccion  que muesta el menu
          cuadro 0,0,39,28,01011111b
          xycursor  15,0 
          imprime secuencia   ;encabezado
         
           
          cuadro 0,5,39,25,00011111b 
          xycursor 15 ,5
          imprime menu        ;opciones  
          
           
          
          cuadro 0,35,38,39,1110110b 
          xycursor 15 ,39
          imprime mensaje   ;fin de codigos que muestran el menu 
          cuadro 25,8,26,8,otrocolor 
          cuadro 25,10,26,10,otrocolor 
          
          ;comparamos las teclas
          
          MOV AH,00      ;lee el teclado con int 16 funcion 00
          INT 16H   
          
          CMP AL,  65     ;si presiona A
          je   op1        ;salta a op1
          
          CMP AL,  66     ;si presiona B
          je   op2        ;salta a op1
                       
          jmp menup   ;si no presiona la tecla A regresa a mostrar el menu          
          
          op1:
               clearS  ;limpia pantalla                 
               call teclado ;muestra teclado
               cuadro 6,27,24,39,1110110b ;crea cuadro para mostrar un sub menu 
               xycursor 7 ,30 
               imprime menu2              ;muestra texto del submenu
               xycursor 15,20
              
              leetecla:         ;seccion para leer la tecla
                                
               XOR AX,AX        ;mueve 00 al registro AH           
               INT 16h 
               
                ;si al >=65 y al <=75
               limiteinf:       ;compara si la tecla presionada es mayor a la letra A
               cmp al,65
               jae  limitesup   ;si es mayor o igual a A salta a verificar limite superior
               jmp leetecla
                limitesup:     
                CMP AL,82   ;si presiona la tecla R
                je menup   ;saltar al menu principal
                
                
                cmp al,75      ;si es menor o igual a K
                JLE  mostrartecla;si es menor o igual a K salta para mostrar tecla
                jmp leetecla     ;si es mayor a la letra K salta a leer tecla
                             
                mostrartecla:
                xycursor 10 ,15 
                MOV DL,AL          ;muestra la tecla presionada
                MOV AH,02
                INT 21H  
                  
          loop leetecla 
         op2: 
               
                  clearS  ;limpia pantalla
               
                  
                   xycursor 10 ,5   ;COLOCA CURSOR
                   imprime nom      ;MUESTRA DATOS
                   xycursor 10 ,20     
                  cuadro 10,10,29,10,otrocolor   ;DIBUJA BARRA BLANCA
                  mov cx,20                       ;REPETIRA EL CICLO 20 VECES
                 barra1: 
                      push cx                 ;GUARDA EN LA PILA EL VALOR DE 20
                 xycursor xb ,20 
                 cuadro XB,10,XB,10,amarillo  ;BARRA AMARIA
                 inc xb 
                     pop cx                       ;SACA DE LA PILA EL VALOR CX
                 loop barra1                        ;DECREMENTA CX Y REGRESA A BARRA1
                       mov xb,10    
                       
                       xycursor 2 ,20
                       imprime continua
                       esperar
                   jmp menup  
                
 FIN                 
principal endp   
teclado proc near   
    cuadro 10,5,30,5,amarillo 
    cuadro 20,3,20,5,amarillo 
    cuadro 10,15,30,15,amarillo  
    cuadro 10,5,10,15,amarillo  
    cuadro 30,5,30,15,amarillo  
    
    cuadro 12,7,12,7,amarillo  
    cuadro 15,7,15,7,amarillo 
    cuadro 18,7,18,7,amarillo 
    cuadro 21,7,21,7,amarillo 
    cuadro 24,7,24,7,amarillo
    cuadro 27,7,27,7,amarillo
    
    cuadro 14,10,14,10,amarillo
    cuadro 17,10,17,10,amarillo 
    cuadro 20,10,20,10,amarillo 
    cuadro 23,10,23,10,amarillo 
    cuadro 26,10,26,10,amarillo  
                               
    cuadro 12,13,12,13,amarillo  
    cuadro 27,13,27,13,amarillo 
    cuadro 15,13,24,13,amarillo   
    ret ;regresa el control a la línea desde donde fue llamado 
endp

codigo ENDS 
end principal