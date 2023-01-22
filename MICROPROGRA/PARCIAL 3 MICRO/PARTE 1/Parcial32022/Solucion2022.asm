ExitProcess proto 
ReadInt64 proto   
ReadString proto 
WriteString proto
WriteHex64 proto  
ReadInt64  proto 
Crlf proto        
WriteInt64 proto  
Gotoxy  proto   
SetConsoleTextAttribute proto
GetStdHandle proto
Randomize proto
RandomRange proto
EsMemoMAX =5;MAXIMO DE LETRAS
.data
 palabra  BYTE  "Adivina la vocal que generé ",0
ganaste  BYTE "ganaste",0
perdiste BYTE "perdiste",0  
regresar BYTE "si desea regresar preione S o s y  presione r para salir",0
memoria   BYTE   EsMemoMAX+1 DUP(0)           
VariableOpcion BYTE   EsMemoMAX+1 DUP(0)       
VariableOpcion2  BYTE  EsMemoMAX+1 DUP(0)     
VariableOpcion3   BYTE EsMemoMAX+1 DUP(0)
tamemo  DWORD  ?                             
X  byte 0
.code
main proc   
mostrar:
leer:                                       
lea rdx, palabra                           
    call WriteString                       
	lea rdx, memoria                       
    mov rcx, SIZEOF memoria                
    call ReadString                        
	mov tamemo,eax                       
    cmp tamemo,5                             
   jae  leer 
   mov ecx,tamemo                             
  mov	rsi,0                                  
  validacadena:
     cmp memoria[rsi],'A'                  
	 jb leer                               
	cmp memoria[rsi],'E'                
	 ja leer
  cmp memoria[rsi],'I'                
	 ja leer
	 cmp memoria[rsi],'O'                
	 ja leer
cmp memoria[rsi],'U'                
	 ja leer
	; inc rsi
loop validacadena
comprobar:
cmp memoria[rsi],'A'   
 mov rdx,offset ganaste             
call WriteString
call Crlf 
mov rdx,offset regresar               
call WriteString                    
mov rdx, offset VariableOpcion      
mov rcx, SIZEOF VariableOpcion       
call ReadString
cmp VariableOpcion ,'S'               
jne leer 
cmp VariableOpcion ,'s'               
jne leer 
cmp VariableOpcion ,'r' 
jne salir
cmp memoria[rsi],'E'   
 mov rdx,offset ganaste             
call WriteString
call Crlf 
mov rdx,offset regresar               
call WriteString                    
mov rdx, offset VariableOpcion      
mov rcx, SIZEOF VariableOpcion       
call ReadString
cmp VariableOpcion ,'S'               
jne leer 
cmp VariableOpcion ,'s'               
jne leer 
cmp VariableOpcion ,'r' 
jne salir
cmp memoria[rsi],'I'   
 mov rdx,offset ganaste             
call WriteString
call Crlf 
mov rdx,offset regresar               
call WriteString                    
mov rdx, offset VariableOpcion      
mov rcx, SIZEOF VariableOpcion       
call ReadString
cmp VariableOpcion ,'S'               
jne leer 
cmp VariableOpcion ,'s'               
jne leer 
cmp VariableOpcion ,'r' 
jne salir
cmp memoria[rsi],'O'   
 mov rdx,offset ganaste             
call WriteString
call Crlf 
mov rdx,offset regresar               
call WriteString                    
mov rdx, offset VariableOpcion      
mov rcx, SIZEOF VariableOpcion       
call ReadString
cmp VariableOpcion ,'S'               
jne leer 
cmp VariableOpcion ,'s'               
jne leer 
cmp VariableOpcion ,'r' 
jne salir
cmp memoria[rsi],'U'   
 mov rdx,offset ganaste             
call WriteString
call Crlf 
mov rdx,offset regresar               
call WriteString                    
mov rdx, offset VariableOpcion      
mov rcx, SIZEOF VariableOpcion       
call ReadString
cmp VariableOpcion ,'S'               
jne leer 
cmp VariableOpcion ,'s'               
jne leer 
cmp VariableOpcion ,'r' 
jne salir
salir:
mov ecx,0
call ExitProcess
ret
main endp
end