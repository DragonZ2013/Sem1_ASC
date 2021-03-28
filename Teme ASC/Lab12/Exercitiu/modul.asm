bits 32

global caracterespeciale

segment data use32 class = data


segment code use32 class = code

caracterespeciale:
; ESP = RETURN ADDRESS, ESP+4 = 0, ESP+8 = SIR1

mov ECX, 0
mov ESI, [ESP+8]
loops:
lodsb; AL <- DS:ESI
cmp AL, 0
JZ saresfarsit
cmp AL, '0'
JB cspecial1
cmp AL, '9'
JBE nuecspecial
cmp AL, 'A'
JB cspecial1
cmp AL, 'Z'
JBE nuecspecial
cmp AL, 'a'
JB cspecial1
cmp AL, 'z'
JBE nuecspecial

cspecial1:
inc ECX
nuecspecial:
JMP loops
saresfarsit:

mov [ESP+4], ECX

ret 