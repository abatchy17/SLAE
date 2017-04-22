; "/bin/bashX-cX/bin/dateXAAAABBBBCCCCNNNN"
; /bin/bash     | offset: 0  | length: 9   
; X (null byte) | offset: 9  | length: 1   
; -c            | offset: 10 | length: 2   
; X (null byte) | offset: 12 | length: 1   
; /bin/date     | offset: 13 | length: 9   
; X (null byte) | offset: 22 | length: 1   
; AAAA (arg1)   | offset: 23 | length: 4   
; BBBB (arg2)   | offset: 27 | length: 4   
; CCCC (arg3)   | offset: 31 | length: 4   
;
; nasm -felf32 a.asm && ld -o a a.o

; Generated shellcode: "\xeb\x2e\x5e\x31\xdb\x88\x5e\x09\x88\x5e\x0c\x88\x5e\x16\x89\xf7\x89\x7e\x17\x83\xc7\x0a\x89\x7e\x1b\x83\xc7\x03\x89\x7e\x1f\x89\x5e\x23\x8d\x1e\x8d\x4e\x17\x8d\x56\x23\x31\xc0\xb0\x0b\xcd\x80\xe8\xcd\xff\xff\xff\x2f\x62\x69\x6e\x2f\x62\x61\x73\x68\x58\x2d\x63\x58\x2f\x62\x69\x6e\x2f\x64\x61\x74\x65\x58\x41\x41\x41\x41\x42\x42\x42\x42\x43\x43\x43\x43\x4e\x4e\x4e\x4e";

global _start        ; Entry point, required for ld linker

section .text        ; Text segment, code resides here

_start:
    jmp short jmp_to_message  

jmp_back:
    pop esi         ; ESI has the address of message

    xor ebx, ebx
    
    ; Null byte between args
    mov byte [esi + 9], bl
    mov byte [esi + 12], bl
    mov byte [esi + 22], bl
    
    ; ESI/EDI now points at beginning of message
    mov edi, esi
    
    ; Loading address of arg1 "/bin/bash" to AAAA
    mov dword [esi + 23], edi
    
    ; Loading address of arg2 "-c" to BBBB
    add edi, 10
    mov dword [esi + 27], edi
    
    ; Loading address of arg3 "/bin/time" to CCCC
    add edi, 3
    mov dword [esi + 31], edi
    
    ; NULL for edx (NNNN) - can probably be replaced with any previous null byte
    mov dword [esi + 35], ebx

    ; EBX: Points to start of message
    lea ebx, [esi]
    
    ; ECX: Points to array of addresses to args (AAAABBBB....ZZZZ)
    lea ecx, [esi + 23]
    
    ; EDX: Points to null byte
    lea edx, [esi + 35]

    ; Calling Execve
    xor eax, eax
    mov al, 0xb     ; XORing since mov eax or mov ax will contain a null character
    int 0x80

jmp_to_message:

    call jmp_back
    message:    db "/bin/bashX-cX/bin/dateXAAAABBBBCCCCNNNN"
    