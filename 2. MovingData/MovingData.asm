; MovingData.asm
; By Abatchy
;
;	nasm -felf32 MovingData.asm && ld -o MovingData MovingData.o

global _start

section .text

_start:

	mov eax, 0xdeadbeef	; eax = 0xdeadbeef
	mov ebx, 0xaabbccdd	; ebx = 0xaabbccdd

	xchg eax, ebx			; eax = 0xaabbccdd
						; ebx = 0xdeadbeef

	lea eax, [var]		; eax = effective address of var
	lea ebx, [eax]		; ebx = effective address of var (which matches eax)

	; size directive is needed, otherwise assember won't know which interpretation is valid
	
	mov byte [var], 5		; var: 0x05 0xbb 0xcc 0xdd 0xee 0xff 0x11 0x22
	mov word [var], 5		; var: 0x0005 0xddcc 0xffee 0x2211
	mov dword [var], 5	; var: 0x00000005 0x2211ffee

	; exit program
	
	mov eax, 1
	mov ebx, 0
	int 0x80


section .data

var:    db 0xaa,0xbb,0xcc,0xdd,0xee,0xff,0x11,0x22
