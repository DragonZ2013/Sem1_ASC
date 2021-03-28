; asamblare 			nasm -fobj exemplu.asm
; linkeditare 			alink -oPE -subsys console -entry start exemplu.obj
; depanare  			ollydbg exemplu.exe
; programe necesare 	http://www.nasm.us + alink: alink.sourceforge.net/download.html + http://www.ollydbg.de

bits 32

global start
extern ExitProcess, printf
import ExitProcess kernel32.dll
import printf msvcrt.dll

segment code use32 class=CODE
;a-doubleword b-byte c-word x-qword
;(a+b/c-1)/(b+2)-x
;Fara semn
    a dd 15
    b db 10
    c dw 5
    x dq 60
start:
    mov AL, [b]
    mov AH, 0;AX=b
    mov DX,0
    mov BX, [c];DX=c
    div BX; AL=b/c
    mov DX, 0
    mov AH,0
    mov BX, word[a]
    mov CX, word[a+2]
    add AX,BX
    adc DX,CX
    sub AX,1
    sbb DX,0
    mov BL, [b]
    mov BH, 0
    add BX,2;BX=b+2
    div BX;AX=DX:AX/BX = (a+b/c-1)/(b+2)
    mov ECX, dword[x]
    mov EDX, dword[x+4];EDX:ECX=x
    push AX
    push DX
    pop EAX
    mov EBX,0
    sub EAX,ECX
    sbb EBX,EDX;(a+b/c-1)/(b+2)-x
    call ExitProcess


segment data use32 class=DATA
    msg: db "Mesaj!", 13, 10, 0
    