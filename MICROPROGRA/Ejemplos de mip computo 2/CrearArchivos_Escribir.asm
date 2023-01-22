; crear un archivo y escribir en el 




INCLUDE MIP115.inc
;variablea
TAMANIO_BUFFER = 501  ;declaramos una constante establemos el valor de 501 la cadena de caracteres puede al final un idicador que ha finalizados el conjuntos de caracteres
.data
buffer BYTE TAMANIO_BUFFER DUP(?); lo dejamos indefinido al conjunto de elementos en la memoria
nombrearchivo BYTE "output.txt",0 ;nombre del archivo
manejadorArchivo HANDLE ? ;llevar el control del manejador del archivo
tamanioCadena DWORD ?  ;controlar el tamano de la cadena de caracteres
escribirBytes  DWORD ? ;para saber cuantos bytes se van a escribir
cadena1 BYTE "no se puede crear el archivo",0DH,0AH,0
cadena2 BYTE "BYtes escritos exitosamente en archivo output.txt",0
cadena3 BYTE "ingrese un maximo de 500 caracteres y presione enter",0
        BYTE "[enter]",0DH,0AH,0

.code
main PROC 
;primer paso para crear un archivo 
mov edx,OFFSET nombrearchivo   ; mobemos al registro edx el desplazamiento donde esta el nombre del archivo
call CreateOutputFile
mov manejadorArchivo , eax ; al llamar a la funcion create deja el manejador en el registro eax

cmp eax, INVALID_HANDLE_VALUE
jne archivo_listo
mov edx,OFFSET cadena1
call WriteString
jmp salir

archivo_listo:
mov edx,OFFSET cadena3
call WriteString
mov ecx,TAMANIO_BUFFER
mov edx, OFFSET buffer
call ReadString 
mov tamanioCadena, eax
;mNEJador de archivo
mov eax, manejadorArchivo
mov edx, OFFSET buffer
mov ecx, tamanioCadena
call WriteToFile ;este procedimiento requiere especificacion  
mov escribirBytes, eax
call CloseFile
mov edx,OFFSET cadena2
call WriteString
mov eax, escribirBytes
call WriteDec
call CrLf
salir:
exit
main ENDP
END main
