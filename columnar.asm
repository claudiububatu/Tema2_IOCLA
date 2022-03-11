section .data
    extern len_cheie, len_haystack
    index DD -1

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    mov edx, 0

    mov cl, 0
    mov ecx, 0
    mov eax, 0
    mov dword [index], -1 ; necesar pentru ca altfel
    ; index ramanea cu valoarea de la testul precedent

column:
    ; urc eax pe stiva
    push eax

    ; mut in eax valoarea indexului
    mov eax, dword [index]
    ; initial index = -1 ; cresc eax
    inc eax
    ; salvez in index urmatoarea valoare a lui eax
    mov dword [index], eax
    
    ; chestia asta se repeta pana cand eax = len_cheie
    ; eax-ul se modifica la linia 53, de aceea il actualizez mereu cu index
    ; practic, eu pe index il compar cu len_cheie
    ; dar nu puteam sa fac comparatia direct intre ele,
    ; aveam nevoie de un registru cu care sa il compar pe len_cheie

    cmp eax, dword [len_cheie]
    ; daca eax >= len_cheie, ies din program
    jge exit

    pop eax
    
    mov eax, dword [edi + 4 * ecx]
    inc ecx
line:
    ; pornesc cu eax = edi[0]
    ; il cresc cu len_cheie pana cand eax > len_haystack
    ; daca eax > len_haystack, atunci eax = edi[1] s.a.m.d
    cmp eax, dword [len_haystack]
    jge column
    ; la inceput eax este edi[0]
    push ecx
    mov cl, [esi + eax]
    ; la inceput edx este 0
    mov [ebx + edx], cl
    pop ecx
    inc edx
    add eax, dword [len_cheie]
    jmp line


exit:
    pop eax
    ; daca a intrat aici, trebuie sa dam pop
    ; ca sa avem nr_de_pushuri = nr_de_popuri

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY