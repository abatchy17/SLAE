; FunWithStack.asm
; By Abatchy
;
;	nasm -felf32 FunWithStack.asm && ld -o FunWithStack FunWithStack.o

global _start

section .text

_start:

	mov eax, 0xb00b1e5		; （。 ㅅ 。）

	push ax				; (esp-2): 0xb1e5 
	pop bx				; esp: <empty>
	
	push eax			; (esp-4): 0xb00b1e5
	pop ecx				; esp: <empty>
	
	push word [var]			; (esp-2): 0xaa 0xbb
	push dword [var]		; (esp-6): 0xaa 0xbb 0xcc 0xdd 0xaa 0xbb

	pop ax				; (esp-4): 0xcc 0xdd 0xaa 0xbb, ax: 0xaa 0xbb
	pop edx				; esp: <empty>, edx: 0xcc 0xdd 0xaa 0xbb
	
	; exit program
	
	mov eax, 1
	mov ebx, 0
	int 0x80


section .data

var:    db 0xaa,0xbb,0xcc,0xdd,0xee,0xff,0x11,0x22
