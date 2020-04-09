#!/bin/python
# coding: utf-8

"""
Recursively scan an asm file for dependencies.
"""

import sys
import argparse
import re
import os.path

includes = set()

def scan_file(filename):
	cur_dir = os.path.split(filename)[0]
	for line in open(filename, encoding="utf-8"):
		# look for .include, .binclude and .binary
		if 'include' not in line and '.binary' not in line:
			continue
		line = line.split(';')[0] # remove all comments
		line = line[1:] # remove false positive on labels
		include = re.findall(r'\s\.b?include\s*"(.+)"',line)
		if len(include) > 0:
			include = os.path.join(cur_dir, include[0])
			includes.add(include)
			scan_file(include)
		elif len(line) > 0: # it must be .binary
			include = os.path.join(cur_dir, line.split('"')[1])
			includes.add(include)

def main():
	ap = argparse.ArgumentParser()
	ap.add_argument('filenames', nargs='*')
	args = ap.parse_args()
	for filename in set(args.filenames):
		scan_file(filename)
	sys.stdout.write(' '.join(includes))

if __name__ == '__main__':
	main()
