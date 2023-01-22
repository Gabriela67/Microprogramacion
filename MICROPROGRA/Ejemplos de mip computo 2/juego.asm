;VICTORIA GABRIELA VELASQUEZ
;------------------------------------------
;librerias 
INCLUDE MIP115.inc  



.data

ColumnasdePantalla		DWORD	80
cadenaEtiqueta	BYTE "Nombre: ",0
cadenaMensaje	BYTE "Bienvenido", 0dh, 0ah, 0dh, 0ah  ; mensajes al usuario de bienvenida
				BYTE " ", 0dh, 0ah, 0dh, 0ah, 0
fondo BYTE	" "
fondoColor DWORD (gray*16)+gray



LimitePantallaIzquierda	BYTE	0					    ;controlar el desplazamiento en X a nivel Izquierdo 
pantallaLimiteDerecho	BYTE	79						; controlar el desplazamiento en X a nivel derecho


SalirBandera			BYTE	0                       ; para el momento que queramos salir del juego esta se Activa y se coloca en valor de 1

ganadorEtiqueta	BYTE	"Mensaje Juego", 0				; etiquetas para mensajes
ganadorPregunta	BYTE	"GANASTE!", 0dh, 0ah		
perdedorEtiqueta		BYTE	"Mensaje Juego", 0
perdedorPregunta	BYTE	"PERDISTE!", 0dh, 0ah
				BYTE	"Te gustaria intentalor otra vez?", 0

ColorFrenteMascara BYTE 0Fh                              ; variable para mantener un color de fondo                       

;------------------VARIABLES PARA CONTROLAR AL JUGADOR

JugadorPrincipal			BYTE	06h, 0		         ;contiene el caracter en Hexadecimal  del que va hacer el jugador Principal poquer
JugadorPrincipalMoverVel	BYTE	1					 ; velocidad con la que se va a mover el jugador principal 
ColorFrenteJugadorPrincipal	BYTE	white		         ; el color que va a adoctar el jugador y va a hacer blanco
JugadorPrincipalBackColor	BYTE	green*16	         ; el color de fonto del jugador que sera verde 
JugadorPrincipalX			BYTE	20                   ; posiciones iniciales que va a tener el jugador 
JugadorPrincipalY			BYTE	20                   ; posiciones iniciales que va a tener el jugador 
ViejoJugadorX		BYTE	20                           ; controlar las posisiones  en X anteriores que ha tenido el jugador 
ViejoJugadorY		BYTE	20
 
;----------------VARIABLES PARA CONTROLAR LAS BALAS 

BalaSimbolo		BYTE	0fh, 0                           ; simbolo de las balas en hexadecimal
ColorFrenteBala	BYTE	lightblue	                     ; color de frente fe las balas 09h       
BalaColorFondo		BYTE	gray*16		                 ;color de fondo de la bala  
BalaBandera			BYTE	0                            ; bandera para saber si la bala se va estar mostrando                         
BalaX				BYTE	0                            ;coordenadas de la bala en la posicion X
BalaY				BYTE	0                            ;coordenadas de la bala en la posicion Y
ViejaBalaX			BYTE	0                            ;coordenadas Antiguas de la Bala en X
ViejaBalaY			BYTE	0                            ;coordenadas Antiguas de la bala en Y

;------------------VARIABLES PARA CONTROLAR EL PUNTAJE

puntajeColor	DWORD	white+(magenta*16)               ; el color del texto del puntaje que seria un fondo magenta y colo blanco las letras
puntajeMsg	BYTE	"Puntaje:", 0                        ; el mensaje 
puntaje		DWORD	0                                    ; el puntaje que ha ganado el jugador 
puntajeganador	DWORD	5                                ;puntaje que debe de lograr un jugador para considerarse Ganador 
puntajeY		BYTE	22                               ; coordenadas en Y donde aparecera el puntaje, columna 22 
puntajeX		BYTE	40                               ; coordenadas en X donde aparecera el puntaje, fila 40

;------------------VARIABLES PARA CONTROLAR LA VIDA

vidaColor	DWORD	white+(magenta*16)                   ;Texto blanco con fondo magenta en el mensaje de la vida
ColorAdvertenciaVida		DWORD	lightred+(lightblue*16); esta advertencia saldra cuanto tengamos un nivel de vida poquito color de advertencia  lighred en color de las letras y lighblue el color del fondo
vidaAdvertenciaBarraColor	DWORD	white+(gray*16)      ;para mostrar cuantas vidas tiene pero en un estado normar letras blancas y fondo gris
vidaAdvertenciaBarra		BYTE	0                    ;inicial mente tiene el valor de 0
vidaresetSimbolo			BYTE	6 DUP(" ")           ;para resetear la vida cuando sea necesario
vidaMensaje					BYTE	"Vida:", 0           ;mensaje 
vidaY					BYTE	22                       ;Coodernadas en Y donde estara la vida
vidaX					BYTE	20                       ;Coodernadas en X donde estara la vid
vida					DWORD	3                        ;las vidas que tendra maximo
vidaInicial				DWORD	3                        ;las vidas inial que son 3

