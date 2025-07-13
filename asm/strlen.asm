section .note.GNU-stack

section .data:
    begin db 'Begin', 0xA, 0
    new_line db 0xA
    end db 'End', 0xA, 0

section .bss
    buffer_in resb 64
    result resd 1

section .text
    global main

main:
    mov eax, begin
    mov ebx, 6
    call print_n
    
    call read_input
    
    call count
    add eax, '0'
    mov [result], eax
    mov eax, result
    mov ebx, 1
    call print_n
    
    mov eax, new_line
    mov ebx, 1
    call print_n
    
    mov eax, buffer_in
    mov ebx, 64
    call print_n
    call exit

; Input: None | Output: data writen buffer_in 
read_input:
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer_in
    mov edx, 64
    int 0x80
    ret

; Input: eax, ebx | Output: print eax for ebx bytes
print_n:
    mov ecx, eax
    mov edx, ebx
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret
    
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

count:
    mov eax, 0
    mov ebx, buffer_in
    
.count_loop:
    mov ecx, [ebx]
    and ecx, 0x00FF
    cmp ecx, 0xA
    je .end_count
    inc eax
    inc ebx
    jmp .count_loop
.end_count:
    ret
