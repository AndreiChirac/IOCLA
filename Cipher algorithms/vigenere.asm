%include "io.mac"

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY


ModifKey:                       ;Modiicam key astfel incat sa putem realiza o aduanre directa 
    
    xor eax,eax

    cmp ebx , 0 
    jle done

    mov al , [edi + ebx -1 ]    
    sub al,65 ;                 ;Fiecare element este o litera mare astfel daca scadem a vom avea o cheia din pozitiile de deplasare
    mov [edi + ebx -1 ] , al

    dec ebx    

    loop ModifKey

done :

    xor ebx , ebx 
    xor ecx , ecx

Ciphertext:
   
    cmp ecx , [ebp + 16]        ;Trebuie sa tinem cont de punctul in care se incheie textul 
    jge final 

    cmp ebx , [ebp + 24]        ;Stim ca in momentul in care acest registu a luat sfarsit trebuie sa luam cheai de la inceput
    jge done2


    mov al , [esi + ecx ] ;; Incarc literele din text

    cmp al , 65
    jl NonLetter
    cmp al , 90
    jg GreaterThanZ

    add al , [edi + ebx]

    cmp al,90
    jg ZLetterReduction

    mov [edx + ecx] , al 

    inc ebx
    inc ecx    

    jmp Ciphertext


done2:
    xor ebx,ebx
    jmp Ciphertext

NonLetter:
    
    mov [ edx + ecx ] , al
    inc ecx
    jmp Ciphertext   


GreaterThanZ :
    
    cmp al , 97
    jl NonLetter
    jmp GreaterThanz

GreaterThanz :

    cmp al , 122
    jg NonLetter
    jmp SmallLetters

SmallLetters:
    
    add al , [edi + ebx]
    cmp ax , 122
    jle LetterPut
    
    jmp zLetterReduction


ZLetterReduction:        
    
    sub al , 26
    cmp al ,90
    jle LetterPut
    
    loop ZLetterReduction

zLetterReduction:

    
    sub al , 26
    cmp al ,122
    jle LetterPut

    loop zLetterReduction


LetterPut:

    mov [ edx + ecx ] , al
    
    inc ebx
    inc ecx
    
    jmp Ciphertext


final:
    ;; TODO: Implement the Vigenere cipher

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY