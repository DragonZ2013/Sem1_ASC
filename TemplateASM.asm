bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;a-doubleword b-byte c-word x-qword
;(a+b/c-1)/(b+2)-x
;Cu semn
    a dd 15
    b db 10
    c dw 5
    x dq 60

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov AL, [b]
    cbw
    cwd
    mov BX, [c];BX=c
    idiv BX; AX=b/c
    sub AX,1;AX=b/c-1
    cwd
    mov BX, word[a]
    mov CX, word[a+2]
    add AX,BX
    adc DX,CX
    ;sub AX,1
    ;sbb DX,0
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
    idiv BX;AX=DX:AX/BX = (a+b/c-1)/(b+2)
    mov EBX, dword[x]
    mov ECX, dword[x+4];EDX:ECX=x
    push AX
    push DX
    pop EAX
    cdq
    sub EAX,EBX
    sbb EDX,ECX;(a+b/c-1)/(b+2)-x
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
