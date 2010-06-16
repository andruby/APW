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
for line in fd:
  s = line.split()
  rank = int(s[0])
  value = int(s[1])
  N = rank
  count += 1
  if count > 100000: break
  if count > 200:
    ranks.append(rank)
    values.append(value)
fd.close()

sqerrorT = []
for t in xrange(8800000, 12000000, 100000):
  print t
  sqerror = []
  for s in [0.6 + 0.001 * x for x in xrange(1,300)]:
    error = 0
    for i in xrange(0, len(values)):
      error += (zipf(i+1, s, t) - values[i])**2
    sqerror.append(error*1.0/len(values))
  sqerrorT.append(sqerror)

error = []
param = []
for i in xrange(0, len(sqerrorT)):
  min = numpy.min(sqerrorT[i])
  pos = sqerrorT[i].index(min)
  error.append(min)
  param.append((0.6+0.001*pos, t))

min = numpy.min(error)
pos = error.index(min)

print param[pos], min

#  g = Gnuplot.Gnuplot()
#  ddata = Gnuplot.Data(ranks, values, title="data")
#  dzipf = Gnuplot.Data(ranks, zipf, title='zipf')
  #g.plot(dzipf)
#  g.plot(ddata, dzipf)
#  zipf = []

#  raw_input('Please press return to continue...\n')
