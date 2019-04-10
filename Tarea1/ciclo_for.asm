section .text
global _start
; este programa representa el siguiente ciclo for
;for(i = 0 ; i < 10 ; i++)
_start:
	mov edx, 0x0A ; limite del for 
	mov ebx, 0x00 ; inicio del for
compara:
	cmp edx,ebx ; compara registro d con b
	jle salir ; si d <= b salta a salir
	add ebx,0x01 ; suma 1 a ebx
	jmp compara ; brinca a compara, es decir queda en el ciclo 
salir:
	mov eax, 1; termina el programa haciendo una llamada al sistema 
	int 0x80 