;--------------------VARIABLES PARA CONTROLAR LAS PARTICULAS

particulaSimbolo		BYTE	"8", 0                   ;la particula se genera con el numero 8 
particulareseteasimbolo	BYTE	" "                      ;para resetear la particula colocamos un espacio Vacio
particulaX			BYTE	?                            ;coordenadas en X para las particulas
particulaY			BYTE	?                            ;coordenadas en Y para las particulas
explosionBandera		BYTE	0                        ;indica si hubo un impacto entre el enemigo
explosionColorFrente	BYTE	magenta		;05h         ;establece un color primario para la explosion que es magenta 
explosionBackColor	BYTE	red*16	;00h                 ;establece un color de fondo rojo

;----------------------VARIABLES PARA CONTROLAR EL ENEMIGO


simboloEnemigo			BYTE	49h, 49h, 49h, 49h, 0    ;conjunto de caracteres que formaran el enemigo (llll)
TamanioEnemigo			BYTE	4                        ;tamano del enemigo que es de 4
enemigoResetSimbolo	BYTE	4 DUP(" ")                 	 ; para borrar el enemigo cuando halla una explosion 
enemigoInitX			BYTE	0                        ;posicion inicial en x en 0
enemigoInitY		    	BYTE	5                    ;posicion inicial en y en 5
enemigoX				BYTE	0                        ; posicion en la que se va avanzando en X
enemigoY				BYTE	5                        ; posicion en la que se va avanzando en Y
enemigoColorFrente		BYTE	magenta		             ;05h el color de la letra seria magenta
enemigoColorFondo		BYTE	yellow*16				 ;0E0h el color del fondo seria amarillo
limiteenemigoGolpeadoBandera	BYTE 	0                ;establece cuando el enemigo es impactado o no con la bala
enemigoLineaReset		BYTE	80 DUP(" ")              ; elemina una linea cuando sea desaperecido el enemigo debe ser igual al numero de columnas del juego
        



.code
;*******************************************************************************
;******************************SEGMENTO DE CODIGO********************************
main PROC

	call Clrscr						; limpia pantalla
	call Intro
	mov ebx, OFFSET cadenaEtiqueta
	mov edx, OFFSET cadenaMensaje
	call MsgBox
	
	L0:
	
	
	call ManejadorEventosTecla	                            ;Primero se escuchan las teclas
	call LimpiaJugadorViejaPos                              ;Se limpian posiciones viejas del jugador para cuando el jugador reposicione sus cordenadas en x este procedimiento borra el rastro de la posicion anterior
	call LimpiarBalaViejaPos                                ;Se limpia las posiciones vieja de las balas
	call BorrarEnemigo                                      ;borrar enemigo
	call limpiarExplosion                                   ;borrar la colision de la bala co el enemigo
	call veriGolpebalaEnemigo                               ; verifica si hay colision entre la bala y el enemigo
	call actualizarEnemigo;                                 ; actualizar la posicion del enemigo
	call MostrarJugadorPrincipal                            ; muestra al jugador
	call mostrarEnemigo                                     ;muestra al enemigo
	call MostrarBala                                        ;muestra la bala
	call mostrarExplosion                                   ; muestra una explosión para el enemigo
	call mostrarVida                                        ; muestra la vida que tiene disponible el jugador
	call mostrarPuntaje                                   	;presenta el puntaje
	call verificarVida                                      ;verifica el nivel de vidas
	
	
	add ColorFrenteBala, 1 
	add enemigoColorFrente, 2
	add explosionColorFrente, 3
    

	
	cmp SalirBandera, 1                                        ;si la bandera es 1 significa que el usuario quiere salir
	je Exit0                                                   ; y por lo tanto va ala etiqueta exit0
	jmp L0                                                     ; pero si no continuamos en un ciclo en un loop 

Exit0:                                                         ; etiqueta exit0
	INVOKE ExitProcess, 0                                      ;finaliza el juego
main ENDP

