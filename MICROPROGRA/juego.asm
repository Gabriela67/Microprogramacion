include mip115.lib ;reutilizar la libreria que usamos en las clases pasado donde hay hay macros que nos permite mostrar msj
cpila 100h ;recibe un tamano que se va areservar en la memoria del computador 256 elementos (posiciones de memoria que podemos utilizar) 

datos SEGMENT ;colocamos msj que a colocar , variables , tipo de datos
 nombre DB 0AH, 0DH, "______00000___00000     **********************************************"
        DB 0AH, 0DH, "-----0000000_0000000    *---------------------------------------------*"
        DB 0AH, 0DH, "_____000000000000000    *--*******---**---**___******--******-----**--* "
        DB 0AH, 0DH, "_____000000000000000    *----**------**---**---**------**--------*--*-* "
        DB 0AH, 0DH, "_____00000000000000     *----**------**---**---**------**-------*----**"
        DB 0AH, 0DH, "------000000000000    --*----**------**---**---******--******---*----** "
        DB 0AH, 0DH, "-------0000000000       *----**------**---**---**------**---*---*----**"
        DB 0AH, 0DH, "--------00000000        *----**------**---**---**------**---*----*--*-*"
        DB 0AH, 0DH, "---------000000         *-*****------*******---******--******-----**--* "
        DB 0AH, 0DH, "----------0000          *---------------------------------------------*"
        DB 0AH, 0DH, "-----------00           *****----*************************************"
        DB 0AH, 0DH, "------------             ---**---*                                    "
        DB 0AH, 0DH, "_____________             ---**--*"  
        DB 0AH, 0DH, "_____________           -------*-*","$" ;el signo de dolar significa que termina el conjunto de caracteres
;========================================================================================================== 
 nombre1 DB 0AH, 0DH, "______00000___00000     **********************************************"
        DB 0AH, 0DH, "-----0000000_0000000    *---------------------------------------------*"
        DB 0AH, 0DH, "_____000000000000000    *-------------******-----**-------------------* "
        DB 0AH, 0DH, "_____000000000000000    *-------------**--------*--*------------------* "
        DB 0AH, 0DH, "_____00000000000000     *-------------**-------*----*-----------------*"
        DB 0AH, 0DH, "------000000000000    --*-------------******---*----*-----------------* "
        DB 0AH, 0DH, "-------0000000000       *-------------**---*---*----*-----------------*"
        DB 0AH, 0DH, "--------00000000        *-------------**---*----*--*------------------*"
        DB 0AH, 0DH, "---------000000         *-------------******-----**-------------------* "
        DB 0AH, 0DH, "----------0000          *---------------------------------------------*"
        DB 0AH, 0DH, "-----------00           *****----**************************************"
        DB 0AH, 0DH, "------------             ---**--*                                    "
        DB 0AH, 0DH, "_____________             ----**"  
        DB 0AH, 0DH, "_____________           -------*","$"
        

    
blanc db 11111111b,"$"  ;declaramos un binario el color 
yi db 2; para menejar las corrdenada  y
yf db 2 ;
xi db 2 ;para mover la coordenada en x
xf db 2
   
nombreG db "GABRIELA","$" 

perdio db "perdio","$"
datos ENDS;finalizamos el semento de datos                                                       

codigo SEGMENT 
    assume CS:codigo,DS:datos,SS:pila 
    
