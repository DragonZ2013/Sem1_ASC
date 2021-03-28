bits 32

global start

extern exit, printf
import exit msvcrt.dll 
import printf msvcrt.dll

extern caracterespeciale
extern maxim

segment data use32 class = data

sir1 db "ana^ar%%de$mere", 0
sir2 db "@na/are62pere", 0
sc1 dd 0
sc2 dd 0
format db "sc1=%d , sc2=%d ", 0
maximv dd 0
formateq db "%s , %s", 0

segment code use32 class = code

start:

push dword sir1
push dword 0
call caracterespeciale
pop dword [sc1]
add esp, 4

push dword sir2
push dword 0
call caracterespeciale
pop dword [sc2]
add esp, 4

push dword [sc2]
push dword [sc1] ; printf(format, sc1, sc2)
push dword format
call [printf]
add esp, 4*3

push dword maximv
push dword [sc1]
push dword [sc2]
call maxim
add esp, 4*3

mov ECX, [sc1]
mov EAX, [sc2]
cmp ECX, EAX
JE sareegal

cmp ECX, [maximv]
JNE saredacasc2emax
push dword sir1
call [printf]
add esp, 4
JMP final


sareegal:
push dword sir2
push dword sir1
push dword formateq
call [printf]
add esp, 4*3
JMP final

saredacasc2emax:
push dword sir2
call [printf]
add esp, 4

final:
push dword 0 
call [exit]




