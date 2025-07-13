section .bss
    buffer resb 1

section .data
    msg db 'Hello World!', 0xA;

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 13
    int 0x80
    
    
    mov esi, [esp + 4]
    
load_next_bit:

    mov al, [esi]
    cmp al, 0
    je exit
    
    mov [buffer], al
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 1
    int 0x80

    inc esi
    jmp load_next_bit

exit:
	mov eax, 1
	xor ebx, ebx
	int 0x80

