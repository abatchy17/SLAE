; FuckTheWorldPuts.asm
; by Abatchy
;
;   nasm -felf32 FuckTheWorldPuts.asm && gcc FuckTheWorldPuts.o && ./FuckTheWorldPuts

global main        ; Entry point for ld linker
extern puts        ; C call

section .text            ; Text segment, code resides here

main:
        push    msg      ; Push message address onto stack
        call    puts     ; Call C function
        add     esp, 4   ; Clean up stack
        mov     eax, 0   ; Set exit status
        ret

section .data
        msg     db      "Fuck the world. And you.", 0
