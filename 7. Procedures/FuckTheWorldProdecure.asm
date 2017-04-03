; FuckTheWorldProdecure.asm
; by Abatchy
;
;    nasm -felf32 FuckTheWorldProdecure.asm && ld -o FuckTheWorldProdecure FuckTheWorldProdecure.o && ./FuckTheWorldProdecure
; ---------------------------------------------------------------------------------------

global _start        ; Entry point, required for ld linker

section .text        ; Text segment, code resides here

PrintMessage:
    ; write(1, message, mlen)
    mov        eax, 0x4     ; write
    mov        ebx, 0x1     ; fd = 1 (STDOUT)
    mov        ecx, message ; Message address
    mov        edx, mlen    ; Message length
    int        0x80

    ret                 

_start:

    mov ecx, 5

CallPrintMessage:
    pushad              ; Push all general registers
    pushf               ; Push all flags
    
    call PrintMessage   ; Next EIP is pushed onto stack and EIP is changed to PrintMessage's address
    popf                ; Pop all general registers
    popad               ; Pop all flags
    
    loop CallPrintMessage

    ; exit(5)
    mov        eax, 0x1
    mov        ebx, 0x5
    int        0x80

section .data        ; Data segment

    message:    db "Fuck the world. And you.", 10
    mlen        equ     $-message
