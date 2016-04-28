import sys, os, numpy, pylab
inE='win.tr'
time,winSize = numpy.loadtxt(inE, usecols=(0,1), unpack=True)
pylab.plot(time,winSize)
pylab.xlabel('Time(ms)')
pylab.ylabel('Window Size')
pylab.title('Performance')
pylab.savefig('plotDSDV.png')
