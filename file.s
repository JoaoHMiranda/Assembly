
segment .data ;declarar dados

nome db "teste.txt",0

mens db "erro",10  ;declarar variavel
tam equ $-mens ;tamanho da mens

mens2 db "fechado",10  ;declarar variavel
tam2 equ $-mens2 ;tamanho da mens




segment .bss ;dados nao inicializados
fd resb 100



segment .text; linhas de codigos
global _start
_start:

mov eax,5
mov ebx,nome
mov ecx,2
mov edx,0q77
int 80h

mov [fd],eax
mov eax,0

cmp [fd],eax
jge fechar

mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens ;ponteiro string
mov edx,tam;qdde caracteres
int 80h
jmp fim

fechar:

mov eax,6
mov ebx,[fd]
int 80h

mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens2 ;ponteiro string
mov edx,tam2;qdde caracteres
int 80h

fim:

mov eax,1 ;finalizar
int 80h ;syscall
