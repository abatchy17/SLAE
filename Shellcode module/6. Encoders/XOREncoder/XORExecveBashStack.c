/*
 ExecveBashStack.c
By Abatchy
gcc ExecveBashStack.c -fno-stack-protector -z execstack -o ExecveBashStack.out
*/

#include <stdio.h>
#include <string.h>

unsigned char shellcode[] = ;

int main()
{
    printf("Shellcode size: %d\n", strlen(shellcode));
    int (*ret)() = (int(*)())shellcode;
    ret();
}
