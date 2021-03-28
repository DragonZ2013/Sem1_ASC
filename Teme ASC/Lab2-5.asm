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
;a,b,c - byte, d - word
;[d-2*(a-b)+b*c]/2
    a db 15
    b db 10
    c db 40
    d dw 60
start:
    mov AL, [b]; AL=b
    mov DL, [c]; DL=c
    mul DL; AX=AL*DL=b*c
    push AX
    pop DX; DX=b*c
    mov AL, [a]; AL=a
    sub AL, [b]; AL=a-b
    mov AH, 2; AH=2
    mul AH;AX=2*(a-b)
    push AX
    mov AX, [d]; AX=d
    add AX,DX; AX=d+b*c
    pop DX;DX=2*(a-b)
    sub AX,DX;AX=[d-2*(a-b)-b*c]
    mov DX, 2; DX=2
    div DX; AX=[d-2*(a-b)-b*c]/2
    call ExitProcess
    


segment data use32 class=DATA
    msg: db "Mesaj!", 13, 10, 0
    