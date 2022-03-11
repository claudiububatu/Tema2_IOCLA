; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .data
    len DD 1
    date_size DD 1

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    mov [len], edx
    mov ebx, 0
    xor edx, edx

nume:
    mov eax, [esi + my_date.year]
    mov edx, [edi + ebx * 8 + my_date.year]
    neg edx
    add eax, edx

    ; luna nasterii mai mare decat luna curenta

    mov dx, [esi + my_date.month]

    cmp [edi + ebx * 8 + my_date.month], dx

    jg bigger

    ; luna nasterii mai mica decat luna curenta
    
    cmp [edi + ebx * 8 + my_date.month], dx

    jl lower

    ; ziua nasterii mai mica decat ziua curenta
    xor dx, dx
    ; mut in dx ziua curenta
    mov dx, [esi + my_date.day]

    ; compar ziua in care s-a nascut cu ziua curenta
    cmp [edi + ebx * 8 + my_date.day], dx

    jle lower

unborn:
    cmp eax, 0
    je lower

bigger:
    ; scad 1 la diferenta dintre ani
    add eax, -1

lower:
    mov [ecx + 4 * ebx], eax
    inc ebx
    cmp [len], ebx
    jg nume

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
