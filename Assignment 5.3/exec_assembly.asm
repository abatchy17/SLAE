00000000    push byte +0xb
00000002    pop eax                 ; EAX = 0xb
00000003    cdq                     ; Extend EAX -> EDX = 0x0
00000004    push edx                ; Push zero byte
00000005    push word 0x632d        ; Translates to "-c"
00000009    mov edi,esp             ; Make EDI point to top of stack, which contains "-c" terminated with a null character
0000000B    push dword 0x68732f     ; PUSH "hs/"
00000010    push dword 0x6e69622f   ; PUSH "nib/"
00000015    mov ebx,esp             ; Make EBX point to top of stack "/bin/sh"
00000017    push edx                ; Push another NULL byte
00000018    call dword 0x27         ; Address of "/bin/date" is pushed onto stack through "call"
0000001D    "/bin/date"             ; Not executed
00000027    push edi                ; Push pointer to "-c"
00000027    push ebx                ; Push pointer to "/bin/sh"
00000029    mov ecx,esp             ; ECX point to top of stack
                                    ; This is the "meat" of the shellcode, ECX points to [addr1][addr2][addr3][null]
                                    ; addr1 points to /bin/sh (0B, 10 and 15)
                                    ; addr2 points to -c (05 and 09)
                                    ; addr3 points to "/bin/date" (18 and 1D)

                                    ; NULL indicates end of argv[]
0000002B    int 0x80                ; EAX = 0xb, which is syscall for execve()
                                    ; EBX points to argv[0]
                                    ; ECX points to &argv[0]