%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    
    mov ebx , edi               ;Stocam in acest registru key 

    jmp Keydecrease


decrease: 
    sub bl,26    

Keydecrease:
    
    cmp bl,26                   ;Stim faptul ca alfabetul are daor 26 de litere asa ca o cheie mai mare   
    jg decrease                 ;de acest numar doar va produce reluarea alfabetului astfel o micsoram 
    

TestLetter:
    
    cmp ecx , 0                 ;Ne asiguram ca , cu ajutorul lui ecx nu vom mai testa 
    je done                     ;litere deoarece deja am parcurs tot textul
     

    xor eax,eax                
    
    mov al , [ esi + (ecx-1) ]  ;Preluam primul caracter din text
    
    
    cmp al , 65                 ;65 este codul Ascii pentru litera "A" astfel in cazul in care caracterul provenit 
    jl NonLetter                ;este mai mic inseamna ca nu este o litera si trebuie sa o omitem
    cmp al , 90                 ;90 este codul Ascii pentru litera "Z" astfel in cazul in care caracterul provenit
    jg GreaterThanZ             ;este mai mare inseamna ca acesta poate fi o litera mica sau un simbol 
    

    add al , bl                 ;Ne aflam in cazul in care in registrul al se afla o litera mare astfel adaugam cheia
        
    cmp al,90                   ;Reevaluam situatia in care ne aflam daca numarul este mai mare de 90 asta inseamna
    jg ZLetterReduction         ;ca trebuie sa luam literele mari de la inceput

    mov [ edx + (ecx-1) ] , al  ;In cazul in care dupa adunare am ramas in cadrul literelor putem sa pune in textulcriptat 
    loop TestLetter             ;litera obtinuta


done :

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

NonLetter:                      ;Ne aflam in cazul in care caracterul nu este o litera astfel ca nu trebuie criptat                  
    
    mov [ edx + (ecx-1) ] , al
    dec ecx
    jmp TestLetter   


GreaterThanZ :                  ;Ne aflam in cazul in care caracter poate fi o litera mare sau un simbol nedorit
    
    cmp al , 97                 ;Cunoastem ca litera "a" este reprezentata in ascii de 97 si in ac timp stim si 
    jl NonLetter                ;ca ce se afla in registru este mai mare decat "A",astfel daca rezultatul din registru 
    jmp GreaterThanz            ;nu este o litera mica trebuie sa-l omitem , daca este mai mare de 97 nu suntem siguri inca
                                ;daca este o liter mica sau un simbol cu codul ascii mai mare de 97

GreaterThanz :                  ;Ne aflam in cazul in care caracter poate fi o litera mica sau un simbol nedorit

    cmp al , 122                ;Cunoastem ca liter "z" este 122 astfel daca codul Asciieste mai mare decat aceasta valoare
    jg NonLetter                ;stim ca nu este o liter si trebuie sa sarim peste . Automat trecem in cazul in care avem o litera mica

SmallLetters:
    
    add al , bl                 ;Se realizeaza adunarea cu cheia iar apoi daca rezultatul obtinut este tot o litera mica 
    cmp ax , 122                ;putem sa scriem in ciphertext litera obtinut
    jle LetterPut
    
    jmp zLetterReduction        ;Daca rezultatul a trecut de "z" trebuie sa reluam alfabetul literelor mici


ZLetterReduction:               ;Ne aflam in cazul in cazul in care litera pe care trebuie sa o obtinem este litera mica
    
    sub al , 26
    cmp al ,90                  ;Daca am obtiunt litera mare o punem in ciphertext
    jle LetterPut
    
    loop ZLetterReduction

zLetterReduction:               ;Ne aflam in cazul in cazul in care litera pe care trebuie sa o obtinem este litera mica

    
    sub al , 26
    cmp al ,122                 ;Daca am obtiunt litera mica o punem in ciphertext
    jle LetterPut

    loop zLetterReduction


LetterPut:

    mov [ edx + (ecx-1) ] , al
    dec ecx
    jmp TestLetter



