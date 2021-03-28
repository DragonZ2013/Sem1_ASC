bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
     

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

segment data use32 class=data
    a dq 10h
    b equ 10
    c dw 10
    d dd -10
    e db 10b
    f dw 1010h

segment code use32 class=code
    start:
        push    dword 0
        call    [exit]