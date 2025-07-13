section .data
    prologue db 'Hello User', 0xA, 0
    input_text db 'Please enter a command:', 0xA, 0
    list_command db 'Available commands are Reverse, Compare, Len and Add', 0xA, 0
    exit_text db 'End of the game', 0xA, 0

section .bss
    buffer_input resb 64

section .text
    global input_nice
    global get_input_n
    extern print_n
    
; ----------
; Input: EAX - adress of a buffer, EBX - Len of buffer
; Output: input stored in a buffer of size EBX and of adress EAX
; Clobbered: EAX, EBX
; ---------
input_nice:
    push eax
    push ebx
    mov eax, input_text
    mov ebx, 24
    call print_n
    
    pop ebx
    pop eax
    call get_input_n
    ret

; ---------
; Input: EAX - adress of a buffer, EBX - len of the buffer
; Output: Input of len EBX stored in EAX
; Clobbered: EAX, EBX
; ---------
get_input_n:
    mov ecx, eax
    mov edx, ebx
    mov eax, 3
    mov ebx, 0
    int 0x80
    ret
