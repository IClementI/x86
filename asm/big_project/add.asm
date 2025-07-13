section .data

section .text
    global add_char

; ----------
; Input: EAX - adress of a number buffer on char form, EBX - adress of a number buffer on char form
; Output: Added value in char form in EAX
; ----------
add_char:
    add eax, ebx
    sub eax, 2*'0'
    cmp eax, 0
    jl .invalid
    cmp eax, 10
    jge .invalid
    jmp .end
.invalid:
    mov eax, -1
.end:
    ret
    
