; ExitWithoutNullChar.asm
; By Abatchy
;
;   nasm -felf32 ExitWithoutNullChar.asm && ld -o ExitWithoutNullChar ExitWithoutNullChar.o

;   Generated shellcode: "\x31\xc0\xb0\x01\x31\xdb\xb3\x10\xcd\x80"

global _start

section .text

_start:
        xor eax, eax
        mov al, 1
        xor ebx, ebx
        mov bl, 0x10
        int 0x80
