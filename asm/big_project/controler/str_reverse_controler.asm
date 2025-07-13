LEN_INPUT equ 128

section .data
    str_input db 'Please enter a string to reverse:', 0
    str_result db 'Result:', 0
    
section .bss
    buffer_input resb LEN_INPUT
    buffer_output resb LEN_INPUT

section .text
    global str_reverse_controler
    extern println_n
    extern print_n
    extern str_len
    extern str_reverse
    extern get_input_n

; ----------
; Input: None
; Output: Str_reverse controler
; ----------
str_reverse_controler:
    push esi
    mov esi, str_input
    mov eax, esi
    call str_len
    mov ebx, eax
    mov eax, esi
    call println_n

    mov eax, buffer_input
    mov ebx, LEN_INPUT
    call get_input_n
    
    mov eax, buffer_input
    mov ebx, buffer_output
    call str_reverse
    
    mov esi, str_result
    mov eax, esi
    call str_len
    mov ebx, eax
    mov eax, esi
    call print_n
    
    mov eax, buffer_output
    mov ebx, 128
    call print_n
    
    pop esi
    
    mov eax, 1
    ret
