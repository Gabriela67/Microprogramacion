INCLUDE MIP115.inc
.data ;se crean los segmentos
strPuntaje BYTE "PUNTOS:",0
suelo BYTE "-----------------------------------------------",0
puntaje BYTE 0 ;TIPO BYTRE Y SE INICIALIZA CON TIPO 0
xPos BYTE 20
yPos BYTE 20
;;;;;;LOS PREMIOS QUE SE LE DARAN A ESTE JUGADOR
xPremioPos BYTE  ?
yPremioPos BYTE  ?
entrada BYTE ?
.code

main Proc;;;;se inicia el procedimiento
mov dl,0
mov dl,29
mov dh,29
call Gotoxy
mov edx,OFFSET suelo;;;muestra la variable
call WriteString
call DibujarJugador ;;;;;SE LLAMANA LAS FUNCIONES QUE HEMOS CREADO
call CrearPremioAleatorio 
call DibujarPremio
call Randomize ;;;;se inicializa la semilla de los valores aletorios
;;;;se procede a crear un ciclo loop
JuegoLoop:  ;;;;RETORNA SEGEMENTOS
    mov bl, xPos
    cmp bl, xPremioPos ;;;;;si el jugador coliciona con el premio se le dara un puntaje por eso se compara con el registro bl 
                        ;que es el que tienen la posiocion del reloj y premioPos tiene la posion en x del premio
    jne noRecolecta
    mov bl,yPos
    cmp bl,yPremioPos
    jne noRecolecta;;;genera salto para el caso que no coincidan salta a esta seccion
    inc puntaje
    call CrearPremioAleatorio 
    call DibujarPremio

 noRecolecta:
    
mov eax, white(black*16)
call SetTextColor
mov dl,0
mov dh,0
call Gotoxy
mov edx, OFFSET strPuntaje 
call WriteString;;se encarga de mostrra en pantalla
mov al,puntaje
call WriteInt


;LOGICA DE GRAVEDAD
gravedad:
cmp yPos,27
jg sobrePiso
call ActualizarPlayer
inc yPos
call DibujarJugador
mov eax,80
call Delay
jmp gravedad ;salto a la logica de gravedad es como estar en un loop un ciclo

sobrePiso:
call ReadChar;lee lo que usuario digita en las teclas
mov entrada,al

cmp entrada,"x"
je salirJuego

cmp entrada,"w"
je MoverArriba
cmp entrada,"s"
je MoverAbajo
cmp entrada,"a"
je MoverIzquierda
cmp entrada,"d"
je MoverDerecha

MoverArriba:
mov ecx,1 ;;;;se establece el incremento en 1
    SaltoLoop:
    call ActualizarPlayer 
    dec yPos
    call DibujarJugador
    call Delay
    loop SaltoLoop ;regresa al loop
    jmp JuegoLoop

        MoverAbajo:
        call ActualizarPlayer 
        inc yPos
        call DibujarJugador
        jmp JuegoLoop

        MoverIzquierda:
        call ActualizarPlayer 
        dec xPos
        call DibujarJugador
        jmp JuegoLoop

        MoverDerecha:
        call ActualizarPlayer 
        inc xPos
        call DibujarJugador
        jmp JuegoLoop


salirJuego:
exit



main ENDP;;;;se finaliza los procedimientos

DibujarJugador PROC ;;;proc palabra reservada
mov dl, xPos
mov dh, yPos
 call Gotoxy;;;;se llama gotoxy se a poya en el registro dx
mov al, "X"
call WriteChar ;se llama la funcion WriteChar
ret ;;;;
DibujarJugador ENDP ;;;;Finaliza la funcion

ActualizarPlayer PROC
mov dl, xPos
mov dh, yPos
call Gotoxy;;;;se llama gotoxy se a poya en el registro dx
mov al, " "
call WriteChar ;se llama la funcion WriteChar
ret ;;;;
ActualizarPlayer ENDP

DibujarPremio PROC
 mov eax,yellow(yellow*16)
 call SetTextColor
mov dl, xPremioPos 
mov dh, yPremioPos
call Gotoxy
mov al, "*"
call WriteChar
ret
DibujarPremio ENDP

CrearPremioAleatorio PROC
mov eax, 55
inc eax
call RandomRange
mov xPremioPos,al
mov yPremioPos,27
ret
CrearPremioAleatorio ENDP

end main
