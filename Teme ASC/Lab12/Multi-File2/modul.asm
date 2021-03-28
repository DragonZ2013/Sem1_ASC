%ifndef _MODUL_ASM_
%define _MODUL_ASM_
import printf msvcrt.dll
extern printf, exit
modul: ; char _stdcall find(char a)
    push dword eax
    ;push dword format
    push dword ebx
    call [printf] 
    add esp, 4 * 2 

	ret 4 ; in acest caz 4 reprezinta numarul de octeti ce trebuie eliberati de pe stiva (parametrul pasat procedurii)

%endif