; Conditional2.s - Checks if the entered character is within 'a' to 'z'

segment .data               ; Data segment
    prompt      db "Enter a character:", 10, 0
    promptLen   equ $-prompt

    msgNotInRange db "Not in range", 10, 0
    msgNotInRangeLen equ $-msgNotInRange

    msgInRange  db "In range", 10, 0
    msgInRangeLen equ $-msgInRange

segment .bss                ; Uninitialized data segment
    buffer      resb 100    ; Reserve 100 bytes for input
    bytesRead   resd 1      ; Number of bytes read

segment .text               ; Code segment
global _start
_start:
    ; Print the prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptLen
    int 80h

    ; Read a character from the keyboard
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 100
    int 80h
    mov [bytesRead], eax

    ; Check if the character is within 'a' to 'z'
    cmp byte [buffer], 'a'
    jb print_not_in_range
    cmp byte [buffer], 'z'
    ja print_not_in_range

    ; If in range, print "In range"
    mov eax, 4
    mov ebx, 1
    mov ecx, msgInRange
    mov edx, msgInRangeLen
    int 80h
    jmp exit_program

print_not_in_range:
    ; Print "Not in range"
    mov eax, 4
    mov ebx, 1
    mov ecx, msgNotInRange
    mov edx, msgNotInRangeLen
    int 80h

exit_program:
    mov eax, 1
    int 80h
