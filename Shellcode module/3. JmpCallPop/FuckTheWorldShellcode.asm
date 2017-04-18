; FuckTheWorldShellcode.asm
; by Abatchy
;
;   nasm -felf32 FuckTheWorldShellcode.asm && ld -o FuckTheWorldShellcode FuckTheWorldShellcode.o
;   Shellcode generated: "\x31\xc0\xb0\x04\x31\xdb\xb3\x01\xeb\x11\x59\x31\xd2\xb2\x19\xcd\x80\x31\xc0\xb0\x01\x31\xdb\xb3\x05\xcd\x80\xe8\xea\xff\xff\xff"

global _start        ; Entry point, required for ld linker

section .text        ; Text segment, code resides here

_start:
    ; write(1, message, mlen)
    xor eax, eax
    mov al, 4
    
    xor ebx, ebx
    mov bl, 0x1

    jmp short jmp_to_message  

jmp_back:
    pop ecx
    
    xor edx, edx
    mov dl, 25
    int 0x80
    
    ; exit(5)
    xor eax, eax
    mov al, 1

    xor ebx, ebx
    mov bl, 0x5
    int 0x80

jmp_to_message:

    call jmp_back
    message:    db "Fuck the world. And you.", 10
