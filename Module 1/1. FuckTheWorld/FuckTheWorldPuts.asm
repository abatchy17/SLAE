; FuckTheWorldPuts.asm
; by Abatchy
;
; nasm -felf32 FuckTheWorldPuts.asm && gcc -o FuckTheWorldPuts FuckTheWorldPuts.o && ./FuckTheWorldPuts
; ---------------------------------------------------------------------------------------

global main        ; Entry point, required for ld linker

extern puts          ; Imports the symbol only if it is referred to in the current assembly

section .text            ; Text segment, code resides here

main:
    push    msg      ; Push message address onto stack
    call    puts     ; Call C function
    add     esp, 4   ; Clean up stack
    mov     eax, 0   ; Set exit status
    ret

section .data
    msg     db      "Fuck the world. And you.", 0
