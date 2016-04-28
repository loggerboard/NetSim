import sys, os, numpy, pylab
inE='thp'
time,winSize = numpy.loadtxt(inE, usecols=(0,1), unpack=True)
pylab.plot(time,winSize)
pylab.xlabel('Time(ms)')
pylab.ylabel('Data(Bytes)')
pylab.title('Performance(Bytes/sec)')
pylab.savefig('thpDSDV.png')
