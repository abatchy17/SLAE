; FunWithStrings.asm
; by Abatchy
;
;    nasm -felf32 FunWithStrings.asm && ld -o FunWithStrings FunWithStrings.o && ./FunWithStrings
; ---------------------------------------------------------------------------------------

global _start           ; Entry point, required for ld linker

section .text           ; Text segment, code resides here

PrintMessage:
    ; write(1, message, mlen)
    mov        eax, 0x4     ; write
    mov        ebx, 0x1     ; fd = 1 (STDOUT)
    mov        edx, mlen    ; Message length
    int        0x80
    ret

_start:

    mov ecx, mlen       ; Loading message length into ecx for rep instruction
    lea esi, [source]   ; Load effective address of source
    lea edi, [dest]     ; Load effective address of destination
    
    cld             ; Clean direction flag
    rep movsb       ; Repeat copying a byte and incrementing both esi/edi ecx times

    lea ecx, [source]
    call PrintMessage
    lea ecx, [dest]
    call PrintMessage
    
    ; exit(5)
    mov        eax, 0x1
    mov        ebx, 0x5
    int        0x80

section .data        ; Data segment

    source:    db "Fuck the world. And you.", 10
    mlen       equ     $-source

section .bss
    dest:       resb 100
