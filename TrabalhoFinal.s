;condicinal
segment .data ;declarar dados

nome1 db "arq1.txt",0

nome2 db "arq2.txt",0

mens1 db "Erro ao abrir arquivo",10  ;declarar variavel
tam1 equ $-mens1 ;tamanho da mens

mens2 db "Arquivo ja existente ",10  ;declarar variavel
tam2 equ $-mens2 ;tamanho da mens

mens3 db " Sua mensagem criptografada",10  ;declarar variavel
tam3 equ $-mens3 ;tamanho da mens

mens4 db "Erro ao criar Aruivo",10  ;declarar variavel
tam4 equ $-mens4 ;tamanho da mens



segment .bss ;dados nao inicializados

buf1 resb 100 ;reserva 100 espacos para buf1
qrec1 resd 1 ;bytes recebidos

buf2 resb 100 ;reserva 100 espacos para buf2
qrec2 resd 1 ;bytes recebidos

fd1 resb 100

fd2 resb 100



segment .text; linhas de codigos

global _start
_start:

;abrir arq 1
mov ebx,nome1
call abrir

;consegui?
mov ebx,0
cmp eax,ebx
jl erro1

;salvar fd1
;mov [fd1],eax

;abrir arq 2
mov ebx,nome2
call abrir

;consegui?
mov ebx,0
cmp eax,ebx
jge erro2




erro1:
;print mens1
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens1 ;ponteiro string
mov edx,tam1 ;qdde caracteres
int 80h
jmp fim

erro2:
;print mens2
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens2 ;ponteiro string
mov edx,tam2 ;qdde caracteres
int 80h
jmp fim

fim:
mov eax,1 ;finalizar
int 80h ;syscall

abrir:
mov eax,5
mov ecx,2
mov edx,0q77
int 80h
ret
