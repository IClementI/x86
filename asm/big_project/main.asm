extern string_array
extern reverse_string
extern compare_string
extern len_string
extern add_string

section .data

section .bss
    input_buffer resb 128
    output_buffer resb 128

section .text
    global _start
    global test
    extern input_nice
    extern println_n
    extern str_cmp
    extern cmp_print
    extern str_len
    extern println_number
    extern print_n
    extern cmp_list
    extern cmp_list2
    extern print_command
    extern print_choice
    extern str_reverse
    extern print_list_command
    extern str_reverse_controler
    extern str_len_controler
    extern controler_caller
    extern print_loop_command
    extern exit_controler
    
_start:
    call print_list_command

.loop
    mov eax, input_buffer
    mov ebx, 128
    call input_nice

    mov eax, input_buffer
    call cmp_list2
    
    push eax
    call print_choice
    pop eax    
    
    call controler_caller
    cmp eax, 0
    je .exit
    cmp eax, -1
    je .exit_error	
    jmp .loop

.exit_error:
    call exit_controler
.exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
