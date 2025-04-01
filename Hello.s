; Hello.s - Prints a greeting message

segment .data
    greeting db "Good morning!", 10, 0
    greetingLen equ $-greeting

segment .text
global _start
_start:
    mov eax, 4       ; sys_write
    mov ebx, 1       ; stdout
    mov ecx, greeting
    mov edx, greetingLen
    int 80h

    mov eax, 1       ; sys_exit
    int 80h
