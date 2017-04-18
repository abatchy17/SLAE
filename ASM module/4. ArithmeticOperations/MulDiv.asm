; MulDiv.asm
; By Abatchy
;
;   nasm -felf32 MulDiv.asm && ld -o MulDiv MulDiv.o

global _start

section .text

_start:

    ; MUL instruction
    ; AH/AL, DX/AX, EDX/EAX

    mov eax, 0

    mov al, 0x10
    mov bl, 0x2
    mul bl                  ; AL = 0x20, AH = 0x0, OF = 0, CF = 0

    mov al, 0xff
    mul bl                  ; AL = 0xfe, AH = 0x1, OF = 1, CF = 1

    mov ax, 0x1000
    mov bx, 0x0002
    mul bx                  ; AX = 0x2000, DX = 0x0000, OF = 0, CF = 0

    mov ax, 0xffff
    mul bx                  ; AX = 0xfffe, DX = 0x0001, OF = 1, CF = 1

    ; DIV instruction
    ; Remainder/Quotient: AH/AL, DX/AX, EDX/EAX

    mov dx, 0
    mov ax, 0x1234          ; Dividing DX-AX by BX
    mov bx, 0x2
    div bx                  ; AX = 0x91a
    
    mov dx, 0
    mov ax, 0x1235          ; Dividing DX-AX by BX
    mov bx, 0x2
    div bx                  ; AX = 0x91a, DX = 0x1

    ; exit program

    mov eax, 1
    mov ebx, 0
    int 0x80
    