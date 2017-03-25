; FuckTheWorldPuts.asm
; by Abatchy
;
;       nasm -felf32 FuckTheWorldPuts.asm && gcc FuckTheWorldPuts.o && ./FuckTheWorldPuts
; ---------------------------------------------------------------------------------------

global main		; Entry point
extern puts		; External function

section .text	; Text segment, code resides here

main:
	ret

section .data
    msg     db      "Fuck the world. And you.", 0
