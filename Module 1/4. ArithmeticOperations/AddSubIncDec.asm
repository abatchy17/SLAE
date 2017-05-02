; AddSubIncDec.asm
; By Abatchy
;
;   nasm -felf32 AddSubIncDec.asm && ld -o AddSubIncDec AddSubIncDec.o

global _start

section .text

_start:

    ; ADD instruction example
    ; ADD reg/mem, reg/mem/imm

    mov eax, 0x0             ; EAX = 0
    add al, 0x1              ; EAX = 0x1
    add ax, 0x2000           ; EAX = 0x2001
    add eax, 0x30000000      ; EAX = 0x30002001

    mov eax, 0x1             ; EAX = 0x1
    add eax, 0xffffffff      ; EAX = 0x0, CF = 1, ZF = 0

    ; SUB instruction
    ; SUB reg/mem, reg/mem/imm

    mov eax, 0xffffffff      ; EAX = 0xffffffff
    sub al, 0x1              ; EAX = 0xfffffffe
    sub ax, 0x2000           ; EAX = 0xffffdffe
    sub eax, 0x30000000      ; EAX = 0xcfffdffe

    mov eax, 0x0             ; EAX = 0x0
    sub eax, 0x1             ; EAX = 0xffffffff, CF = 1

    ; INC and DEC
    ; INC/DEC reg

    mov al, 0
    inc al                  ; AL = 1
    dec al                  ; AL = 0, ZF = 1

    ; exit(0)
    mov eax, 1
    mov ebx, 0
    int 0x80
