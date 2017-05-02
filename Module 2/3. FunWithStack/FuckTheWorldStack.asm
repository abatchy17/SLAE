; FuckTheWorldStack.asm
; by Abatchy
;
;   nasm -felf32 FuckTheWorldStack.asm && ld -o FuckTheWorldStack FuckTheWorldStack.o
;   Shellcode generated: "\x31\xc0\xb0\x04\x31\xdb\xb3\x01\x68\x6f\x75\x2e\x0a\x68\x6e\x64\x20\x79\x68\x64\x2e\x20\x41\x68\x77\x6f\x72\x6c\x68\x74\x68\x65\x20\x68\x75\x63\x6b\x20\x31\xc9\xb1\x46\x51\x8d\x0c\x24\x31\xd2\xb2\x1c\xcd\x80\x31\xc0\xb0\x01\x31\xdb\xb3\x05\xcd\x80"

global _start        ; Entry point, required for ld linker

section .text        ; Text segment, code resides here

_start:
    ; write(1, message, mlen)
    xor eax, eax
    mov al, 4

    xor ebx, ebx
    mov bl, 0x1


    push 0x0a2e756f
    push 0x7920646e
    push 0x41202e64
    push 0x6c726f77
    push 0x20656874
    push 0x206b6375

    xor ecx, ecx
    mov cl, 0x46
    push ecx

    lea ecx, [esp]

    xor edx, edx
    mov dl, 28
    int 0x80

    ; exit(5)
    xor eax, eax
    mov al, 1

    xor ebx, ebx
    mov bl, 0x5
    int 0x80
