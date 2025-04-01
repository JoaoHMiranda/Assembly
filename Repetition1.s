; Repetition1.s - Copies input string and displays it with a newline appended

segment .data
    prompt      db "Enter a phrase:", 10, 0
    promptLen   equ $-prompt

    outputMsg   db "Your message was:", 10, 0
    outputMsgLen equ $-outputMsg

segment .bss
    buf1        resb 100    ; Reserve 100 bytes for input
    bytesRead1  resd 1      ; Number of bytes read
    buf2        resb 100    ; Reserve 100 bytes for output
    bytesRead2  resd 1      ; Number of bytes in output

segment .text
global _start
_start:
    ; Print the prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, promptLen
    int 80h

    ; Read input into buf1
    mov eax, 3
    mov ebx, 0
    mov ecx, buf1
    mov edx, 100
    int 80h
    mov [bytesRead1], eax

    ; Initialize index to 0
    mov esi, 0

copy_loop:
    mov al, [buf1+esi]
    mov [buf2+esi], al
    cmp al, 10        ; Check for newline (ASCII 10)
    je copy_done
    inc esi
    jmp copy_loop

copy_done:
    ; Append newline to buf2
    inc esi
    mov byte [buf2+esi], 10
    mov [bytesRead2], esi

    ; Print output message
    mov eax, 4
    mov ebx, 1
    mov ecx, outputMsg
    mov edx, outputMsgLen
    int 80h

    ; Print the copied message
    mov eax, 4
    mov ebx, 1
    mov ecx, buf2
    mov edx, [bytesRead2]
    int 80h

    ; Exit
    mov eax, 1
    int 80h
