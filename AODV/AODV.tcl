set val(chan)           Channel/WirelessChannel    ;# channel type 
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model 
set val(netif)          Phy/WirelessPhy            ;# network interface type 
set val(mac)            Mac/802_11                 ;# MAC type 
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type 
set val(ll)             LL                         ;# link layer type 
set val(ant)            Antenna/OmniAntenna        ;# antenna model 
set val(ifqlen)         50                         ;# max packet in ifq 
set val(nn)             20                         ;# number of mobilenodes 
set val(rp)             AODV                       ;# routing protocol
set val(x)              800   			   ;# X dimension of topography 
set val(y)              500 			   ;# Y dimension of topography   
set val(stop)		100                         ;
#-------Event scheduler object creation--------#

set ns              [new Simulator]
#Creating trace file and nam file 
set tracefd       [open aodv.tr w]
set windowVsTime  [open win.tr w] 
set namtrace      [open aodv.nam w]   

$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo       [new Topography]

$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

# configure the nodes
        $ns node-config -adhocRouting $val(rp) \
                   -llType $val(ll) \
                   -macType $val(mac) \
                   -ifqType $val(ifq) \
                   -ifqLen $val(ifqlen) \
                   -antType $val(ant) \
                   -propType $val(prop) \
                   -phyType $val(netif) \
                   -channelType $val(chan) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace OFF \
                   -movementTrace ON
                   
      for {set i 0} {$i < $val(nn) } { incr i } {
            set node_($i) [$ns node]      
      }

## Provide initial location of mobilenodes..
#and coloring the nodes

$node_(0) set X_ 313
$node_(0) set Y_ 72
$node_(0) set Z_ 0.0
$node_(0) color "red" 
$ns at 0.0 "$node_(0) color red"

$node_(1) set X_ 114
$node_(1) set Y_ 133
$node_(1) set Z_ 0.0
$node_(1) color "yellow" 
$ns at 0.0 "$node_(1) color yellow"

$node_(2) set X_ 238
$node_(2) set Y_ 384
$node_(2) set Z_ 0.0
$node_(2) color "yellow" 
$ns at 0.0 "$node_(2) color yellow"

$node_(3) set X_ 24
$node_(3) set Y_ 227
$node_(3) set Z_ 0.0
$node_(3) color "yellow" 
$ns at 0.0 "$node_(3) color yellow"

$node_(4) set X_ 205
$node_(4) set Y_ 230
$node_(4) set Z_ 0.0
$node_(4) color "yellow" 
$ns at 0.0 "$node_(4) color yellow"

$node_(5) set X_ 257
$node_(5) set Y_ 15
$node_(5) set Z_ 0.0
$node_(5) color "yellow" 
$ns at 0.0 "$node_(5) color yellow"

$node_(6) set X_ 150
$node_(6) set Y_ 335
$node_(6) set Z_ 0.0
$node_(6) color "red" 
$ns at 0.0 "$node_(6) color red"

$node_(7) set X_ 400
$node_(7) set Y_ 106
$node_(7) set Z_ 0.0
$node_(7) color "black" 
$ns at 0.0 "$node_(7) color black"

$node_(8) set X_ 226
$node_(8) set Y_ 119
$node_(8) set Z_ 0.0
$node_(8) color "yellow" 
$ns at 0.0 "$node_(8) color yellow"

$node_(9) set X_ 104
$node_(9) set Y_ 65
$node_(9) set Z_ 0.0
$node_(9) color "blue" 
$ns at 0.0 "$node_(9) color blue"

$node_(10) set X_ 476
$node_(10) set Y_ 347
$node_(10) set Z_ 0.0
$node_(10) color "brown" 
$ns at 0.0 "$node_(10) color brown"

$node_(11) set X_ 20
$node_(11) set Y_ 307
$node_(11) set Z_ 0.0
$node_(11) color "yellow" 
$ns at 0.0 "$node_(11) color yellow"

$node_(12) set X_ 184
$node_(12) set Y_ 81
$node_(12) set Z_ 0.0
$node_(12) color "yellow" 
$ns at 0.0 "$node_(12) color yellow"

$node_(13) set X_ 371
$node_(13) set Y_ 270
$node_(13) set Z_ 0.0
$node_(13) color "blue" 
$ns at 0.0 "$node_(13) color blue"

$node_(14) set X_ 55
$node_(14) set Y_ 360
$node_(14) set Z_ 0.0
$node_(14) color "yellow" 
$ns at 0.0 "$node_(14) color yellow"

$node_(15) set X_ 420
$node_(15) set Y_ 253
$node_(15) set Z_ 0.0
$node_(15) color "yellow" 
$ns at 0.0 "$node_(15) color yellow"

$node_(16) set X_ 90
$node_(16) set Y_ 231.0
$node_(16) set Z_ 0.0
$node_(16) color "black" 
$ns at 0.0 "$node_(16) color black"

$node_(17) set X_ 296
$node_(17) set Y_ 10.0
$node_(17) set Z_ 0.0
$node_(17) color "yellow" 
$ns at 0.0 "$node_(17) color yellow"

$node_(18) set X_ 266
$node_(18) set Y_ 170
$node_(18) set Z_ 0.0
$node_(18) color "yellow" 
$ns at 0.0 "$node_(18) color yellow"

$node_(19) set X_ 397
$node_(19) set Y_ 26
$node_(19) set Z_ 0.0
$node_(19) color "brown" 
$ns at 0.0 "$node_(19) color brown"



# Generation of movements
$ns at 18.0 "destination"
proc destination {} {
      global ns val node_ 
      set time 1.0
      set now [$ns now]
      for {set i 0} {$i<$val(nn)} {incr i} {
            set xx [expr rand()*800]
            set yy [expr rand()*500]
            $ns at $now "$node_($i) setdest $xx $yy 200.0"
      }
      $ns at [expr $now+$time] "destination"
}


# Set a TCP connection between node_(0) and node_(6)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(0) $tcp
$ns attach-agent $node_(6) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
#set cbr0 [new Application/Traffic/CBR]
#$cbr0 attach-agent $tcp
#$cbr0 set packetSize_ 100
#$cbr0 set rate_ 100Kb
$ns at 5.0 "$ftp start"
$ns at 50.0 "$ftp stop"
#$ns at 1.0 "$cbr0 start"
#$ns at 10.0 "$cbr0 stop"


# Set a TCP connection between node_(7) and node_(16)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(7) $tcp
$ns attach-agent $node_(16) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 8.0 "$ftp start"
$ns at 75.0 "$ftp stop"

# Set a TCP connection between node_(9) and node_(13)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(9) $tcp
$ns attach-agent $node_(13) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 15.0 "$ftp start"
$ns at 85.0 "$ftp stop"

# Set a TCP connection between node_(10) and node_(19)
set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node_(10) $tcp
$ns attach-agent $node_(19) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 15.0 "$ftp start"
$ns at 100.0 "$ftp stop"

# Printing the window size
proc plotWindow {tcpSource file} {
global ns
set time 0.01
set now [$ns now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns at [expr $now+$time] "plotWindow $tcpSource $file" }
$ns at 10.1 "plotWindow $tcp $windowVsTime" 

# Define node initial position in nam
for {set i 0} {$i < $val(nn)} { incr i } {
# 30 defines the node size for nam
$ns initial_node_pos $node_($i) 30
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "$node_($i) reset";
}


# ending nam and the simulation 
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"
$ns at 150.01 "puts \"end simulation\" ; $ns halt"
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
exec nam aodv.nam &
#exec xgraph win.tr -geometry 500×500 
exit 0
}

$ns run
