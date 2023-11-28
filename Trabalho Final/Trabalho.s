;João Henrique e Sophia Luna
;O trabalho tem como intuito ler um arquivo e cripitografar ele(alterando o primeiro caracter com o ultimo,conforme a tabela ACII)
;A cripitografica atua do caracter 65 ate o 157 da tabela ascii


segment .data ;declarar dados

nome1 db "arq1.txt",0

nome2 db "arq2.txt",0

mens1 db "Erro ao abrir arquivo 1",10  ;declarar variavel
tam1 equ $-mens1 ;tamanho da mens

mens2 db "Arquivo ja existente ",10  ;declarar variavel
tam2 equ $-mens2 ;tamanho da mens

mens3 db " Erro ao criar",10  ;declarar variavel
tam3 equ $-mens3 ;tamanho da mens

mens4 db "Erro ao criar Aruivo",10  ;declarar variavel
tam4 equ $-mens4 ;tamanho da mens

mens5 db "Deu certo",10  ;declarar variavel
tam5 equ $-mens5 ;tamanho da mens






segment .bss ;dados nao inicializados

buf1 resb 100 ;reserva 100 espacos para buf1
qrec1 resd 1 ;bytes recebidos

fd1 resb 100

fd2 resb 100






segment .text; linhas de codigos

;funçoes
abrir:
mov eax,5
mov ecx,2
mov edx,0q777
int 80h
ret

ler:
mov eax,3
mov ebx,[fd1]
mov ecx,buf1
mov edx,27
int 80h
ret


criar:
mov eax,8
mov ecx,0q777
int 80h
ret

fechar:
mov eax,8
int 80h
ret

print:
mov eax,4
mov ebx,1
int 80h
ret

escrev:
mov eax,4 ; 
mov ebx,[fd2]
mov ecx,buf1
mov edx,[qrec1]
int 80h
ret


crip:
mov ah,157; valor para ser criptografado
sub ah,al;faz a subtracao para criptografar
mov [buf1+esi],ah ;copiar
ret







global _start
_start:
;main

;abrir arq 1
mov ebx,nome1
call abrir



;consegui?
mov ebx,0
cmp eax,ebx
jl erro1


;salvar fd1
mov [fd1],eax


;abrir arq 2
mov ebx,nome2
call abrir


;consegui?
mov ebx,0
cmp eax,ebx
jge erro2


;cirar
mov ebx,nome2
call criar


;consegui?
mov ebx,0
cmp eax,ebx
jl erro3


;salvar fd1
mov [fd2],eax

cripitografia:

;ler
call ler
mov [qrec1],eax

;start contador
mov esi,0

;cripitografar
cripto:
mov al,[buf1+esi]

;ver se esta no intervalo
cmp al,65
jb SemCrip
cmp al,157
ja SemCrip

call crip

;estava
SemCrip:
inc esi
cmp esi,[qrec1]
jb cripto

;escrever
call escrev
cmp esi,[qrec1]
je cripitografia

;fechar arq1
mov ebx,[fd1]
call fechar

;fechar arq2
mov ebx,[fd2]
call fechar
jmp fim

erro1:
mov ecx,mens1 ;ponteiro string
mov edx,tam1 ;qdde caracteres
call print
jmp fim

erro2:
mov ecx,mens2 ;ponteiro string
mov edx,tam2 ;qdde caracteres
call print
jmp fim

erro3:
mov ecx,mens3 ;ponteiro string
mov edx,tam3 ;qdde caracteres
call print
jmp fim


fim:
mov eax,1 ;finalizar
int 80h ;syscall