principal proc;servira para construir toda la logica del proyecto
      iniseg;iniciamos el semento de codigo     
 jugar:     
      mov cx,1  ;el cx es un registro contador del programa , realiza conteos
      
      intro: ;seccion 
      xycursor 10,9  ;gotoxy donde se va a mostrar el cursor en la pantalla 
      imprime nombre  ;imprimimos el nombre de la variable para mostrar la cadena de caracteres
      xycursor 10,9  ;gotoxy  
      imprime nombre1 
      loop intro  ;el loop permite regresar a un semento del codigo
      
     
       esperar ;hacer una transicion
       clearS ;limpiar la pantalla   
       
        
         mov xi,2
         mov xf,2
         
       
       inicia_cuadro:
       
              moverAbajo:
              
              
       
         add yi,2 ;incremento las cordenadas en y
         add yf,2  
        
         
       
          cuadro xi,yi,xf,yf,blanc ;cordenadas para mover  
         
          
          clearS ; limpio la pantalla
          
          cmp yi,25 ;comparamos si yi es igual 25 y si es igual a 25 que salta a resetear pantalla
          ja resetp  ;  
          
              
          
             mov ah,8h 
             mov al,97 
             mov ah,8h
             mov al,119
             mov ah,8h
             mov al,100
             mov ah,8h
             mov al,115
             int 21h
             
             cmp al,97
             je moverIzquierda  ;significa q es igual
       
              ;xi derecha
              ;xf izquierda
              ;yi abajo
             ;yf arriba   
             
          
            
             cmp al,119
             je moverArriba 
             
             
            
            
             cmp al,100
             je  moverDerecha 
             
             
           
             cmp al,115
             je moverAbajo  
             
             
            
         
          
          
          
       loop inicia_cuadro ; loop es un bucle  
       
       
       izquierda:
         
            moverIzquierda:  
            
            sub xi,1
            sub xf,1 
                      
               
            
             cuadro xi,yi,xf,yf,blanc 
             
              clearS  
             
             cmp xf,0
             je resetp 
             
             
             mov ah,8h
             mov al,97 
             mov ah,8h 
             mov al,97 
             mov ah,8h
             mov al,119 
             mov ah,8h
             mov al,100
             mov ah,8h
             mov al,115
             int 21h
             
             
             cmp al,97
             je moverIzquierda   
             
             
             
             cmp al,97
             je moverIzquierda  ;significa q es igual
       
              ;xi derecha
              ;xf izquierda
              ;yi abajo
              ;yf arriba   
             
            
              
             cmp al,119
             je moverArriba 
             
             
             
            
             cmp al,100
             je  moverDerecha 
             
             
            
             cmp al,115
             je moverAbajo  
             
             
            
             loop izquierda 
             
             arriba:
             
             moverArriba:
             
             sub yi,1
             sub yf,1 
             
             cuadro xi,yi,xf,yf,blanc 
              clearS
             
             cmp yf,0
             je resetp
              
              mov ah,8h
              mov al,119
              mov ah,8h 
              mov al,97
              mov ah,8h
              mov al,119 
              mov ah,8h
              mov al,115
              int 21h
             
              
              cmp al,119
              je moverArriba
              
              
             
              
             cmp al,97
             je moverIzquierda  ;significa q es igual
       
              ;xi derecha
              ;xf izquierda
              ;yi abajo
             ;yf arriba   
             
            
             
             cmp al,119
             je moverArriba 
             
             
             
            
             cmp al,100
             je  moverDerecha 
             
             
             
             cmp al,115
             je moverAbajo  
             
             
             
            loop arriba 
            
            derecha:  
            
            moverDerecha:
            
            add xi,1
            add xf,1
                    
            cuadro xi,yi,xf,yf,blanc
             clearS
            
            cmp xi,25
            je resetp
            
            mov ah,8h
            mov al,100 
            mov ah,8h 
             mov al,97
              mov ah,8h
             mov al,119 
             mov ah,8h
             mov al,100 
              mov ah,8h
             mov al,115
             int 21h
            
            
            cmp al,100
            je moverDerecha 
            
            
             
           
             cmp al,97
             je moverIzquierda  ;significa q es igual
       
              ;xi derecha
              ;xf izquierda
              ;yi abajo
             ;yf arriba   
             
            
              
             cmp al,119
             je moverArriba 
             
             
             
             
             cmp al,100
             je  moverDerecha 
             
             
            
             cmp al,115
             je moverAbajo  
             
            
            
            loop derecha 
            
             
            
       ; AWSD
       ; A DECREMENTAR X
       ; w DECREMEN  Y
       ; s INCREMENTAR Y
       ; d   INCREMENTAR X 
       
    
             
          resetp:
               mov yi,0
               mov yf,0 
               clearS  
               xycursor 10,9
               imprime perdio  
               esperar
                  clearS
          ;jmp inicia_cuadro  
       
        
 loop jugar 

 
 salir:
 fin
      
principal endp


    
codigo ENDS 
end principal ;finacile el procedimiento
;a