limpiarExplosion PROC USES eax edx                            ;PROCEDIMIENTO PARA LIMPIAR EXPLOSION
	cmp explosionBandera, 2                                   ; Compara si la bandera tiene el valor de 2
	jne nadaquelimpiar                                        ;en caso de no ser iguales llama a etiqueta nada que limpiar 
	mov eax, fondoColor                                       ; en caso de ser igual se establece un color de fondo 
	call SetTextColor
	
	                                                          ;restablecer particula Izquierda-superior  
	mov ah, particulaY                                        ;asignamos la coordenada en y de la particula al registro ah
	sub ah, 1                                                 ; le restamos  una unidad 
	mov dh, ah
	mov al, particulaX                                        ; asignamos al registro al la coordenada de la particula en X
	sub al, 1                                                 ; le sumamos una unidad 
	mov dl, al
	call Gotoxy                                               ;posicionamos el cursor en la pantalla
	mov edx, offset particulareseteasimbolo                   ;mostramos en pantalla el simbolo para borrar el simbolo de la explosion 
	call WriteString
	
	                                                          ;restablecer particula Izquierda-inferior 
	mov ah, particulaY                                        ;asignamos la coordenada en y de la particula al registro ah
	add ah, 1                                                 ; le sumamos una unidad a la coordenada 
	mov dh, ah
	mov al, particulaX                                        ; asignamos al registro al la coordenada de la particula en X
	sub al, 1                                                 ;le restamos una unidad al registro al
	mov dl, al
	call Gotoxy                                               ;posicionamos el cursor 
	mov edx, offset particulareseteasimbolo                   ;mostramos en pantalla el simbolo para borrar el simbolo de la explosion 
	call WriteString
	

	                                                           ;restablecer particula derecha inferior
	mov ah, particulaY                                         ;Asignamos al registro ah la coordenada en y de la particula
	add ah, 1                                                  ; le sumamos una unidad a la coordenada 
	mov dh, ah
	mov al, particulaX                                         ; asignamos al registro al la coordenada de la particula en X
	add al, 1                                                  ; le restamos una unidas al registro al
	mov dl, al
	call Gotoxy                                                ;posicionamos el cursor
	mov edx, offset particulareseteasimbolo                    ;mostramos en pantalla el simbolo para borrar el simbolo de la explosion 
	call WriteString
	
                                                               ; restablecer la partícula derecha superior
	mov ah, particulaY                                         ;Asignamos al registro ah la coordenada en y de la particula y
	sub ah, 1                                                  ;sumamos en una unidad
	mov dh, ah
	mov al, particulaX                                         ;asignamos al registro al la coordenada de la particula en X
	add al, 1                                                  ;sumamos en una unidad ala coordenada en x
	mov dl, al
	call Gotoxy                                                ;posicionamos el cursor
	mov edx, offset particulareseteasimbolo                    ;mostramos en pantalla el simbolo para borrar el simbolo de la explosion
	call WriteString
	
	mov explosionBandera, 0
	
nadaquelimpiar:	
	ret
limpiarExplosion ENDP

veriGolpebalaEnemigo PROC USES eax
	                                                                ;Si (enemigoY == BalaY) y (enemigoX <= BalaX <= enemigoX+4) 
                                                                   	;entonces explosionBandera = 1
	                                                                ;delo contrario no cambiar
																	
	mov al, enemigoY                                                ;pasamos la cordenada del enemigoY al registro al
	cmp BalaY, al                                                   ;compamos con la coordenada de la bala 
	jne nocambiar                                                   ;en caso que no sea igual pasa a la etiqueta nocambiar
	mov al, enemigoX                                                ; de lo contrario pasamos a la siquiente condicion que es verificar 
	cmp BalaX, al                                                   ; si la posicion de la bala es el mismo que la del enemigo 
	jb nocambiar                                                    ; si no son iguales se iria a no cambiar 
	add al, TamanioEnemigo                                          ; a la posicion del enemigo se le suma 4 unidades
	cmp BalaX, al                                                   ; comparamos la posicion de la bala con el tamanio del enemigo en el caso de no ser iguales
	ja nocambiar                                                    ; al caso de no ser iguales nos iriamos a la etiqueta no cambiar 
	mov explosionBandera, 1                                         ; en el caso de ser iguales activamos la banderaa de la explocion 
	add enemigoColorFondo, 16                                       ;se cambia el color de fondo del enemigo 
	
nocambiar:
	ret                                                             ; retona el control al procedimiento principal
veriGolpebalaEnemigo ENDP

