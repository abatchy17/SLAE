/*
 ExecveBashStack.c
By Abatchy
gcc ExecveBashStack.c -fno-stack-protector -z execstack -o ExecveBashStack.out
*/

#include <stdio.h>
#include <string.h>

unsigned char shellcode[] = 
"\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

int main()
{
    printf("Shellcode size: %d\n", strlen(shellcode));
    int (*ret)() = (int(*)())shellcode;
    ret();
}
