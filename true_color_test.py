#!/usr/bin/env python

#Based on https://github.com/jonathanslenders/pymux/blob/master/examples/true_color_test.py

from __future__ import unicode_literals, print_function
import sys

n = 20
if len(sys.argv) > 1:
    n = int(sys.argv[1])

def go(f):
    print('\\x1b' + f[1:])
    for r in range(0, 5*n, 5):
        for g in range(50, 200):
            b = 150
            print(f % (r, g, b), end='')

        print('\x1b[0m   \n', end='')
    print("")

go('\x1b[0;48;2;%s;%s;%sm ')
go('\x1b[0;48;2;%s:%s:%sm ')
go('\x1b[0;48;2:%s:%s:%sm ')
# with colorspace
go('\x1b[0;48;2:1:%s:%s:%sm ')

print('\x1b[0m\r\n')