; ControlInstructionsLOOP.asm
; By Abatchy
;
; nasm -felf32 ControlInstructionsLOOP.asm && ld -o ControlInstructionsLOOP ControlInstructionsLOOP.o && ./ControlInstructionsLOOP
; ---------------------------------------------------------------------------------------

global _start

section .text

_start:

    JMP SkipNarnia

    ; This code should never execute
    mov eax, 4
    mov ebx, 1
    mov ecx, exitmsg
    mov edx, exitmsglen
    int 0x80

SkipNarnia:

    ; LOOP instruction automatically decrements ecx and checks if it's not zero yet
    mov ecx, 5

PrintMessage:    
    
    push ecx

    ; Print Message
    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, msglen
    int 0x80
    
    pop ecx
    LOOP PrintMessage

    ; exit(0)
    mov eax, 1
    mov ebx, 0
    int 0x80

section .data
    exitmsg     db "I should not print this!", 10
    exitmsglen  equ $-exitmsg
    message     db "Consume thy enemy!", 10
    msglen      equ $-message
