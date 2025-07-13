LEN_BUFFER equ 128

section .data
    str_len_string db 'Please enter a string to measure:', 0xA, 0
    
    str_len_output_string db 'The len of the string is ', 0
    
    buffer_input db LEN_BUFFER dup(0)
    
section .text
    global str_len_controler
    extern get_input_n
    extern print_improved
    extern print_number
    extern print_new_line
    extern str_len

str_len_controler:
    mov eax, str_len_string
    call print_improved

    mov eax, buffer_input
    mov ebx, 127
    call get_input_n
    
    mov eax, buffer_input
    call str_len
    push eax
    
    mov eax, str_len_output_string
    call print_improved
    
    pop eax
    dec eax
    call print_number
    call print_new_line
    ret
