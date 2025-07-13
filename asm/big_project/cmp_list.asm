LEN_ARRAY equ 5

extern string_array
extern reverse_string
extern compare_string
extern len_string
extern add_string
extern exit_string

section .data
    input_adress_cmp_list dd 0
    indice dd 0

section .text
    global cmp_list
    extern str_len
    extern str_cmp
    global cmp_list2

; ----------
; Input: EAX - adress of a string
; Output: -1 if not match is found, n if there is a match with the n element of the list
; Clobbered: EAX, EBX, ECX
; ----------
cmp_list:
    mov ecx, 0
    mov [indice], ecx
    mov [input_adress_cmp_list], eax
.loop_cmp:
    mov ecx, [indice]
    cmp ecx, LEN_ARRAY
    je .not_found
    mov eax, [string_array + ecx*4]
    call str_len
    
    mov edx, eax
    mov eax, [input_adress_cmp_list]
    mov ecx, [indice]
    mov ebx, [string_array + ecx*4]
    mov ecx, edx
    call str_cmp
    cmp eax, 1
    je .found
    mov ecx, [indice]
    inc ecx
    mov [indice], ecx
    jmp .loop_cmp
.found:
    mov eax, [indice]
    ret
.not_found:
    mov eax, -1
    ret

; ----------
; Input: EAX - adress of a string
; Output: -1 if not match is found, n if there is a match with the n element of the list
; Clobbered: EAX, EBX, ECX
; ----------
cmp_list2:
    push esi
    push edi
    mov esi, 0
    mov edi, eax
.loop_cmp:
    cmp esi, LEN_ARRAY
    je .not_found
    
    mov eax, [string_array + esi*4]
    call str_len
    
    mov ecx, eax
    mov eax, edi
    mov ebx, [string_array + esi*4]
    call str_cmp
    cmp eax, 1
    je .found
    
    inc esi
    jmp .loop_cmp
.found:
    mov eax, esi
    jmp .end
.not_found:
    mov eax, -1
.end:
    pop edi
    pop esi
    ret
