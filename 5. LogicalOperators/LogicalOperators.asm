; LogicalOperators.asm
; By Abatchy
;
;    nasm -felf32 LogicalOperators.asm && ld -o LogicalOperators LogicalOperators.o

global _start

section .text

_start:

    ; AND
    
    mov al, 0x01
    and al, 0x02 ; AL = 0, ZF = 1
    
    ; OR
    
    mov al, 0x01
    or  al, 0x02 ; AL = 0x03
    
    ; NOT
    
    mov al, 0x01
    not al       ; AL = 0xfe
    
    ; XOR
    
    mov al, 0xa  ; AL = 1010
    xor al, 0x5  ; AL = 0xf
    
    ; exit program
    
    mov eax, 1
    mov ebx, 0
    int 0x80
