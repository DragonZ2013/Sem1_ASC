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
    s1 db 7,33,55,19,46
    len1 equ ($-s1)
    s2 db 33,21,7,13,27,19,55,1,46
    len2 equ ($-s2)
    d times len2 db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov EBX,0
        CLD
        mov ESI,d
        LoopStart:
            mov AL,[s2+EBX];BL nu este un offset valid, BX se bloca in debugger
            mov ECX,len1
            mov EDI, s1
            mov DL,0
            Search:
                inc DL
                SCASB
                JE Found
            Loop Search
            mov AL,0
            mov [d+EBX],AL
            JMP Skip
            Found:
            mov AL,DL
            mov [d+EBX],AL
            Skip:
            inc EBX
            cmp EBX,len2
        JB LoopStart
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
