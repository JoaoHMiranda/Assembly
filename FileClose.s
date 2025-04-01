; FileClose.s - Opens a file and then closes it with error handling

segment .data
    fileName   db "test.txt", 0
    errMsg     db "Error opening file", 10, 0
    errMsgLen  equ $-errMsg
    closedMsg  db "File closed", 10, 0
    closedMsgLen equ $-closedMsg

segment .bss
    fd         resd 1

segment .text
global _start
_start:
    ; Open file "test.txt" for read/write
    mov eax, 5       ; sys_open
    mov ebx, fileName
    mov ecx, 2       ; mode: read/write
    mov edx, 0o077   ; permissions (if created)
    int 80h
    mov [fd], eax
    cmp eax, 0
    jl file_error

    ; Close the file
    mov eax, 6       ; sys_close
    mov ebx, [fd]
    int 80h

    ; Print closed message
    mov eax, 4
    mov ebx, 1
    mov ecx, closedMsg
    mov edx, closedMsgLen
    int 80h
    jmp exit_program

file_error:
    mov eax, 4
    mov ebx, 1
    mov ecx, errMsg
    mov edx, errMsgLen
    int 80h

exit_program:
    mov eax, 1       ; sys_exit
    int 80h
