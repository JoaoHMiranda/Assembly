; Cryptography.s - File Encryption Program
; Reads an input file ("input.txt"), encrypts its content by modifying 
; each character in the ASCII range 65 to 157 (encrypted = 157 - original),
; and writes the encrypted data to an output file ("output.txt").

segment .data               ; Data segment
    inputFile   db "input.txt", 0
    outputFile  db "output.txt", 0

    errOpenIn   db "Error opening input file", 10, 0
    errCreate   db "Error creating output file", 10, 0
    msgSuccess  db "Encryption successful", 10, 0

    lenErrOpenIn  equ $-errOpenIn
    lenErrCreate  equ $-errCreate
    lenSuccess    equ $-msgSuccess

segment .bss                ; Uninitialized data segment
    buffer      resb 100    ; Reserve 100 bytes for buffer
    bytesRead   resd 1      ; Number of bytes read
    fdIn        resd 1      ; File descriptor for input file
    fdOut       resd 1      ; File descriptor for output file

segment .text               ; Code segment
global _start

; Open file using syscall 5
openFile:
    mov eax, 5
    int 80h
    ret

; Read from file using syscall 3
readFile:
    mov eax, 3
    mov ebx, [fdIn]
    mov ecx, buffer
    mov edx, 27         ; Read up to 27 bytes
    int 80h
    ret

; Create file using syscall 8
createFile:
    mov eax, 8
    int 80h
    ret

; Close file using syscall 6
closeFile:
    mov eax, 6
    int 80h
    ret

; Print message using syscall 4
printMessage:
    mov eax, 4
    mov ebx, 1
    int 80h
    ret

; Write to file using syscall 4
writeFile:
    mov eax, 4
    mov ebx, [fdOut]
    int 80h
    ret

; Encrypt a character if it is in the range [65,157]
encryptCharacter:
    mov ah, 157
    sub ah, al
    mov [buffer + esi], ah
    ret

_start:
    ; Open the input file ("input.txt")
    mov ebx, inputFile
    mov ecx, 2          ; Mode: read/write
    mov edx, 0o777
    call openFile
    cmp eax, 0
    jl error_open_in
    mov [fdIn], eax

    ; Open (or create/overwrite) the output file ("output.txt")
    ; Flags: O_WRONLY | O_CREAT | O_TRUNC = 577 (decimal)
    mov ebx, outputFile
    mov ecx, 577
    mov edx, 0o666      ; Permissions: 0666
    call openFile
    cmp eax, 0
    jl error_create
    mov [fdOut], eax

encryption_loop:
    call readFile
    mov [bytesRead], eax
    cmp eax, 0
    je done_encryption

    mov esi, 0

encrypt_loop:
    mov al, [buffer + esi]
    cmp al, 65
    jb skip_encrypt
    cmp al, 157
    ja skip_encrypt
    call encryptCharacter
skip_encrypt:
    inc esi
    cmp esi, [bytesRead]
    jb encrypt_loop

    call writeFile
    jmp encryption_loop

done_encryption:
    mov ebx, [fdIn]
    call closeFile
    mov ebx, [fdOut]
    call closeFile
    jmp exit_program

error_open_in:
    mov ecx, errOpenIn
    mov edx, lenErrOpenIn
    call printMessage
    jmp exit_program

error_create:
    mov ecx, errCreate
    mov edx, lenErrCreate
    call printMessage
    jmp exit_program

exit_program:
    mov eax, 1
    int 80h
