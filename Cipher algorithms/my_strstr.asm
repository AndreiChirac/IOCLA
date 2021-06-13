%include "io.mac"

section .text
    global my_strstr
    extern printf

section .data
    literaNeedle DB 0
    lungimeHaystack DD 0
    lungimeNeedle DD 0

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    mov dword [lungimeHaystack], ecx
    ;; DO NOT MODIFY

    ;; TO DO: Implement my_strstr
start:
    cmp ecx, 0
    je notFound
    mov al, [esi + ecx - 1]
    mov dword [literaNeedle], ebx
    cmp al, byte [literaNeedle]
    je searchOthers
    jmp goFurther

searchOthers:
    cmp edx, 0
    je finish
    mov dword [lungimeNeedle], edx
    dec ecx
    dec edx
    mov al, [esi + ecx - 1]
    mov byte [literaNeedle], [ebx + edx - 1]
    cmp al, byte [literaNeedle]
    je searchOthers

goFurther:
    dec ecx
    jmp start

notFound:
    mov ecx, dword [lungimeHaystack]

finish:
    mov edi, ecx

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY