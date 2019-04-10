section .text
global _start


_start:
	mov edx, 0x0A ; limite del for 
	mov ebx, 0x00 ; inicio del for

corr_d: ; se utiliza un for para realizar la rotacion n(10) veces
	cmp edx,ebx ; compara el registro d con b
	jle invertir ; si d <= b salta a salir
	add ebx,0x01 ; suma 1 a ebx
	mov eax,[DATO] ;movemos el valor de DATO a el reg A 
	shr eax,1 ; Rotamos hacia la derecha
	pushf ; guardamos el estado del registro de banderas
	pop ecx ; recuperamos el estado y lo metemos en el reg C
	and ecx,0x0000001 ; nos quedamos unicamente con la bandera CF
	shl ecx,31 ; la movemos a el bit mas significativo
	or eax,ecx ; juntamos el CF con el registro corrido, esto para no perder datos
	mov [DATO],eax	 ; guardamos en DATO el resultado de la rotacion
	jmp corr_d ; brinca a compara

invertir: ; se realizan dos operaciones para aumentar la seguridad del cifrado
	mov eax,[DATO] ; se mueve DATO al reg A
	not eax ; not al registro A
	add eax,0x10 ; add de 0x10 al reg A
	mov [DATO],eax ; guarda el resultado de las operaciones en DATO
	


	
	mov edx, 0x04 ; limite del for 
	mov ebx, 0x00 ; inicio del for
corr_i: ; El mismo procedimiento que en corr_d con un cambio en el sentido de la rotacion
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
	jmp corr_i	
salir:
	mov eax,[DATO] 
	xor eax,0xFD145A39 ; se realiza XOR entre el reg A y una llave
	mov [DATO],eax
	mov eax, 1; termina el programa haciendo una llamada al sistema 
	int 0x80 

section .data
	DATO DD 0x4FA5D0C9
