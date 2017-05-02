; ExitWithNullChar.asm
; By Abatchy
;
;   nasm -felf32 ExitWithNullChar.asm && ld -o ExitWithNullChar ExitWithNullChar.o

;   Generated shellcode: "\xb8\x01\x00\x00\x00\xbb\x10\x00\x00\x00\xcd\x80"

global _start

section .text

_start:
        mov eax, 0x1
        mov ebx, 0x10
        int 0x80
