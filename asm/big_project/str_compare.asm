section .data:
    not_equal_string db 'NOT_EQUAL', 0xA, 0
    equal_string db 'EQUAL', 0xA, 0

section .text:
    global str_cmp
    global cmp_print
    extern println_n
    extern print_n

; ----------
; Input: EAX - adress of a string, EBX - adress of a string, ECX - len of a string
; Output: 1 or 0 returned in EAX if the string are equal or not
; Clobbered: EAX, EBX, ECX
; ----------
str_cmp:
    push esi
.loop_cmp:
    cmp ecx, 0x0
    je .equal_ret
    dec ecx
    mov edx, [eax]
    mov esi, [ebx]
    and edx, 0xFF
    and esi, 0xFF
    cmp esi, edx
    jne .not_equal_ret
    inc eax
    inc ebx
    jmp .loop_cmp
.end_compare:
    cmp ebx, 0x0
    jne .not_equal_ret
.equal_ret:
    mov eax, 1
    jmp .end_cmp
.not_equal_ret:
    mov eax, 0
.end_cmp:
    pop esi
    ret

; ----------
; Input: EAX - adress of a string, EBX - adress of a string, ECX - len of a string
; Output: A EQUAL or NOT EQUAL text printed if the strings are equal or not
; ----------
cmp_print:
    call str_cmp
    cmp eax, 1
    je .equal_print
.not_equal_print:
    mov eax, not_equal_string
    mov ebx, 10
    call print_n
    jmp .end_print
.equal_print:
    mov eax, equal_string
    mov ebx, 6
.end_print:
    call print_n
    ret
    
