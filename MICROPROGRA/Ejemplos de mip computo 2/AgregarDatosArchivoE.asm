INCLUDE MIP115.inc
.data
buffer BYTE "ESTE ES EL TEXTO A AGREGAR",0dh,0ah
bufferTamanio DWORD ($-buffer)
error BYTE "no se puede abrir el archivo",0dh,0ah,0
nombrearchivo BYTE "output.txt",0
manejadorArchivo HANDLE ?
bytesEscribir DWORD ?

.code

main PROC

INVOKE CreateFile,
ADDR nombrearchivo,GENERIC_WRITE,DO_NOT_SHARE,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0; CONJUNTO DE PARAMETROS 

mov manejadorArchivo, eax
.IF eax ==INVALID_HANDLE_VALUE
mov edx, OFFSET error
call WriteString
jmp salirAhora
.ENDIF

INVOKE SetFilePointer,manejadorArchivo,0,0,FILE_END


INVOKE WriteFile, manejadorArchivo,ADDR buffer,bufferTamanio, ADDR bytesEscribir,0

INVOKE CloseHandle,manejadorArchivo

salirAhora:
exit 



main ENDP
END main