extern str_len_controler
extern str_reverse_controler
extern exit_controler
extern add_controler
extern str_compare_controler

LEN_ARRAY equ 5

section .data
    
    error_string db 'Command is invalid', 0xA, 0
    function_array dd str_reverse_controler, str_compare_controler, str_len_controler, add_controler, exit_controler

section .text
    global controler_caller
    extern print_improved

; ----------
; Input: EAX
; Output: Call the controler numbered EAX
; ----------
controler_caller:
    cmp eax, LEN_ARRAY
    jge .error_eax
    cmp eax, 0
    jl .error_eax
    call [function_array + 4*eax]
    ret
.error_eax:
    mov eax, error_string
    call print_improved
    mov eax, -1
    ret
