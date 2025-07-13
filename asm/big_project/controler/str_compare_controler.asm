LEN_INPUT equ 128

section .data
    str_input1 db 'Please enter a first string:', 0xA, 0
    str_input2 db 'Please enter a second string:', 0xA, 0
    str_result db 'Result:', 0
    
section .bss
    buffer_input1 resb LEN_INPUT
    buffer_input2 resb LEN_INPUT
    buffer_output resb LEN_INPUT

section .text
    global str_compare_controler
    extern println_n
    extern print_n
    extern str_len
    extern get_input_n
    extern print_improved
    extern cmp_print

; ----------
; Input: None
; Output: Str_compare controler
; ----------
str_compare_controler:

    mov eax, str_input1
    call print_improved

    mov eax, buffer_input1
    mov ebx, LEN_INPUT
    call get_input_n
    
    mov eax, str_input2
    call print_improved

    mov eax, buffer_input2
    mov ebx, LEN_INPUT
    call get_input_n
    
    mov eax, buffer_input1
    mov ebx, buffer_input2
    mov ecx, LEN_INPUT
    call cmp_print
    
    mov eax, 1
    ret
