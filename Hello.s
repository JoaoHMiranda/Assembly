;Hello

segment .data ;declarar dados

mens db "Bom dia!",10 ;declarar variavel
tam equ $-mens ;tamanho da mens

segment .text
global _start
_start:

mov eax,4 ;print/write
mov ebx,1 ;fd tela
mov ecx,mens ;ponteiro string
mov edx,tam ;qdde caracteres
int 80h


mov eax,1 ;finalizar
int 80h ;syscall
