INCLUDE MIP115.inc
LETRA = 239     		; LETRAS PERIMITIDAD 1-255
EsMemoMAX = 128     	; TAMAÑO DEL BUFFER

.data
sCursor  BYTE  "INGRESE UN TEXTO: ",0
sTextEnctipt BYTE  "TEXTO CRIFRADO:          ",0
sTextDecrypt BYTE  "DESENCRIPTADO:            ",0
EsMemo   BYTE   EsMemoMAX+1 DUP(0)
EsMemoTam  DWORD  ?

.code
main PROC
	call	EntradadeString		
	call	TrasladaBuffer	
	mov	edx,OFFSET sTextEnctipt	; 
	call	MostrarMensaje
	call	TrasladaBuffer  	
	
	exit
main ENDP

;-----------------------------------------------------
EntradadeString PROC
; Recibe: nothing
; Retorna: nothing
;-----------------------------------------------------
	pushad
	mov	edx,OFFSET sCursor	; muestra el promt
	call	WriteString
	mov	ecx,EsMemoMAX		;maximo de caracteres
	mov	edx,OFFSET EsMemo   ; coloca en la direccion del buffer
	call	ReadString         	; lee el string
	mov	EsMemoTam,eax        	; guarda el tamanio
	call	Crlf
	popad
	ret
EntradadeString ENDP

;-----------------------------------------------------
MostrarMensaje PROC
;
; Recibe: EDX direccion del mensaje
; Retorna:  Nada
;-----------------------------------------------------
	pushad
	call	WriteString
	mov	edx,OFFSET EsMemo	
	call	WriteString
	call	Crlf
	call	Crlf
	popad
	ret
MostrarMensaje ENDP

;-----------------------------------------------------
TrasladaBuffer PROC
;
; Recibe: nothing
; Retorna: nothing
;-----------------------------------------------------
	pushad
	mov	ecx,EsMemoTam		; contador
	mov	esi,0			; indice a  0 en el buffer
L1:
	xor	EsMemo[esi],LETRA	; traslado de bytes
	inc	esi				; incrementa a siguiente byte
	loop	L1

	popad
	ret
TrasladaBuffer ENDP
END main
