%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
   	mov     ecx, [ebp + 16]     ; length
   
   
	;; DO NOT MODIFY
	
	mov edi , 0 ;
	xor eax,eax
	xor bl,bl

	sub ecx,4

EndOfString:				;Calculam unde trebuie sa punem terminatorul de sir

	cmp ecx,24		
	jg End7
	cmp ecx,20
	jg End6
	cmp ecx,16
	jg End5
	cmp ecx,12
	jg End4
	cmp ecx,8
	jg End3
	cmp ecx,4
	jg End2
	cmp ecx,0
	jg End1

End7:			
	mov eax,10
	mov [edx+8] , eax
	jmp Start
End6:
	mov eax,10
	mov [edx+7] , eax
	jmp Start
End5:
	mov eax,10
	mov [edx+6] , eax
	jmp Start
End4:
	mov eax,10
	mov [edx+5] , eax
	jmp Start
End3:
	mov eax,10
	mov [edx+4] , eax
	jmp Start
End2:
	mov eax,10
	mov [edx+3] , eax
	jmp Start
End1:
	mov eax,10
	mov [edx+2] , eax
	jmp Start



Start:

mov     ecx, [ebp + 16]

Iteration:
	
	cmp ecx , 0  			;Registru care ne inidica ca textul s-a terminat
	jle Convertor

	cmp edi,4 				;Refistrul care ne indica cand am selectat secventa de 4 biti si ne ajuta 
	jge Convertor			;sa stim si ce putere a lui 2 trebuie adaugata 

	mov al , [esi + ecx - 1];Se extrage elementul din sirul bianr pt a vedea daca e 1 sau 0 

	cmp al , 49 			;Daca elemtul extras este egal cu 49 asta inseamna ca acesta este un 1 
	je Addition				;trebuie sa adugam la suma noastra 

	inc edi

	loop Iteration	


Addition:					;In functie de pozitia la care ne aflam in secventa de 4 biti trebuie sa adugam o putere a lui 2 

	cmp edi,0
	je Addition1

	cmp edi,1
	je Addition2

	cmp edi,2
	je Addition3

	cmp edi,3
	je Addition4


Addition1:
	
	cmp eax , 48			;In cazul in care nu este o secveta completa si sirul incepe cu 0
	je Convertor

	add bl,1
	inc edi
	dec ecx
	jmp Iteration

Addition2:
	
	cmp eax , 48 			;In cazul in care nu este o secveta completa si sirul incepe cu 0
	je Convertor

	add bl,2
	inc edi
	dec ecx
	jmp Iteration


Addition3:
	
	cmp eax , 48  			;In cazul in care nu este o secveta completa si sirul incepe cu 0
	je Convertor

	add bl,4
	inc edi
	dec ecx
	jmp Iteration


Addition4:
	
	cmp eax , 48			;In cazul in care nu este o secveta completa si sirul incepe cu 0
	je Convertor

	add bl,8
	inc edi
	dec ecx
	jmp Iteration

Convertor:
	
	cmp bl,9				;Se compara cu 9 pentru a stii in ce caz suntem si anume cifre sau litere 
	jg ConvertorLetters

ConvertorNr:			
	
	add bl,48				;Pentru transformarea in Ascii a unui numar se adauga 48 (este 0 in Ascii) 
	
	cmp ecx ,0 				;Ne asiguram daca am ajuns la finalul secventei bianre sau nu 
	jle Final

	jmp Done

ConvertorLetters:		
	
	add bl,55 				;Pentru transformarea in Ascii a unui numar in Litere se adauga 55 
							;(numerele incep de la 10 si A este primul element care este 65 in Ascii)
	cmp ecx ,0 				;Ne asiguram daca am ajuns la finalul secventei bianre sau nu
	jle Final

Done:						;Cu ajutorul indicatorului care are in vedere secventa binara punem 
							;rezultatul obtinut pe pozitia corespunzatoare
	cmp ecx,24
	jg Poz7
	cmp ecx,20
	jg Poz6
	cmp ecx,16
	jg Poz5
	cmp ecx,12
	jg Poz4
	cmp ecx,8
	jg Poz3
	cmp ecx,4
	jg Poz2
	cmp ecx,0
	jg Poz1

			

Poz7:

	
	mov [edx+7] , bl

	xor ebx,ebx
	xor edi,edi
	jmp Iteration

Poz6:

	
	mov [edx+6] , bl

	xor ebx,ebx
	xor edi,edi
	jmp Iteration

Poz5:
	
	
	mov [edx+5] , bl

	xor ebx,ebx
	xor edi,edi
	jmp Iteration

Poz4:

	
	mov [edx+4] , bl

	xor ebx,ebx
	xor edi,edi
	jmp Iteration

Poz3:
	
	
	mov [edx+3] , bl

	xor ebx,ebx
	xor edi,edi
	jmp Iteration
			
Poz2:
	
	mov [edx+2] , bl

	xor ebx,ebx
	xor edi,edi
	jmp Iteration

Poz1:

	mov [edx+1] , bl

	xor ebx,ebx
	xor edi,edi
	jmp Iteration




Final:

	xor eax,eax
	mov [edx] , bl
	
    ;; TODO: Implement bin to hex

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY