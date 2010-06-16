from progressbar import *


sessions = [0 for x in xrange(0,1000)]
d = {}
fd = open('../squid_filterd', 'rU');

#ProgressBar
widgets = ['', Percentage(), ' ', Bar(marker=RotatingMarker()),' ', ETA(), ' ', FileTransferSpeed()]
pbar = ProgressBar(widgets=widgets, maxval=154931994).start()
lineCount = 0

for line in fd:
  # ProgressBar
  lineCount +=1
  pbar.update(lineCount)

  line = line.split()
  time = float(line[0])
  ip = line[2]

  if ip in d:
    time_d = d[ip]
    for i in xrange(0,1000):
      if time - time_d > i+1:
        sessions[i] += 1
      else:
        break
  d[ip] = time

pbar.finish()
fd.close()

fd = open('sessions.txt', 'w')
for i in sessions:
  fd.write(str(i) + '\n')
fd.close()


