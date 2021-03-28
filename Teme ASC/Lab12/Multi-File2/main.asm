bits 32

global start

import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit

%include "modul.asm"

segment data use32 class=data
    ;message db "%s"
    sir dd "anaaremere"
    len1 equ ($-sir);=$
    alfabet dd "OPQRSTUVWXYZABCDEFGHIJKLMN"
    len2 equ ($-alfabet)
    format dd "%s\n",0
    
	format_string db "Output=%s", 0
    


segment code use32 class=code
start:
    ;push  dword message
    ;call  [scanf]
	;push dword 6
	mov ESI,sir
    mov EBX, format
    mov ECX,[len1]
    ret_point:
        lodsd
        call modul
    loop:
	
	push 0
	call [exit]
