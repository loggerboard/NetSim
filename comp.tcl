set opt(chan)           Channel/WirelessChannel    ;# channel type 
set opt(prop)           Propagation/TwoRayGround   ;# radio-propagation model 
set opt(netif)          Phy/WirelessPhy            ;# network interface type 
set opt(mac)            Mac/802_11                 ;# MAC type 
set opt(ifq)            Queue/DropTail/PriQueue    ;# interface queue type 
set opt(ll)             LL                         ;# link layer type 
set opt(ant)            Antenna/OmniAntenna        ;# antenna model 
set opt(ifqlen)         50                         ;# max packet in ifq 
set opt(nn)             20                         ;# number of mobilenodes 
set opt(rp)             AODV                       ;# routing protocol 
set opt(x)              1000   			           ;# X dimension of topography 
set opt(y)              750   			           ;# Y dimension of topography
set opt(ps)             1000                       ;# packet size
set opt(stop)           50                         ;# time of simulation end

### Setting The Simulator Objects
          
set ns_ [new Simulator]
#create the nam and trace file:
set tracefd [open shubh.tr w]
$ns_ trace-all $tracefd

set namtrace [open shubh.nam w]
$ns_ namtrace-all-wireless $namtrace  $opt(x) $opt(y)

set topo [new Topography]
$topo load_flatgrid $opt(x) $opt(y)
create-god $opt(nn)
set chan_1_ [new $opt(chan)]

####  Setting The Distance Variables
               

# For model 'TwoRayGround'
set dist(5m)  7.69113e-06
set dist(9m)  2.37381e-06
set dist(10m) 1.92278e-06
set dist(11m) 1.58908e-06
set dist(12m) 1.33527e-06
set dist(13m) 1.13774e-06
set dist(14m) 9.81011e-07
set dist(15m) 8.54570e-07
set dist(16m) 7.51087e-07
set dist(20m) 4.80696e-07
set dist(25m) 3.07645e-07
set dist(30m) 2.13643e-07
set dist(35m) 1.56962e-07
set dist(40m) 1.56962e-10
set dist(45m) 1.56962e-11
set dist(50m) 1.20174e-13
Phy/WirelessPhy set CSThresh_ $dist(50m)
Phy/WirelessPhy set RXThresh_ $dist(50m)

#  Defining Node Configuration
                
          $ns_ node-config -adhocRouting $opt(rp) \
           -llType $opt(ll) \
           -macType $opt(mac) \
           -ifqType $opt(ifq) \
           -ifqLen $opt(ifqlen) \
           -antType $opt(ant) \
           -propType $opt(prop) \
           -phyType $opt(netif) \
           -topoInstance $topo \
           -agentTrace ON \
           -routerTrace ON \
           -macTrace ON \
           -movementTrace ON \
           -channel $chan_1_

###  Creating The WIRELESS NODES
          
set n0 [$ns_ node]
set n1 [$ns_ node]
set n2 [$ns_ node]
set n3 [$ns_ node]
set n4 [$ns_ node]
set n5 [$ns_ node]
set n6 [$ns_ node]
set n7 [$ns_ node]
set n8 [$ns_ node]
set n9 [$ns_ node]
set n10 [$ns_ node]
set n11 [$ns_ node]
set n12 [$ns_ node]
set n13 [$ns_ node]
set n14 [$ns_ node]
set n15 [$ns_ node]
set n16 [$ns_ node]
set n17 [$ns_ node]
set n18 [$ns_ node]
set n19 [$ns_ node]

#set opt(seed) 0.1
#set a [ns-random $opt(seed)]
#set i 0
#while {$i < 5} {
#incr i
#}
    

###  Setting The Initial Positions of Nodes

$n0 set X_ 22.0
$n0 set Y_ 343.0
$n0 set Z_ 0.0

$n1 set X_ 906.0
$n1 set Y_ 318.0
$n1 set Z_ 0.0

$n2 set X_ 504.0
$n2 set Y_ 442.0
$n2 set Z_ 0.0

