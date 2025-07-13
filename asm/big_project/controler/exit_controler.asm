section .data
    exit_string db 'Exiting', 0

section .text
    global exit_controler
    extern println_n
    extern str_len

exit_controler:
    push esi
    mov esi, exit_string
    mov eax, esi
    call str_len
    mov ebx, eax
    mov eax, esi
    call println_n
    mov eax, 0
    pop esi
    ret
