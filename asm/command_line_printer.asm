section .note.GNU-stack

section .data
    fmt db 'Begin, %d',  0xA, 0
    value dd 42
        
section .text
    global main
    extern printf
    
main:
    push dword [value]
    push dword fmt
    
    call printf
    add esp, 8
    
    mov eax, 0
    ret
