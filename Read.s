; Read.s - Reads and echoes input

segment .data
    prompt      db "Enter a phrase (up to 99 characters), then press Enter", 10, 0
    promptLen   equ $-prompt
    echoMsg     db "Your message was:", 10, 0
    echoMsgLen  equ $-echoMsg

segment .bss
    inputBuffer resb 100
    inputBytes  resd 1

segment .text
global _start
_start:
    ; Print the prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptLen
    int 80h

    ; Read input from the keyboard
    mov eax, 3
    mov ebx, 0
    mov ecx, inputBuffer
    mov edx, 100
    int 80h
    mov [inputBytes], eax

    ; Print echo message
    mov eax, 4
    mov ebx, 1
    mov ecx, echoMsg
    mov edx, echoMsgLen
    int 80h

    ; Print the input read
    mov eax, 4
    mov ebx, 1
    mov ecx, inputBuffer
    mov edx, [inputBytes]
    int 80h

    mov eax, 1       ; sys_exit
    int 80h
