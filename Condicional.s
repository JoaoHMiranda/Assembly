;condicinal
segment .data ;declarar dados

mens db "Digite uma frase de até 99 caractere ,e depois aperte enter",10  ;declarar variavel
tam equ $-mens ;tamanho da mens

mens2 db "Nao e igual",10  ;declarar variavel
tam2 equ $-mens2 ;tamanho da mens2

mens3 db "E igual",10  ;declarar variavel
tam3 equ $-mens3 ;tamanho da mens3



segment .bss ;dados nao inicializados

buff resb 100;reserva 100 espacos para buff
qrec resd 1 ;bytes recebidos



segment .text; linhas de codigos
global _start
_start:


;print mens
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens ;ponteiro string
mov edx,tam ;qdde caracteres
int 80h


;read
mov eax,3 ;read
mov ebx,0 ;fd do teclado
mov ecx,buff ;destino(pont)
mov edx,100 ;quantos maxima
int 80h
mov [qrec],eax ;recebida >=1



;comparar
cmp[buff],byte "A"
je then

;nao é igual
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens2 ;ponteiro string
mov edx,tam2 ;qdde caracteres
int 80h
jmp contin


then:
;é igual
mov eax,4 ;print
mov ebx,1 ;fd tela
mov ecx,mens3 ;ponteiro string
mov edx,tam3 ;qdde caracteres
int 80h

contin:
;continua
mov eax,1 ;finalizar
int 80h ;syscall
