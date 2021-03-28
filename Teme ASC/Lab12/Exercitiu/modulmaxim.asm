bits 32

global maxim

segment data use32 class = data

segment code use32 class = code

maxim:
; ESP = Return address EPS+4 = [sc2], ESP+8 = [sc1], ESP+12 = maximv
mov ECX, [ESP+4]
mov EBX, [ESP+8]

cmp ECX, EBX
JBE saredacaemaimicsauegal
mov EAX, ECX
JMP sarealtfel
saredacaemaimicsauegal:
mov EAX, EBX

sarealtfel:

mov ECX, [ESP+12]
mov [ECX], EAX; mov ECX, EAX

ret
