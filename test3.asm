; Scrieți un program în limbaj de asamblare care să rezolve expresia aritmetică, considerând domeniile de definiție ale variabilelor
; a - doubleword; b, d - byte; c - word; e - qword
; a + b / c - d * 2 - e
bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 
	a dd 125
	b db 2
	c dw 15
	d db 200
	e dq 80
segment  code use32 class=code ; segmentul de cod
start: 
	;pentru a calcula b/c, convertim b de la byte la doubleword pentru a-l putea imparti la word-ul c
	mov al, [b]
	mov ah, 0 ;conversie fara semn de la al la ax
	mov dx, 0 ;conversie fara semn de la ax la dx:ax
	;dx:ax = b
	div word [c] ;impartire fara semn dx:ax la c
	;ax=b/c	
	;catul impartirii este in ax (restul este in dx, dar mergem mai departe doar cu catul)

	mov bx, ax ;salvam b/c in bx pentru a putea folosi ax la inmultirea d*2
	mov al, 2
	mul byte [d] ;ax=d*2

	sub bx, ax ;bx = b / c - d * 2
	; convertim la doubleword word-ul bx pentru a-l putea aduna cu doubleword-ul a
	mov cx, 0 ; conversie fara semn de la bx la cx:bx
	;cx:bx=b/c-d*2

	mov ax, word [a]
	mov dx, word [a+2] ;dx:ax=a

	add ax, bx
	adc dx, cx ;dx:ax = a + b / c - d * 2
	
	push dx
	push ax
	pop eax ;eax = a + b / c - d * 2
	
	mov edx, 0 ;edx:eax = a + b / c - d * 2
	sub eax, dword [e]
	sbb edx, dword [e+4] ;edx:eax = a + b / c - d * 2 - e
	
	push dword 0 ;se pune pe stiva codul de retur al functiei exit
	call [exit] ;apelul functiei sistem exit pentru terminarea executiei programului	