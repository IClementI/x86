section .note.GNU-stack

section .data
    hello_string db 'Hello World', 0xA, 0
    new_line db 0xA
    value dd 7

section .bss
    number resd 1
    
section .text
    global main

main:
    mov eax, 4
    mov ebx, 1
    mov ecx, hello_string
    mov edx, 12
    int 0x80
    
    ;mov eax, 98
    ;call print_number_99
    ;call print_ln
    
    ;mov eax, 400
    ;mov ebx, 2
    ;call get_div_10_pow_n
    ;push eax
    ;call print_number
    ;call print_ln
    ;pop eax
    
    mov eax, 4758
    call print_n
    
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Input: eax, Output: eax printed as ASCII
print_number:
    add eax, '0'
    mov [number], eax
    
    mov eax, 4
    mov ebx, 1
    mov ecx, number
    mov edx, 1
    int 0x80
    ret

; Input: eax, Output: eax/10 in eax
get_div_10:
    mov ecx, 10
    xor edx, edx
    div ecx
    ret

; Input: eax, output eax printed. Input must be inferior to 99
print_number_99:
    call get_div_10
    push edx
    call print_number
    pop edx
    mov eax, edx
    call print_number
    
    ret

; Input: eax, ebx | Output: eax/(10 power ebx) in eax
get_div_10_pow_n:
    push eax
    mov eax, 10
    call pow
    mov ecx, eax
    pop eax
    xor edx, edx
    div ecx
    ret
    
; Input: eax, ebx | Output: eax power ebx in eax
pow:
    mov ecx, eax
    cmp ebx, 0
    jne pow_loop
    mov eax, 1
    ret
pow_loop:
    dec ebx
    cmp ebx, 0
    je exit_pow
    mul ecx
    jmp pow_loop
exit_pow:
    ret

print_ln:
    mov eax, 4
    mov ebx, 1
    mov ecx, new_line
    mov edx, 1
    int 0x80
    ret
    
; Input: eax | Output: eax printed
print_n:
    mov ebx, 7
.print_n_loop:
    cmp ebx, -1
    je end_print_n
    push ebx
    call get_div_10_pow_n
    push edx
    call print_number
    pop edx
    pop ebx
    mov eax, edx
    dec ebx
    jmp print_n_loop
.end_print_n:
    call print_ln
    ret
    
p_n:
    mov ecx, 7
.loop:
    
