import sys, os, subprocess
# args: dimen numnodes pausetime basis
rp = ['AODV', 'DSDV', 'DSR']
basis = { 'p' : ['0' ,'30' , '90', '120', '150'] ,\
          'n' : ['10', '20', '30', '40', '50'],\
          'd' : ['200', '400', '600', '800', '1000'] }
cwd = os.getcwd()
for r in rp:
    open(r+'/'+r+'.txt', 'w').close()

b = raw_input('Pause Time : p\nNumber of nodes : n\nDimensions : d\nBasis? : ')
if b == 'p':
    n = raw_input('Number of nodes? : ')
    d = raw_input('Dimensions? : ')
    for p in basis[b]:
        os.chdir('/home/nirupam/Packages/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/setdest')
        cmd = ['./setdest', '-v', '1', '-x', d, '-y', d, '-n', n, '-p', p, '-M', '50', '-t', '150', '>', cwd+'/NodesCreate.tcl']
        print '\n\n\nSetting nodes for pause time '+ p
        os.system(' '.join(cmd))

        os.chdir('/home/nirupam/Packages/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/')
        cmd = ['ns', 'cbrgen.tcl', '-type', 'tcp', '-nn', n, '-seed', '1.0', '-mc', str(int(n)/4), '>', cwd+'/ConCreate.tcl']
        print 'Creating connection for pause time '+ p
        os.system(' '.join(cmd))

        os.chdir(cwd)

        for r in rp:
            li = ['ns', 'script.tcl', r]+[d, n]
            subprocess.call(li)
            f=open(r+'/'+r+'.txt', 'a')
            inp=['awk', '-f', 'calc.awk', r+'/'+r+'.tr']
            f.write('B\t'+p+'\n')
            f.write(subprocess.check_output(inp))
        
if b == 'n':
    p = raw_input('Pause Time? : ')
    d = raw_input('Dimensions? : ')
    for n in basis[b]:
        os.chdir('/home/nirupam/Packages/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/setdest')
        cmd = ['./setdest', '-v', '1', '-x', d, '-y', d, '-n', n, '-p', p, '-M', '50', '-t', '150', '>', cwd+'/NodesCreate.tcl']
        print '\n\n\nSetting nodes for number '+ n
        os.system(' '.join(cmd))

        os.chdir('/home/nirupam/Packages/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/')
        cmd = ['ns', 'cbrgen.tcl', '-type', 'tcp', '-nn', n, '-seed', '1.0', '-mc', str(int(n)/4), '>', cwd+'/ConCreate.tcl']
        print 'Creating connection for number of nodes '+ n
        os.system(' '.join(cmd))

        os.chdir(cwd)
        
        for r in rp:
            li = ['ns', 'script.tcl', r]+[d, n]
            subprocess.call(li)
            f=open(r+'/'+r+'.txt', 'a')
            inp=['awk', '-f', 'calc.awk', r+'/'+r+'.tr']
            f.write('B\t'+n+'\n')
            f.write(subprocess.check_output(inp))

if b == 'd':
    n = raw_input('Number of nodes? : ')
    p = raw_input('Pause Time? : ')
    for d in basis[b]:
        os.chdir('/home/nirupam/Packages/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/setdest')
        cmd = ['./setdest', '-v', '1', '-x', d, '-y', d, '-n', n, '-p', p, '-M', '50', '-t', '150', '>', cwd+'/NodesCreate.tcl']
        print '\n\n\nSetting nodes for dimension '+ d
        os.system(' '.join(cmd))

        os.chdir('/home/nirupam/Packages/ns-allinone-2.35/ns-2.35/indep-utils/cmu-scen-gen/')
        cmd = ['ns', 'cbrgen.tcl', '-type', 'tcp', '-nn', n, '-seed', '1.0', '-mc', str(int(n)/4), '>', cwd+'/ConCreate.tcl']
        print 'Creating connection for dimension '+ d
        os.system(' '.join(cmd))

        os.chdir(cwd)

        for r in rp:
            li = ['ns', 'script.tcl', r]+[d, n]
            subprocess.call(li)
            f=open(r+'/'+r+'.txt', 'a')
            inp=['awk', '-f', 'calc.awk', r+'/'+r+'.tr']
            f.write('B\t'+d+'\n')
            f.write(subprocess.check_output(inp))