$n3 set X_ 458.0
$n3 set Y_ 99.0
$n3 set Z_ 0.0

$n4 set X_ 174.0
$n4 set Y_ 216.0
$n4 set Z_ 0.0

$n5 set X_ 752.0
$n5 set Y_ 738.0
$n5 set Z_ 0.0

$n6 set X_ 916.0
$n6 set Y_ 88.0
$n6 set Z_ 0.0

$n7 set X_ 51.0
$n7 set Y_ 589.0
$n7 set Z_ 0.0

$n8 set X_ 26.0
$n8 set Y_ 39.0
$n8 set Z_ 0.0

$n9 set X_ 966.0
$n9 set Y_ 495.0
$n9 set Z_ 0.0

$n10 set X_ 451.0
$n10 set Y_ 664.0
$n10 set Z_ 0.0

$n11 set X_ 854.0
$n11 set Y_ 653.0
$n11 set Z_ 0.0

$n12 set X_ 636.0
$n12 set Y_ 587.0
$n12 set Z_ 0.0

$n13 set X_ 416.0
$n13 set Y_ 300.0
$n13 set Z_ 0.0

$n14 set X_ 286.0
$n14 set Y_ 566.0
$n14 set Z_ 0.0

$n15 set X_ 86.0
$n15 set Y_ 494.0
$n15 set Z_ 0.0

$n16 set X_ 415.0
$n16 set Y_ 513.0
$n16 set Z_ 0.0

$n17 set X_ 242.0
$n17 set Y_ 91.0
$n17 set Z_ 0.0

$n18 set X_ 283.0
$n18 set Y_ 478.0
$n18 set Z_ 0.0

$n19 set X_ 599.0
$n19 set Y_ 207.0
$n19 set Z_ 0.0


## Giving Mobility to Nodes
#$ns_ at 0.20 "$n0 setdest 502.0 297.0 28.0"
#$ns_ at 1.25 "$n1 setdest 690.0 299.0 10.0"
#$ns_ at 0.75 "$n2 setdest 647.0 178.0 29.0"
#$ns_ at 0.75 "$n3 setdest 430.0 450.0 30.0"
#$ns_ at 0.20 "$n4 setdest 364.0 157.0 33.0"
#$ns_ at 1.25 "$n5 setdest 607.0 561.0 37.0"
#$ns_ at 0.75 "$n6 setdest 383.0 436.0 5.0"
#$ns_ at 0.75 "$n7 setdest 477.0 190.0 26.0"
#$ns_ at 1.50 "$n8 setdest 320.0 273.0 12.0"
#$ns_ at 1.25 "$n9 setdest 425.0 720.0 28.0"
#$ns_ at 1.25 "$n10 setdest 880.0 489.0 16.0"
#$ns_ at 1.25 "$n11 setdest 220.0 550.0 33.0"
#$ns_ at 0.50 "$n12 setdest 1.0 19.0 25.0"
#$ns_ at 0.25 "$n13 setdest 649.0 333.0 34.0"
#$ns_ at 1.25 "$n14 setdest 228.0 497.0 2.0"
#$ns_ at 1.25 "$n15 setdest 475.0 257.0 14.0"
#$ns_ at 1.25 "$n16 setdest 771.0 411.0 12.0"
#$ns_ at 1.25 "$n17 setdest 377.0 275.0 29.0"
#$ns_ at 0.75 "$n18 setdest 505.0 744.0 22.0"
#$ns_ at 0.75 "$n19 setdest 735.0 356.0 31.0"
 
# Generation of movements
$ns_ at 18.0 "destination"
proc destination {} {
      global ns_ opt node_ 
      set time 1.0
      set now [$ns_ now]
      for {set i 0} {$i<$opt(nn)} {incr i} {
            set xx [expr rand()*$opt(x)]
            set yy [expr rand()*$opt(y)]
            $ns_ at $now "$n$i setdest $xx $yy 40.0"
      }
      $ns_ at [expr $now+$time] "destination"
}
   
## Setting The Node Size
                      
