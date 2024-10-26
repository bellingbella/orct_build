#!/bin/python
import sys

str_ = sys.argv[1];

if (int(sys.argv[2]) <= len(str_.split(':'))):
    
    print(sys.argv[1].split(':')[int(sys.argv[2])]);
else:
    print("ERR");