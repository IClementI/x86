section .data
    too_long_string db 'The string you trying to reverse is too long', 0xA, 0
    
section .bss

section .text
    global str_reverse
    extern str_len
    extern print_n

; ----------
; Input: EAX - an adress of a string, EBX - adress of a buffer
; Output: Reverse EAX string into EBX
; ----------
str_reverse:
    push esi
    push eax
    push ebx
    call str_len
    mov ecx, eax
    pop ebx
    pop eax
    cmp ecx, 127
    jg .too_long
    mov edx, 0
.loop:
    cmp ecx, -1
    je .end
    push eax
    mov al, [eax + ecx]
    mov [ebx + edx], al
    pop eax
    dec ecx
    inc edx
    jmp .loop
.too_long:
    mov eax, too_long_string
    mov ebx, 45
    call print_n
    
.end:
    mov byte [ebx + 127], 0xA
    
    pop esi
    ret
