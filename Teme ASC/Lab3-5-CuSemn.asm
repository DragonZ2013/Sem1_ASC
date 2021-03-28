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
;Cu semn
    a dd 15
    b db 10
    c dw 5
    x dq 60
start:
    mov AL, [b]
    cbw
    cwd
    mov BX, [c];DX=c
    div BX; AL=b/c
    cwd
    mov BX, word[a]
    mov CX, word[a+2]
    add AX,BX
    adc DX,CX
    sub AX,1
    sbb DX,0
    cwd
    push AX
    pop CX
    mov AL, [b]
    cbw
    add AX,2
    push AX
    pop BX
    push CX
    pop AX
    div BX;AX=DX:AX/BX = (a+b/c-1)/(b+2)
    mov EBX, dword[x]
    mov ECX, dword[x+4];EDX:ECX=x
    push AX
    push DX
    pop EAX
    cdq
    sub EAX,EBX
    sbb EDX,ECX;(a+b/c-1)/(b+2)-x
    call ExitProcess


segment data use32 class=DATA
    msg: db "Mesaj!", 13, 10, 0
    