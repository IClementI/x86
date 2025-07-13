.text
    global str_len

; ----------
; Input: EAX - adress of a string
; Output: Len of the string in EAX
; Clobbered: EAX, EBX
; ----------
str_len:
    mov ebx, 0x0
.loop:
    cmp byte [eax], 0x0
    je .end
    inc ebx
    inc eax
    jmp .loop
.end:
    mov eax, ebx
    ret
    
