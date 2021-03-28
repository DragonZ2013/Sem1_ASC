bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;EAX = (c+b)/(22-a+b-108)-d+8*a
    ;a=byte,b=word,c,d=doubleword
    a db 16
    b dw 40
    c dd 50
    d dd 60
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax, [b]
        cwd
        mov bx, [c]
        mov cx, [c+2]
        add AX,BX
        adc DX,CX
        ;push DX
        ;push AX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
