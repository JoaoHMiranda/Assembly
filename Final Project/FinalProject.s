; Final Project: File Encryption
; Authors: João Henrique and Sophia Luna
; Description:
;   This program reads an input file ("input.txt"), encrypts its contents by modifying 
;   each character in the ASCII range 65 to 157 using the formula:
;       encrypted = 157 - original
;   and writes the encrypted data to an output file ("output.txt"). 
;   Error messages are printed if file operations fail.

segment .data           ; Data segment
    inputFile   db "input.txt", 0
    outputFile  db "output.txt", 0

    errOpenIn   db "Error opening input file", 10, 0
    errOpenOut  db "Output file already exists", 10, 0
    errCreate   db "Error creating output file", 10, 0
    successMsg  db "Encryption successful", 10, 0

    lenErrOpenIn  equ $-errOpenIn
    lenErrOpenOut equ $-errOpenOut
    lenErrCreate  equ $-errCreate
    lenSuccess    equ $-successMsg

segment .bss            ; Uninitialized data segment
    buffer     resb 30     ; Reserve 30 bytes for buffer
    bytesRead  resd 1      ; Number of bytes read
    fdIn       resd 1      ; File descriptor for input file
    fdOut      resd 1      ; File descriptor for output file

segment .text           ; Code segment
global _start

;---------------------------------------
; openFile:
; Opens a file using syscall 5 (sys_open).
; Expects:
;   EBX = pointer to filename
;   ECX = mode (e.g., 2 for read/write)
;   EDX = permissions (e.g., 0o777)
; Returns:
;   EAX = file descriptor (or negative value on error)
;---------------------------------------
openFile:
    mov eax, 5
    int 80h
    ret

;---------------------------------------
; readFile:
; Reads up to 27 bytes from file descriptor stored in [fdIn] into buffer.
;---------------------------------------
readFile:
    mov eax, 3         ; sys_read
    mov ebx, [fdIn]
    mov ecx, buffer
    mov edx, 27
    int 80h
    ret

;---------------------------------------
; createFile:
; Creates a file using syscall 8 (sys_creat).
; Expects:
;   EBX = pointer to filename
;   ECX = permissions (e.g., 0o777)
;---------------------------------------
createFile:
    mov eax, 8
    int 80h
    ret

;---------------------------------------
; closeFile:
; Closes a file descriptor using syscall 6 (sys_close).
; Expects:
;   EBX = file descriptor
;---------------------------------------
closeFile:
    mov eax, 6
    int 80h
    ret

;---------------------------------------
; printMessage:
; Prints a message to stdout.
; Expects:
;   ECX = pointer to message
;   EDX = length of message
;---------------------------------------
printMessage:
    mov eax, 4         ; sys_write
    mov ebx, 1         ; stdout
    int 80h
    ret

;---------------------------------------
; writeFile:
; Writes [bytesRead] bytes from buffer to the output file.
; Expects:
;   FD in [fdOut], buffer in ECX, length in EDX.
;---------------------------------------
writeFile:
    mov eax, 4         ; sys_write
    mov ebx, [fdOut]
    int 80h
    ret

;---------------------------------------
; encryptChar:
; Encrypts the character at buffer+ESI if it is in the valid range.
; For characters with ASCII codes in [65,157]:
;     newValue = 157 - original
;---------------------------------------
encryptChar:
    mov ah, 157
    sub ah, al
    mov [buffer + esi], ah
    ret

;---------------------------------------
; _start: Program Entry Point
;---------------------------------------
_start:
    ; Open input file ("input.txt")
    mov ebx, inputFile
    mov ecx, 2           ; read/write mode
    mov edx, 0o777       ; full permissions
    call openFile
    cmp eax, 0
    jl errorOpenIn       ; if negative, error
    mov [fdIn], eax

    ; Try to open output file ("output.txt")
    mov ebx, outputFile
    mov ecx, 2           ; read/write mode
    mov edx, 0o777
    call openFile
    cmp eax, 0
    jge errorOpenOut     ; if file exists, error

    ; Create output file
    mov ebx, outputFile
    call createFile
    cmp eax, 0
    jl errorCreate
    mov [fdOut], eax

encryption_loop:
    ; Read from input file
    call readFile
    mov [bytesRead], eax
    cmp eax, 0
    je done_encryption

    mov esi, 0         ; Initialize index for buffer

encrypt_loop:
    mov al, [buffer + esi]
    cmp al, 65
    jb skip_encrypt
    cmp al, 157
    ja skip_encrypt
    call encryptChar
skip_encrypt:
    inc esi
    cmp esi, [bytesRead]
    jb encrypt_loop

    ; Write the encrypted block to output file
    call writeFile
    jmp encryption_loop

done_encryption:
    ; Close input and output files
    mov ebx, [fdIn]
    call closeFile
    mov ebx, [fdOut]
    call closeFile
    jmp exit_program

errorOpenIn:
    mov ecx, errOpenIn
    mov edx, lenErrOpenIn
    call printMessage
    jmp exit_program

errorOpenOut:
    mov ecx, errOpenOut
    mov edx, lenErrOpenOut
    call printMessage
    jmp exit_program

errorCreate:
    mov ecx, errCreate
    mov edx, lenErrCreate
    call printMessage
    jmp exit_program

exit_program:
    mov eax, 1         ; sys_exit
    int 80h

;---------------------------------------
; Sample input file: input.txt
;---------------------------------------
; The sample input file "input.txt" should contain text similar to:
; ABCDEFGHIJKLMNOPQRSTUVWXYZ AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
; BBBBBBBBBBBBBBBBBBBBBBBBBBBBB
