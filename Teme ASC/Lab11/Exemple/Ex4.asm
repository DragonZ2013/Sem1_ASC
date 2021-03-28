; Codul de mai jos va calcula rezultatul unor operatii aritmetice in registrul EAX, va salva valoarea registrilor, apoi va afisa valoarea rezultatului si va restaura valoarea registrilor.
bits 32

global start        

; declararea functiilor externe folosite de program
extern exit, printf  ; adaugam printf ca functie externa            
import exit msvcrt.dll    
import printf msvcrt.dll    ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
                          
segment data use32 class=data
	; sirurile de caractere sunt de tip byte
	format  db "%d", 0  ; %d <=> un numar decimal (baza 10)
	
segment code use32 class=code
	start:
		; vom calcula 20 + 123 + 7 in EAX
		mov eax, 20
		add eax, 123
		add eax, 7         ; eax = 150 (baza 10) sau 0x96 (baza 16)
		
		; salvam valoarea registrilor deoarece apelul functiei sistem printf va modifica valoarea acestora
		; folosim instructiunea PUSHAD care salveaza pe stiva valorile mai multor registrii, printre care EAX, ECX, EDX si EBX 
		; in acest exemplu este important sa salvam doar valoarea registrului EAX, dar instructiunea poate fi aplicata generic
		PUSHAD
	   
		; vom apela printf(format, eax) => vom afisa valoarea din eax
		; punem parametrii pe stiva de la dreapta la stanga
		push dword eax
		push dword format ; ! pe stiva se pune adresa string-ului, nu valoarea
		call [printf]      ; apelam functia printf pentru afisare
		add esp, 4*2       ; eliberam parametrii de pe stiva ; 4 = dimensiunea unui dword; 2 = nr de parametri
		
		; dupa apelul functiei printf registrul EAX are o valoare setata de aceasta functie (nu valoarea 150 pe care am calculat-o la inceputul programului)
		; restauram valoarea registrilor salvati pe stiva la apelul instructii PUSHAD folosind instructiunea POPAD
		; aceasta instructiune ia valori de pe stiva si le completeaza in mai multi registrii printre care EAX, ECX, EDX si EBX
		; este important ca inaintea unui apel al instructiunii POPAD sa ne asiguram ca exista suficiente valori 
		; pe stiva pentru a fi incarcate in registrii (de exemplu ca anterior a fost apelata instructiunea PUSHA)
		POPAD
		
		; acum valoarea registrului EAX a fost restaurata la valoarea de dinaintea apelului instructiunii PUSHAD (in acest caz valoarea 150)
		
		; exit(0)
		push dword 0      ; punem pe stiva parametrul pentru exit
		call [exit]       ; apelam exit pentru a incheia programul