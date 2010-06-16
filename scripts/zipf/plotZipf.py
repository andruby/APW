#!/usr/bin/python
# -*- coding: utf8 -*-

import Gnuplot
from math import log10
import numpy

def zipf(i,alpha, t):
  return t*1.0/i**alpha

fd = open('out.csv', 'rU')

values = []
ranks = []
N = 0
count = 0
flag = False
for line in fd:
  s = line.split()
  rank = int(s[0])
  value = int(s[1])
  N = rank
  count += 1

  if count < 1200:
    ranks.append(rank)
    values.append(value)
  else:
    break

discard = 0
for line in fd:
  s = line.split()
  rank = int(s[0])
  value = int(s[1])
  N = rank
  count += 1
  discard +=1

  if count < 100000:
    if discard == 50:
      ranks.append(rank)
      values.append(value)
      discard = 0
  else:
    break


count = 0
for line in fd:
  s = line.split()
  rank = int(s[0])
  value = int(s[1])
  N = rank
  count += 1

  if count == 2000:
    ranks.append(rank)
    values.append(value)
    count = 0

fd.close()

g = Gnuplot.Gnuplot()
g('set encoding utf8')
g('set term postscript enhanced monochrome')
g('set logscale xy 10')
g('set yrange [1:]')
g('set xlabel "Posición"')
g('set ylabel "Acesos"')
ddata = Gnuplot.Data(ranks, values, title="datos")
#dzipf = Gnuplot.Data(ranks, zipf, title='zipf')
dzipf = Gnuplot.Func("10000000.0/x", title='zipf')
g.plot(dzipf, ddata)

#raw_input('Please press return to continue...\n')
