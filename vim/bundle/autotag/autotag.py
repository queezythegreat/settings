#!/usr/bin/env python

import os
import sys
import string
import fileinput

def goodTag(line, excluded):
   if line[0] == '!':
      return True
   else:
      f = string.split(line, '\t')
      if len(f) > 3 and not f[1] in excluded:
         return True
   return False

def stripTags(tagsFile, sources):
  backup = ".SAFE"
  input = fileinput.FileInput(files=tagsFile, inplace=True, backup=backup)
  try:
     for l in input:
        l = l.strip()
        if goodTag(l, sources):
           print l
  finally:
     input.close()
     try:
        os.unlink(tagsFile + backup)
     except StandardError:
        pass

if __name__ == '__main__':
    tag_file = sys.argv[1]
    sources = sys.argv[2:]
    stripTags(tag_file, sources)

