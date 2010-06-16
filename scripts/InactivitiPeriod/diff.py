fd = open('sessions.txt', 'rU')
fd2 = open('diff.txt', 'w')

ant = int(fd.readline())
for line in fd:
  num = int(line)
  fd2.write(str(ant-num) + '\n')
  ant = num

fd.close()
fd2.close()

