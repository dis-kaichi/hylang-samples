#!/usr/bin/env python
# coding: utf-8
import hy
import os
import sys
# print os.path.dirname(os.path.abspath(__file__))
# print os.path.dirname(os.path.abspath(__file__))
# print os.path.abspath(__file__)
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
import hytest

def pybob():
    print "NEW BOB"

if __name__ == '__main__':
    hytest.bob()
    print "OK"
