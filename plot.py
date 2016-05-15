from numpy import *
import matplotlib.pyplot as plt
b=[[],[],[]]
tp=[[],[],[]]
pdr=[[],[],[]]
aed=[[],[],[]]
co=[[],[],[]]
rp=['AODV', 'DSDV', 'DSR']
Bb={'p' : 'Pause Time', 'd' : 'Dimensionality', 'n' : 'Number of Nodes'}
B=raw_input('basis? : ')
for i,r in enumerate(rp):
    f=open(r+'/'+r+'.txt', 'r')
    for x in xrange(5):
        b[i].append(float(f.readline().split('\t')[1][:-1]))
        tp[i].append(float(f.readline().split('\t')[1][:-1]))
        pdr[i].append(float(f.readline().split('\t')[1][:-1]))
        aed[i].append(float(f.readline().split('\t')[1][:-1]))
        co[i].append(float(f.readline().split('\t')[1][:-1]))
s=Bb[B]
plt.figure(1)
plt.plot(b[0],tp[0],'ro-', label=rp[0])
plt.plot(b[1],tp[1],'go-', label=rp[1])
plt.plot(b[2],tp[2],'bo-', label=rp[2])
plt.title('Throughput Vs '+s)
plt.xlabel(s)
plt.ylabel('Throughput')
plt.legend(loc='upper left')
plt.savefig('plots/'+B+'/throughput.png')

plt.figure(2)
plt.plot(b[0],pdr[0],'ro-', label=rp[0])
plt.plot(b[1],pdr[1],'go-', label=rp[1])
plt.plot(b[2],pdr[2],'bo-', label=rp[2])
plt.title('Packet Delivery Ratio Vs '+s)
plt.xlabel(s)
plt.ylabel('Packet Delivery Ratio')
plt.legend(loc='upper left')
plt.savefig('plots/'+B+'/pcktdlvryratio.png')

plt.figure(3)
plt.plot(b[0],aed[0],'ro-', label=rp[0])
plt.plot(b[1],aed[1],'go-', label=rp[1])
plt.plot(b[2],aed[2],'bo-', label=rp[2])
plt.title('Average End-to-End Delay Vs '+s)
plt.xlabel(s)
plt.ylabel('Average End-to-End Delay')
plt.legend(loc='upper left')
plt.savefig('plots/'+B+'/e2edelay.png')

plt.figure(4)
plt.plot(b[0],co[0],'ro-', label=rp[0])
plt.plot(b[1],co[1],'go-', label=rp[1])
plt.plot(b[2],co[2],'bo-', label=rp[2])
plt.title('Control Overhead Vs '+s)
plt.xlabel(s)
plt.ylabel('Control Overhead')
plt.legend(loc='upper left')
plt.savefig('plots/'+B+'/ctrloverhead.png')
