section .note.GNU-stack

section .data
    data db 'I am %d old', 0xA, 0
    age dd 23

section .text
    global main
    extern printf

main:
    push dword [age]
    push dword data
    
    call printf
    add esp, 8
    
    mov eax, 0
    ret
