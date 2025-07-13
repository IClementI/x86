LEN_ARRAY equ 5

section .data
    global reverse_string
    reverse_string db 'Reverse', 0xA, 0
    
    global compare_string
    compare_string db 'Compare', 0xA, 0
    
    global len_string
    len_string db 'Len', 0xA, 0
    
    global add_string
    add_string db 'Add', 0xA, 0
    
    global exit_string
    exit_string db 'Exit', 0xA, 0
    
    global string_array
    string_array dd reverse_string, compare_string, len_string, add_string, exit_string
    
    global list_commands
    list_commands db 'Here is the list of available commands:', 0
    
    global choose_string
    choose_string db 'You choose the command: ', 0
    
    global invalid_string
    invalid_string db 'Invalid', 0xA, 0
    
    global loop_command
    loop_command db 'Enter a new command:' , 0xA, 0
    
section .text:
    global print_command
    global print_choice
    global print_list_command
    extern str_len
    extern print_n
    extern print_tab
    extern print_new_line
    extern println_n
    global print_loop_command
    extern print_improved

; ----------
; Input: EAX - a number that correspond to a command
; Output: Print the command
; ----------
print_command:
    cmp eax, -1
    je .invalid
    mov eax, [string_array + eax*4]
    jmp .end
.invalid:
    mov eax, invalid_string
.end:
    push eax
    call str_len
    mov ebx, eax
    pop eax
    call print_n
    ret

; ----------
; Input: EAX - a number that correspond to a command
; Output: Print the choice of command
; ----------
print_choice:
    push eax
    mov eax, choose_string
    mov ebx, 24
    call print_n
    
    pop eax
    call print_command
    ret

print_list_command:
    push esi
    mov esi, list_commands
    mov eax, esi
    call str_len
    mov ebx, eax
    mov eax, esi
    call println_n
    mov ecx, 0
.loop:
    cmp ecx, LEN_ARRAY
    je .end
    push ecx
    mov esi, [string_array + 4*ecx]
    mov eax, esi
    call str_len
    dec eax
    mov ebx, eax
    mov eax, esi
    call print_n
    call print_tab
    pop ecx
    inc ecx
    jmp .loop
.end:
    call print_new_line
    pop esi
    ret
    
print_loop_command:
    mov eax, loop_command
    call print_improved
    ret
