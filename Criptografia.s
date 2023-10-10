;condicinal
segment .data ;declarar dados

mens1 db "Digite uma frase",10  ;declarar variavel
tam1 equ $-mens1 ;tamanho da mens

mens2 db "Sua mensagem criptografada :",10  ;declarar variavel
tam2 equ $-mens2 ;tamanho da mens

mens3 db "Sua mensagem descriptografda :",10  ;declarar variavel
tam3 equ $-mens3 ;tamanho da mens


segment .bss ;dados nao inicializados

buf1 resb 100 ;reserva 100 espacos para buf1
qrec1 resd 1 ;bytes recebidos

buf2 resb 100 ;reserva 100 espacos para buf2
qrec2 resd 1 ;bytes recebidos



segment .text; linhas de codigos
global _start
_start:


;print mens1
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens1 ;ponteiro string
mov edx,tam1 ;qdde caracteres
int 80h


;read buf1
mov eax,3 ;read
mov ebx,0 ;fd do teclado
mov ecx,buf1 ;destino(pont)
mov edx,100 ;quantos maxima
int 80h
mov [qrec1],eax ;recebida >=1


;inicializar indice
mov esi,0 


inic:

mov ah,157; valor para ser criptografado
mov al,[buf1+esi] ;caracter atual
sub ah,al;faz a subtracao para criptografar
mov [buf2+esi],ah ;copiar
cmp al,10 ;enter?
je sair
inc esi; esi++
jmp inic


sair:

;print mens2
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens2 ;ponteiro string
mov edx,tam2 ;qdde caracteres
int 80h


;copiar a quebra de linha e depois o tamanho o tamanho de buf2

mov [buf2+esi],byte 10 ;copiar queba de linha 
inc esi; esi++
mov [qrec2],esi ;tamanho do buf2

;print buf2
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,buf2 ;ponteiro string
mov edx,[qrec2] ;qdde caracteres
int 80h


;inicializar indice
mov esi,0 


inic2:

mov ah,157; valor para ser criptografado
mov al,[buf2+esi] ;caracter atual
sub ah,al;faz a subtracao para criptografar
mov [buf1+esi],ah ;copiar
cmp al,10 ;enter?
je sair2
inc esi; esi++
jmp inic2

sair2:

;print mens3
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens3 ;ponteiro string
mov edx,tam3 ;qdde caracteres
int 80h

;copiar a quebra de linha e depois o tamanho o tamanho de buf2
mov [buf1+esi],byte 10 ;copiar queba de linha 
inc esi; esi++
mov [qrec1],esi ;tamanho do buf2


;print buf1
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,buf1 ;ponteiro string
mov edx,[qrec1] ;qdde caracteres
int 80h


mov eax,1 ;finalizar
int 80h ;syscall
