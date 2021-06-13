%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY


LengthLoop: 
    
    xor al, al
    mov al ,[ esi + ecx-1 ] ;preiau in registrul al fiecare litera din plaintext
    xor al ,[edi + ecx - 1] ;realizez xor cu fiecare litera oferita in key
    mov [ edx + ecx-1 ] , al ;completez in ciphertext fiecare liera obtinuta si stocata in al
    
loop LengthLoop

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY