LEN_BUFFER equ 1

section .data
    add_input1 db 'Please enter a first number:', 0
    add_input2 db 'Please enter a second number:', 0
    add_result db 'Result:', 0
    
section .bss
    buffer_input1 resb LEN_BUFFER
    buffer_input2 resb LEN_BUFFER
section .text
    global add_controler
    extern print_n
    extern println_n
    extern str_len
    extern get_input_n
    extern add_char
    extern println_number

; ----------
; Input: None
; Output: Add controler
; ----------
add_controler:
    push esi
    mov esi, add_input1
    mov eax, esi
    call str_len
    mov ebx, eax
    mov eax, esi
    call println_n
    
    mov eax, buffer_input1
    mov ebx, LEN_BUFFER + 1
    call get_input_n
    
    mov esi, add_input2
    mov eax, esi
    call str_len
    mov ebx, eax
    mov eax, esi
    call println_n
    
    mov eax, buffer_input2
    mov ebx, LEN_BUFFER + 1
    call get_input_n
    
    mov eax, buffer_input1
    mov eax, [eax]
    and eax, 0xFF
    mov ebx, buffer_input2
    mov ebx, [ebx]
    and ebx, 0xFF
    call add_char
    
    push eax
    
    mov esi, add_result
    mov eax, esi
    call str_len
    mov ebx, eax
    mov eax, esi
    call println_n
    
    pop eax
    call println_number
    
    pop esi
    mov eax, 1
    ret
