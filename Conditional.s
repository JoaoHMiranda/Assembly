; Conditional.s - Checks if the first character of a string is 'A'

segment .data               ; Data segment
    prompt      db "Enter a phrase (up to 99 characters) and press Enter:", 10, 0
    promptLen   equ $-prompt

    msgNotEqual db "Not equal", 10, 0
    msgNotEqualLen equ $-msgNotEqual

    msgEqual    db "Equal", 10, 0
    msgEqualLen equ $-msgEqual

segment .bss                ; Uninitialized data segment
    buffer      resb 100    ; Reserve 100 bytes for input
    bytesRead   resd 1      ; Number of bytes read

segment .text               ; Code segment
global _start
_start:
    ; Print the prompt
    mov eax, 4            ; sys_write
    mov ebx, 1            ; stdout
    mov ecx, prompt       ; pointer to prompt
    mov edx, promptLen    ; length of prompt
    int 80h

    ; Read input from the keyboard
    mov eax, 3            ; sys_read
    mov ebx, 0            ; stdin
    mov ecx, buffer       ; destination buffer
    mov edx, 100          ; maximum bytes
    int 80h
    mov [bytesRead], eax

    ; Compare the first character with 'A'
    cmp byte [buffer], 'A'
    je print_equal

    ; If not equal, print "Not equal"
    mov eax, 4
    mov ebx, 1
    mov ecx, msgNotEqual
    mov edx, msgNotEqualLen
    int 80h
    jmp exit_program

print_equal:
    ; Print "Equal"
    mov eax, 4
    mov ebx, 1
    mov ecx, msgEqual
    mov edx, msgEqualLen
    int 80h

exit_program:
    mov eax, 1            ; sys_exit
    int 80h
