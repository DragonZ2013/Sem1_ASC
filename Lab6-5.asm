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
    a db 00101101b
    b db 11010010b
    c dd 0000000011000001111111111111111b
; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV CX,[c]
        OR CX,0000000011000001111111111111111
        MOV AL, [b]
        SHL AL, 3
        AND AL, 11100000b
        AND CH,AL
        mov AL,[a]
        SHR AL,11
        AND CH,AL
        MOV [c],CX
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
