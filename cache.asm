;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .data
    addr DD 0
    offs DD 0
    cache DD 0
    iterator DD 0
    reg DB 0
section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg - valoarea pe care o gasesc in matrice [eax] = a[i][i]
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address - variabila de pe care iau offsetu, tag-value; asta se shifteaza
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE

    ; initializez toate variabilele globale cu 0
    mov dword [iterator], 0
    mov byte [reg], 0
    mov dword [cache], ecx
    mov dword [addr], edx

    ; scot offset-ul aici
    shl edx, TAG_BITS
    shr edx, TAG_BITS

    ; salvez offset-ul in offs
    mov [offs], edx

    ; salvez adresa in edx
    mov edx, [addr]
    ; aici scot tag-ul
    shr edx, OFFSET_BITS
    shl edx, OFFSET_BITS

    ; salvez indexul to_replace in ebx
    mov ebx, edi
    
    ; salvez tag-ul in edi
    mov edi, edx

    push eax

    ; salvez linia to_replace din cache in eax
    lea eax, [ecx + 8 * ebx]
forr:
    ; salvez ce se afla la adresa tag-ului + 000 in dh
    mov dh, [edi]

    ; salvez in cache ce se afla in dh
    mov byte [eax], dh
    
    ; salvez in esi offset-ul
    mov esi, dword [offs]
    
     ; vad daca am ajuns la offset
    cmp esi, dword [iterator]
    
    je equal
continue_for:
    ; crestem numarul iteratiei
    inc dword [iterator]

    ; ma duc mai departe pe coloane 
    add eax, 1

    ; cresc tag-ul cu 1
    add edi, 1

    ; vad daca iteratorul a depasit valoarea 111 = 8
    cmp dword [iterator], CACHE_LINE_SIZE

    ; daca nu, continuam cu iteratiile
    jl forr

    ; altfel, iesim din program
    jge exit2

equal:
    ; salvez in variabila reg ce se afla la adresa tag-ului + 000, 001, etc
    mov byte [reg], dh

    ; continuam for-ul
    jmp continue_for
exit2:
    pop eax

    ; salvez reg in bh
    mov bh, byte [reg]

    ; salvez bh in eax 
    mov byte [eax], bh

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