mostrarExplosion PROC USES eax edx                                  ; PROCEDIMIENTO PARA MOSTRAR LA EXPLOSION 
	cmp explosionBandera, 0                                         ; comparamos si explosionBandera es igual a 0
	je	noexplosion                                                 ; si no es igual se iria a la etiqueta noexplosion 
	
	xor eax, eax                                                    ; si es igual limpia el registro eax colocando todos sus bitsa cero
	mov al, explosionBackColor                                      ; establecemos los colores de fondo y de los caracteres
	mov dl, ColorFrenteMascara
	and explosionColorFrente, dl
	add al, explosionColorFrente
	call SetTextColor                                                ; con esta funcion pintamos en la pantalla 
	
	
	                                                               ;particula X/Y son usados en LimpiarExplosion
	mov ah, BalaY                                                  ; asignamos al registro ah la posicion de la balay
	mov particulaY, ah                                             ;luego esa posicion la vamos a guardar en una variable que se llama particula y
	mov al, BalaX                                                  ;asignamos al registro al la posicion en la balaX
	mov particulaX, al                                             ; luego esa posicion la guardamos en la variable particulaX

	                                                               ;dibujar particulas izquierda superior
	mov ah, BalaY                                                  ; tomanos la posicion de la balaY
	sub ah, 1                                                      ; le restamos una unidad 
	mov dh, ah
	mov al, BalaX                                                  ; tomamos la posicion de la balaX
	sub al, 1                                                      ;le restamos una unidad 
	mov dl, al
	call Gotoxy                                                    ;colocamos el cursor en dichas posiciones 
	mov edx, offset particulaSimbolo                               ;mostramos el simbolo que emos definido 
	call WriteString
	
	
	                                                                ;dibujar izquierda-inferior particula
	mov ah, BalaY                                                   ; tomanos la posicion de la balaY
	add ah, 1                                                       ; se sumamos una coordenada en Y
	mov dh, ah
	mov al, BalaX                                                   ;tomamos la posicion en x
	sub al, 1                                                       ; restamos una unidad a la coordenada en x
	mov dl, al
	call Gotoxy                                                     ;colocamos el cursor en la pantalla
	mov edx, offset particulaSimbolo                                ; mostramos el simbolo que hemos definido
	call WriteString
	

	                                                                ;dibujar particula en derecha-inferior
	mov ah, BalaY                                                   ;movemos al registro ah la posicion de la balaY
	add ah, 1                                                       ;le sumamos una coordenada 
	mov dh, ah
	mov al, BalaX                                                   ; movemos al registro al la coordenada BalaX
	add al, 1                                                       ; le sumanos una unidad 
	mov dl, al                                               
	call Gotoxy                                                      ;posicionamos el cursor
	mov edx, offset particulaSimbolo                                 ; mostramos en pantalla el simbolo definido para la explosion
	call WriteString
	

	                                                                ;dibujar derecha superior particula
	mov ah, BalaY                                                   ;movemos al registro ah la coordenada de balaY
	sub ah, 1                                                       ;restamos una unidad en Y
	mov dh, ah
	mov al, BalaX                                                   ;movemos al registro al la coordenada en X de la bala
	add al, 1                                                       ; sumamos una unidad 
	mov dl, al
	call Gotoxy                                                     ;posicionamos el cursor 
	mov edx, offset particulaSimbolo                                ; mostramos el simbolo establecido para la explosion
	call WriteString
	
	                                                                 ; resetear posicion de bala
	mov BalaY, 0
	mov BalaX, 0
	
noexplosion:
	ret
mostrarExplosion ENDP 

mostrarEnemigo PROC USES eax edx                                                   ; PROCEDIMIENTO PARA MOSTRAR EL ENEMIGO
	xor eax, eax                                                                   ;limpia el registro eax colocando todos sus bitsa cero
	mov al, enemigoColorFondo                                                      ; va a mover al a la parte el valor que tiene la variable enemigoColorFondo  y tierne el valor   1110*
                          	                                                       ;yellow*16=11100000
	mov dl, ColorFrenteMascara                                                     ; movemos a dl el valor de dl=0F
	and enemigoColorFrente, dl                                                     ; aplicamos el operador and de lo que equivale  05h and 0F
	add al, enemigoColorFrente                                                     ;luego obtenemos lo que hemos tenido de la operacion          
	call SetTextColor                                                              ; para establecer los caracteres llamamos a la funcion SetTextColor 
	mov dh, enemigoY                                                               ;posicionamos las cordenadas del enemigo en x y en y
	mov dl, enemigoX
	call Gotoxy                                                                    ;posicionamos el curson el la posicion
	mov edx, offset simboloEnemigo                                                 ; mostramos el enemigo en pantalla 
	call WriteString                
	ret
mostrarEnemigo ENDP

actualizarEnemigo PROC USES eax                                                    ;PROCEDIMIENTO PARA ACTUALIZAR LA POSICION DEL ENEMIGO
	cmp explosionBandera, 1                                                        ;comparamos si ha habido una colision entre las balas y enemigo
	je resetPosicionEnemigo                                                        ; en caso que si llamos a la etiqueta resetPosicionEnemigo  
	mov al, pantallaLimiteDerecho                                                  ;pero si no tomalos en el registro al el limite derecho 
	sub al, TamanioEnemigo                                                         ; le restamos el tamano del enemigo que son 4 posiciones 
	cmp enemigoX, al                                                               ; se compara pa posicion del enemigo con esa resta y si esta dentro del rango
	je limiteenemigoGolpeado                                                       ;llamamos ala etiqueta limiteenemigoGolpeado

	inc enemigoX                                                                   ;en caso contrario se va ir incrementado la posicion del enemigo 
	jmp continue
	
limiteenemigoGolpeado:
	mov limiteenemigoGolpeadoBandera, 1                                             ; activamos la bandera que indica que el enemigo a sido golpead
	
resetPosicionEnemigo:
	call BorrarEnemigoLine                                                          ;borra la linea donde esta el enemigo 
	mov al, enemigoInitX                                                            ; cambia las posiciones iniciales al registro al
	mov enemigoX, al                                                                ; reposiciona al enemigo en x atraves de 0 lo movemos a la izquierda para que parezca que apaece un nuevo enemigo
	
continue:
	ret                                                                              ; devuelve el control al procedimiento principal
actualizarEnemigo ENDP


BorrarEnemigo PROC USES eax edx                                                      ;PROCEDIMIENTO PARA BORRAR ENEMIGO 
	mov eax, fondoColor                                                              ; colocar en el registro eax el color de fondo actual
	call SetTextColor                                                                ;se establece el color de fondo
	mov dh, enemigoY                                                                 ; se establece las posiciones
	mov dl, enemigoX
	call Gotoxy                                                                      ; se posiciona el cursor
	mov edx, offset enemigoResetSimbolo                                              ;se muestra la cadena de caracteres
	call WriteString                                                                 ; se imprime en pantalla 
	ret
BorrarEnemigo ENDP

BorrarEnemigoLine PROC USES eax edx
	mov eax, fondoColor                                                             ; establece los colores de fondo que va a tener el texto 
	call SetTextColor
	mov dh, enemigoY                                                               ;la posicion actual que tiene el enemigo de mueve al registro dh
	mov dl, 0                                                                      ;pero la posicion x va a ser 0 por que apartir de esa posicion se va a borrar la linea donde estaba el enemigo
	call Gotoxy                                                                       
	mov edx, offset enemigoLineaReset                                              ; se muestras las lineas en la pantalla para dar el efecto que ha sido eleminado el enemigo 
	call WriteString 
	ret
BorrarEnemigoLine ENDP

 
MostrarBala PROC USES eax edx                                                     ;PROCEDIMIENTO PARA MOSTRAR BALA
	cmp BalaBandera, 0                                                            ;comparamos si la bandera de bala esta en falso
	je nomostrar                                                                  ;nos va allevar a una etiqueta para no mostrar ninguna bala en caso que si es verdadera
	cmp ViejaBalaY, 1                                                             ;pasamos a la segunda comparacion que es verificar si la posicio vieja de la bala es menor o igual a 1 
	jbe desaparecer                                                               ; en caso que la condicion se cumpla lo que hara es desaparecer la bala 
	cmp explosionBandera, 1                                                       ; si la comparacion es mayor que 1 se haria la siguiente comparacion seria si la bala a colicionado con algun eneigo 
	je	desaparecer                                                               ; si la bala coliciono con el enemigo se tendria que desaparecer la bala
	mov dh, BalaY                                                                 ; en caso de que no halla colicionado pasamos las posiciones de bala Y
	mov dl, BalaX                                                                 ; y bala X
	call Gotoxy                                                                   ;ubicamos el cursor en dichas posiciones
	xor eax, eax                                                                  
	mov al, BalaColorFondo                                                        ;establecemos el color de fonfo
	mov dl, ColorFrenteMascara                                                    ;color de frente
	and ColorFrenteBala, dl                                                       
	add al, ColorFrenteBala                                                       
	call SetTextColor                                                             
	mov edx, offset BalaSimbolo
	call WriteString                                                              ;utilizamos este metodo para mostrarlo en pantalla
	dec BalaY                                                                     ;decrementamos la pocicion de la bala por estar en un ciclo iria decrementando la bala 
	jmp nomostrar                                                                 
	
desaparecer:
	mov BalaBandera, 0                                                            ; para no mostrar la bala
nomostrar:
	ret	
MostrarBala ENDP                                                                  ;finalizamos el procedimiento 

LimpiarBalaViejaPos PROC USES eax edx                                             ;procedimiento para borrar la bala que se esta mostrando                                           
	mov dh, ViejaBalaY                                                            ; toma las posiciones actuales de la bala 
	mov dl, ViejaBalaX
	call LimpiarBalaPos                                                           ; llama al metodo limpiarBalaPos
	mov al, BalaY                                                                 ; toma las nuevas posiciones  de balaY y las asigna al registro al
	mov ViejaBalaY, al                                                            ; luego se asigna a VielaBalaY tomamos la posicion y por que solo se movera en el eje Y      
	ret
LimpiarBalaViejaPos ENDP


LimpiarBalaPos PROC USES eax                                                       ;limpiarBalapos Lo que hace es imprimir caracteres vacios y establecer un fondo
	mov eax, fondoColor                                                            ;establecer un fondo sililar al del recuadro para que se vea un efecto de limpieza
	call SetTextColor
	call Gotoxy
	push edx
	mov edx, offset fondo
	call WriteString
	pop edx
	ret
LimpiarBalaPos ENDP

;INTRO DEL JUEGO

Intro PROC
	pushad
	mov eax, fondoColor
	call SetTextColor
	mov dh, 0
	mov dl, 0
	mov bx, dx
	mov eax, 80
	mov ecx, eax
	
L1:	
	mov eax, ecx
	mov ecx, 20
	
L0:
	mov dx, bx	
	call Gotoxy
	mov edx, offset fondo
	call WriteString
	inc bh
	loop L0
	mov bh, 0
	inc bl
	mov ecx, eax
	loop L1
	popad
	ret
Intro ENDP




MostrarJugadorPrincipal PROC USES eax edx                             ;el procedimiento MostrarJugadorPrincipal  utiliza 2 registros eax y edx
	xor eax, eax													  ;hacemos un xor del registro eax lo que dara como resultado colacar ese registro en 0
	mov al, JugadorPrincipalBackColor                                 ;movemos el registro al ala parte baja lo que tiene el jugadorprincipalBackcolor lo que seria 20h en haxadedimal
	mov dl, ColorFrenteMascara                                        ; movemos al registro dl el color frente mascara 0Fh va a hacer el color del texto
	and ColorFrenteJugadorPrincipal, dl                               ; implementamos el operador and para aplicarlo al  ColorFrenteJugadorPrincipal con el registro dl , esto por si queremos cambiar el jugador se pueda hacer atraves de las variables 
	add al, ColorFrenteJugadorPrincipal                               ; 20h+0Fh=2Fh     
	call SetTextColor                                                 ; la funcion setTextColor dibuja el caracter en la pantalla
	mov dh, JugadorPrincipalY                                         ; tomamos las posiciones de jugador Y y lo pasamos al registro dh y colocamos el cursor 
	mov dl, JugadorPrincipalX                                         ;tomamos las posiciones de jugador Y y lo pasamos al registro dh y colocamos el cursor
	call Gotoxy                                                       ;llamamos a la funcion Gotoxy por que ahi colocaremos el cursor y mostraremos el caracter
	mov edx, offset JugadorPrincipal                                  ;llamanos a la impresion en pantalla de ese caracter 
	call WriteString                                                  ;funcion para imprimir en pantalla
	ret                                                               
MostrarJugadorPrincipal ENDP                                          ;finalizamos el procedimiento


mostrarVida PROC USES eax edx                                         ;el prcedimeinto mostrarVidea recibe 2 registros eax y edx
	mov eax, vidaColor                                                ;en el registro eax establecemos la configuracion de los colores
	cmp vida, 1                                                       ;comparamos el entero que contiene el numero de vida actuales del jugador con 1                       
	ja sinadvertencia                                                 ;si la vida es superior a uno se va ala seccion sin advertencia por lo que temos mas vidas  de lo contrario abvertirle al jugador
   call limpiarMostrarVida                                            ; funcion para borrar el texto dando un efecto de parpadeo para comenxar a alvertirle al jugador para advertir que la vida esta apunto de finalizar
	mov eax, ColorAdvertenciaVida                                     ;te traen los colores destinados en a la advertencia y se guardan en el registro eax
	cmp vidaAdvertenciaBarra, 1                                       ;luego se compara si ya esta activo la bandera de la advertencia que el caso de hacer corrector
	je advertir                                                       ;se hiria a la seecion de ser correcto se iria a la seccion advertir
	mov eax, vidaAdvertenciaBarraColor                                ;en el caso contrario se iria a activar
	mov vidaAdvertenciaBarra, 1                                       ; luego se salta ala seccion de si advertencia
	jmp sinadvertencia 

advertir:
	mov vidaAdvertenciaBarra, 0

sinadvertencia:                                                        ; se establece  los colores a traves de metodo setTexColor
	call SetTextColor                                                  ;                                                                                                                                                                                                    
	mov dh, vidaY                                                      ;coordenadas en y Para mostrar el msj con la vida
	mov dl, vidaX                                                      ;coordenadas en y Para mostrar el msj con la vida
	call Gotoxy                                                        ;llamamos a la funcion Gotoxy por que ahi colocaremos el cursor y mostraremos el caracter
	mov edx, offset vidaMensaje                                        ;mostraremos el msj                                     ;mos
	call WriteString                                                   ;con el metodp whiteStrind
	add dl, 6                                                          ;sumamos al registro dl unas posiciones en este caso serian 6 possiciones para desplazar en x para colocar el valor entero de las vidas
	call Gotoxy                                                        ;llamamos a la funcion Gotoxy por que ahi colocaremos el cursor y mostraremos el caracter
	cmp limiteenemigoGolpeadoBandera, 0                                ; compararemos  
	je permanecer
	dec vida
	mov limiteenemigoGolpeadoBandera, 0

	
permanecer:                                                               ;etiqueta permanecer 
	mov eax, vida                                                         ; colocamos el valor actual de la vida en el registro eax escribiendolo como decimal
	call WriteDec
	ret
mostrarVida ENDP




limpiarMostrarVida PROC USES eax edx                                       ;procedimiento para morstrar vida recibe los registros eax y edx      
	mov eax, 00000000h                                                     ;establece en eax el valor en 0
	call SetTextColor                                                      ;llama a la funcion para el color del texto
	mov dh, vidaY                                                          ;posiciona el cursor para el mensaje en Y
	mov dl, vidaX                                                          ;posiciona el cursor para el mensaje en X
	call Gotoxy                                                            ;llamamos a la funcion Gotoxy por que ahi colocaremos el cursor y mostraremos el caracter
	mov edx, offset vidaresetSimbolo                                       ;se manda el desplazamiento de  vidaresetSimbolo  que son unos espacios en blanco que se establecen en edx
	call WriteString                                                       ;se llama a la funcion WriteString esto lo que haria es borrar la porcion de texto donde se muestra la vida
	ret  
limpiarMostrarVida ENDP                                                    ;finaliza el procedimiento

mostrarPuntaje PROC USES eax edx                                           ;procedimiento para mostrar el puntaje recibe los registros eax y edx
	mov eax, puntajeColor                                                  ;movemos al registro eax la configuracion de los colores del puntaje 
	call SetTextColor                                                      ;llamamos a la funcion para extablecer el color
	mov dh, puntajeY                                                       ;posiciona el cursor para el mensaje en Y
	mov dl, vidaX                                                          ;posiciona el cursor para el mensaje en X
	mov dl, puntajeX
	call Gotoxy                                                             ;llamamos a la funcion Gotoxy por que ahi colocaremos el cursor y mostraremos el caracter                                                        
	mov edx, offset puntajeMsg                                              ;movemos al reegistro edx el mensaje del puntaje
	call WriteString                                                        ;llamamos a este procedimiento para que se muestre el mensaje
	add dl, 7                                                               ;agregamos el dezplazamiento de 7 posiciones en x
	call Gotoxy                                                            
	cmp explosionBandera, 0                                                 ;comparamos si hay una explosionn de una bala con el enemigo 
	je permanecer                                                           ; explosionBandera = 0 si no existe una explosion nos hiria a la etiqueta permanecer 
	inc puntaje                                                             ; explosionBandera = 1 incrementaria el puntaje
	mov explosionBandera, 2                                                 ;movemos a explosionBandera un valor significativo que seria 2
	
permanecer:
	mov eax, puntaje                                                        ;toma el puntaje actual 
	call WriteDec                                                           ; muestra el puntaje en decimal
	ret
mostrarPuntaje ENDP                                                         ; finaliza el procedimiento


verificarVida PROC USES eax ebx edx                                         ;procedimiento para verificar la vida recibe los registros eax ebx eda
	mov eax, puntajeganador                                                 ;mueve al registro eax el puntaje ganador que es de 5
	cmp puntaje, eax                                                        ;compara el puntaje actual con el puntaje ganador en caso de ser iguales mostraria las etiquetas de ganador
	jne L4                                                                  ; en caso del que puntaje no sea igual al del puntaje ganador se iria a la etiqueta l4
	mov ebx, OFFSET ganadorEtiqueta                                         ;etiqueta de ganador
	mov edx, OFFSET ganadorPregunta                                         ;etiqueta para saber si seguira jugando
	call MsgBoxAsk                                                          ;mostrar mensje en pantalla
	cmp eax, 6	                                                            ; usuario presiona 'y'  en caso que el jugador quiera seguir 
	je L5                                                                   ; se moveria a la etiqueta l5
	mov SalirBandera, 1
	ret
	
L5:
	mov eax, vidaInicial
	mov vida, eax
	mov puntaje, 0
	ret
	
L4:	 
	cmp vida, 0                                                             ;compara la vida si es igual a 0  esto nos llevaria a la etiqueta l0
	je L0                            
	ret
	
L0:
	mov ebx, OFFSET perdedorEtiqueta                                        ;mostrariamos etiquetas al jugador de que ha perdido
	mov edx, OFFSET perdedorPregunta                                        ;mostramos etiqueta si quiere volver a jugar 
	call MsgBoxAsk                                                          ;mostrar mensajes en pantalla
	cmp eax, 6                                                              ;en caso que si pasariamos a la etiqueta L1
	je L1                                                                   
	mov SalirBandera, 1                                                     ; encambio se saldria del juego
	
L1:
	mov eax, vidaInicial                                                    ;se establece en el registro eax en valor de la vida inicial
	mov vida, eax                                                           ;se moveria esa vida inicial a la variable vida 
	mov puntaje, 0                                                          ;colocamos el puntaje
    mov BalaBandera, 0                                                      ; la bandera de bala a 0 
	ret	                                                                    ; regreamos el control al metodo main
verificarVida ENDP



ManejadorEventosTecla PROC                                                   ;procedimiento de manejador de eventos
	pushad                                                                   ;almacenamos el estado acual de los registros
	mov eax, 50                                                              ;almacenamos en el registro eax el valor de 50
	call Delay		                                                         ;cada marco tiene un timpo de  50 milisegundos.
	call ReadKey                                                             ; llamamos a este procedimiento para leer las tecla
	cmp al, 'a'                                                              ;comparamos que si escribe la tecla a
	je Izquierda                                                             ; pasamos a la etiqueta de mover ala izquierda
	cmp al, 'd'                                                              ;seleciona la letra d
	je Derecha                                                               ;pasa ala etiqueta derecha
	cmp al, ' '                                                              ;en casa de dar un espacio en blanco 
	je Fuego                                                                 ;iremos a la etiqueta Fuego 
	cmp dx, 001Bh	                                                         ;tecla ESC se dirijira a la etiqueta salir
	je Salir                
	jmp	L1                                                                   ;luego saltara ala etiqueta l1
	
Izquierda:                                                                   ;etiqueta para mover hacia la izquierda                                                            
	call ManejadorEventosTeclaIzquierda                                      ;manejado de eventos para mover hacia la izquierta en caso que se presione la letra a
	jmp L1                                                                   ; funciona como breaK
	
Derecha:                                                                     ;etiqueta para mover hacia la derecha
	call ManejadorEventosTeclaDerecha                                        ;manejado de eventos para mover hacia la derecha en caso que se presione la letra d
	jmp L1                                                                   ; funciona como un break
	
Fuego:                                                                       ;en caso que se presione la tecla de espacio 
	call ActivaBala                                                          ;llamamos ala funcion de activar bala  que permitira dibujar  una bala en la pantal
	jmp L1                                                                   ;funciona como brack
	
Salir:                                                                       ;al presionar la tecla esq 
	mov SalirBandera, 1                                                      ;cambiara la bandera de salir a 1 lo que significa que finalizara el juego
	
L1:                                                                          ;etiqueta l1
	popad                                                                    ;re establecemos el estado de todos los registros y volvemos al metodo main
	ret
ManejadorEventosTecla ENDP                                                   ;finaliza el procedimiendo 


ManejadorEventosTeclaIzquierda PROC USES eax                                 ; procedimiento para el amnejador de eventos para mover ala izquierda con la letra a
	mov al, LimitePantallaIzquierda                                          ;almacenamos en el registro al la variable LimitePantallaIzquierda 
	inc al                                                                   ;incrementamos  en una unidad
	cmp JugadorPrincipalX, al	                                             ;revisa el limite de la izquierda de la pantalla
	jbe dejar                                                                ;si no es menor que la comparacion 
	mov al, JugadorPrincipalMoverVel                                         ;significa que si se puede hacer un decremento por que el jugador se encuantra en el limite permitido de la pantalla movemos al registro al la variable
	sub JugadorPrincipalX, al                                                ;el jugador se movera a una velocidad de 2 y luego se le restara esa velocidad 
	
dejar:
	ret
ManejadorEventosTeclaIzquierda ENDP 


ManejadorEventosTeclaDerecha PROC USES eax                                   ;procedimiento para mover el jugador ala Derecha
	mov al, pantallaLimiteDerecho                                            ;movemos al registro al el limite de la pantalla que es 79
	dec al                                                                   ;decremento del limite derecho
	cmp JugadorPrincipalX, al	                                             ;verificar limite derecho
	jae quedar                                                               ; si al comparar el limite esta por encima del valor de 79 no se hace nada 
	mov al, JugadorPrincipalMoverVel                                         ;al caso contrario agregamos la velocidad al jugador que es 2
	add JugadorPrincipalX, al                                                ; a la posicion actual del jugador principal le sumamos el valor de 2
	
quedar: 
	ret                                                                      ;retorna al menu principal
ManejadorEventosTeclaDerecha ENDP 


ActivaBala PROC USES eax                                                     ; en caso que jugador presione la barra espaciadora activa balas
	cmp BalaBandera, 1                                                       ;cambia el valor de la bandera a 1 y compara si hay una bala activa 
	je dejar                                                                 ;en caso que ya esta actiiva se llama a la etiqueta dejar
	mov BalaBandera, 1                                                       ;de lo contrario cambiaremos la bandera a 1 
	mov al, JugadorPrincipalY                                                ;tomamos la posicion en y del jugador 
	dec al                                                                   ;la cual decrementamos en una unidad
	mov BalaY, al                                                            ;y se lo asignamos a la coordenada en y de la bala
	mov ViejaBalaY, al                                                       ;la variable vieja bala tomara la misma coordenada 
	mov al, JugadorPrincipalX                                                ;tomamos la posicion del jugador en x lo asignamos al registro al
	mov BalaX, al                                                            ;el valor del registro al se asigna a la variable balax
	mov ViejaBalaX, al                                                       ;y vieja bala 
dejar:
	ret                                                                       ;retorna al procedimiento principal
ActivaBala ENDP

LimpiaJugadorViejaPos PROC USES eax edx
	mov dh, ViejoJugadorY
	mov dl, ViejoJugadorX
	call LimpiaPosNegro
	mov al, JugadorPrincipalY
	mov ViejoJugadorY, al
	mov al, JugadorPrincipalX
	mov ViejoJugadorX, al
	ret
LimpiaJugadorViejaPos ENDP

LimpiaPosNegro PROC USES eax edx                                             
	mov ah, black                                                            ; se asigna al valor del color negro
	mov al, black
	call SetTextColor                                                        ; se llama ala funcion para establecer e color
	call Gotoxy                                                              ;posicionamos el cursor para escribir la cadena 
	mov edx, offset fondo                                                    ; mostramos el fondo
	call WriteString                                                         ; funcion para mostrar en la pantalla 
	ret
LimpiaPosNegro ENDP

END MAIN