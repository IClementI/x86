section .data
    new_line db 0xA
    number_buffer dd 0
    tab db 9

section .bss

section .text
    global print_n
    global println_n
    global println_number
    global print_number
    global print_tab
    global print_new_line
    global print_improved
    extern str_len  
    
; ----------
; Input: EAX - adress of a string, EBX - Len of string
; Output: Printed string of adress EAX and len EBX
; ----------
print_n:
    mov ecx, eax
    mov edx, ebx
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret
    
; ----------
; Input: EAX - adress of a string, EBX - Len of string
; Output: Printed string of adress EAX and len EBX and a new string
; ----------
println_n:
    call print_n
    
    mov eax, new_line
    mov ebx, 1
    call print_n
    ret

; ----------
; Input: EAX - a number
; Output: Print the number with a line
; ----------
println_number:
    add eax, '0'
    mov [number_buffer], eax
    mov eax, number_buffer
    mov ebx, 1
    call println_n
    ret

; ----------
; Input: EAX - a number
; Output: Print the number
; ----------
print_number:
    add eax, '0'
    mov [number_buffer], eax
    mov eax, number_buffer
    mov ebx, 1
    call print_n
    ret
    
; ----------
; Input: None
; Output: Print tabulation
; ----------
print_tab:
    mov eax, tab
    mov ebx, 1
    call print_n
    ret
 
; ----------
; Input: None
; Output: Print new_line
; ----------
print_new_line:
    mov eax, new_line
    mov ebx, 1
    call print_n
    ret
    
; ----------
; Input: EAX
; Output: Print a buffer of adress EAX and get its length using str_len
; ----------
print_improved:
    push esi
    mov esi, eax
    call str_len
    mov ebx, eax
    mov eax, esi
    call print_n
    pop esi
    ret
