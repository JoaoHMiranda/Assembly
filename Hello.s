;Hello

segment .data

mens db "Bom dia!",10
tam equ $-mens

segment .text
global _start
_start:

mov eax,4
mov ebx,1
mov ecx,mens
mov edx,tam
int 80h


mov eax,1
int 80h