$ns_ initial_node_pos $n0 50
$ns_ initial_node_pos $n1 50
$ns_ initial_node_pos $n2 50
$ns_ initial_node_pos $n3 50
$ns_ initial_node_pos $n4 50
$ns_ initial_node_pos $n5 50
$ns_ initial_node_pos $n6 50
$ns_ initial_node_pos $n7 50
$ns_ initial_node_pos $n8 50
$ns_ initial_node_pos $n9 50
$ns_ initial_node_pos $n10 50
$ns_ initial_node_pos $n11 50
$ns_ initial_node_pos $n12 50
$ns_ initial_node_pos $n13 50
$ns_ initial_node_pos $n14 50
$ns_ initial_node_pos $n15 50
$ns_ initial_node_pos $n16 50
$ns_ initial_node_pos $n17 50
$ns_ initial_node_pos $n18 50
$ns_ initial_node_pos $n19 50

$n0 color maroon
$ns_ at 0.0 "$n0 color green"

$n1 color maroon
$ns_ at 0.0 "$n1 color green"

$n2 color green
$ns_ at 0.0 "$n2 color green"

$n3 color green
$ns_ at 0.0 "$n3 color brown"

$n4 color green
$ns_ at 0.0 "$n4 color green"

$n5 color green
$ns_ at 0.0 "$n5 color orange"

$n6 color green
$ns_ at 0.0 "$n6 color green"

$n7 color green
$ns_ at 0.0 "$n7 color pink"

$n8 color green
$ns_ at 0.0 "$n8 color green"

$n9 color yellow
$ns_ at 0.0 "$n9 color green"

$n10 color yellow
$ns_ at 0.0 "$n10 color brown"

$n11 color yellow
$ns_ at 0.0 "$n11 color green"

$n12 color pink
$ns_ at 0.0 "$n12 color green"

$n13 color pink
$ns_ at 0.0 "$n13 color green"

$n14 color pink
$ns_ at 0.0 "$n14 color green"

$n15 color pink
$ns_ at 0.0 "$n15 color green"

$n16 color pink
$ns_ at 0.0 "$n16 color green"

$n17 color orange
$ns_ at 0.0 "$n17 color orange"

$n18 color orange
$ns_ at 0.0 "$n18 color green"

$n19 color orange
$ns_ at 0.0 "$n19 color pink"

## SETTING ANIMATION RATE 
$ns_ at 0.0 "$ns_ set-animation-rate 12.5ms"

#  COLORING THE NODES  
#$n9 color blue
#$ns_ at 4.71 "$n9 color blue"

#$ns_ at 7.43 "$n9 label TTLover"
#$ns_ at 7.55 "$n9 label \"\""

### Establishing connection

set udp0 [$ns_ create-connection UDP $n10 LossMonitor $n3 0]
$udp0 set fid_ 1
set cbr0 [$udp0 attach-app Traffic/CBR]
$cbr0 set packetSize_ 1000    
$cbr0 set interopt_ .07
$ns_ at 0.0 "$cbr0 start"
$ns_ at [expr $opt(stop)-10.0] "$cbr0 stop"

set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns_ attach-agent $n7 $tcp
$ns_ attach-agent $n19 $sink
$ns_ connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns_ at 0.0 "$ftp start"

set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns_ attach-agent $n5 $tcp
$ns_ attach-agent $n17 $sink
$ns_ connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns_ at 0.0 "$ftp start"

#ANNOTATIONS DETAILS 

$ns_ at 0.0 "$ns_ trace-annotate \"MOBILE NODE MOVEMENTS\""
$ns_ at 4.1 "$ns_ trace-annotate \"NODE27 CACHE THE DATA FRO SERVER\""
$ns_ at 4.71 "$ns_ trace-annotate \"NODE10 CACHE THE DATA\""      
    
### PROCEDURE TO STOP 

proc stop {} {
    global ns_ tracefd
    $ns_ flush-trace
    close $tracefd
    exec nam shubh.nam &            
    exit 0
}

$ns_ at $opt(stop) "stop"
$ns_ run

