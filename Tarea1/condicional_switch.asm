section .text
global _start
; este programa representa el siguiente condicional switch
;switch (nnnn)
;{
;    case a:
;	"Es A"
;        break;
;
;    case b:
;        "Es B"
;        break;
;    case c:
;        "Es C"
;        .
;    default:
;	"Ninguno"
;}
_start:
	nnnn equ 0x44 ; declaramos una constante que sera el dato a comparar (nnnn)
	mov eax,nnnn
	cmp eax,0x00000041 ; compara registri c con el valor de la constante 
	je es_a ; son iguales salta a es_a
	cmp eax,0x00000042 ; compara registro c con la constante nnnnn
	je es_b ; si son iguales salta a es_b
	cmp eax,0x00000043 ; compara el valor del registro c con el valor de la constante nnnn
	je es_c ; si son iguales brican a es_c
	jmp ninguno ; esta instruccion representa la parte del default 

es_a:
	mov edx, len_a ; mueve el valor del largo de la cadena al registro d
        mov ecx, cad_a ; mueve el valor de la cadena al registro c 
	jmp imprimir ; salta a imprimir 

es_b: ; se repite lo que sucede en la etiqueta es_a solo cambia el valor de len_b y cad_b
	mov edx, len_b ;longitud del mensaje
        mov ecx, cad_b ; ubicacion de la cadena
	jmp imprimir
	
es_c: ;.......
	mov edx, len_c ;longitud del mensaje
        mov ecx, cad_c ; ubicacion de la cadena
	jmp imprimir

ninguno: ; .....
	mov edx, len_n ;longitud del mensaje
        mov ecx, cad_n ; ubicacion de la cadena
	jmp imprimir

imprimir: ; muestra en la salida estandar lo que se encuetra en la direccion de memoria que almacena el registro c
	mov ebx, 1 ;descriptor de archivo
        mov eax, 4 ; numero de llamada
        int 0x80

salir:
	mov eax, 1; termina el programa haciendo una llamada al systema 
	int 0x80 

section .data
        cad_a: db 'Es A',0xa
        len_a: equ $ - cad_a
        cad_b: db 'Es B',0xa
        len_b: equ $ - cad_b
        cad_c: db 'Es C',0xa
        len_c: equ $ - cad_c
        cad_n: db 'Ninguno',0xa
        len_n: equ $ - cad_n
