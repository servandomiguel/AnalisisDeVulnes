section .text
global _start

;Realiza un proceso similar a el cifrado con la diferencia de que este sucede
;en sentido contrario, esto con la finalidad de llegar a la palabra que se 
;ingreso en cifrado, a traves de la salida de cifrado y la ejecucion de
; este programa

_start:

	
	mov edx, 0x04 ; limite del for 
	mov ebx, 0x00 ; inicio del for
	
	mov eax,[DATO] 
	xor eax,0xFD145A39
	mov [DATO],eax
	
corr_d:
	cmp edx,ebx ; compara registri d con b
	jle invertir ; si d <= b salta a salir
	add ebx,0x01 ; suma 1 a ebx
	mov eax,[DATO]
	shr eax,1
	pushf
	pop ecx
	and ecx,0x0000001
	shl ecx,31
	or eax,ecx
	mov [DATO],eax	
	jmp corr_d
invertir:
	mov eax,[DATO]
	sub eax,0x10
	not eax
	mov [DATO],eax
	


	mov edx, 0x0A ; limite del for 
	mov ebx, 0x00 ; inicio del for

corr_i:
	cmp edx,ebx ; compara registri d con b
	jle salir ; si d <= b salta a salir
	add ebx,0x01 ; suma 1 a ebx
	mov eax,[DATO]
	shl eax,1
	pushf
	pop ecx
	and ecx,0x0000001
	or eax,ecx
	mov [DATO],eax	
	jmp corr_i ; brinca a compara





salir:
	mov eax, 1; termina el programa haciendo una llamada al sistema 
	int 0x80 

section .data
	DATO DD 0x27d53385
