# setting options for simulation
set val(chan)           Channel/WirelessChannel    ;# channel type 
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model 
set val(netif)          Phy/WirelessPhy            ;# network interface type 
set val(mac)            Mac/802_11                 ;# MAC type 
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type 
set val(ll)             LL                         ;# link layer type 
set val(ant)            Antenna/OmniAntenna        ;# antenna model 
set val(ifqlen)         50                         ;# max packet in ifq 
set val(rp)             [lindex $argv 0]           ;# routing protocol
set val(x)              [lindex $argv 1]           ;# X dimension of topography 
set val(y)              [lindex $argv 1]           ;# Y dimension of topography 
set val(nn)             [lindex $argv 2]           ;# number of mobilenodes
set val(stop)           150                        ;# stop time

# set up simulator, nam and trace file
set ns_                 [new Simulator]
set tracefd             [open $val(rp)/$val(rp).tr w]
set namtrace            [open $val(rp)/$val(rp).nam w]

if { $val(rp) == "DSR" } {
    set val(ifq)        CMUPriQueue
}

$ns_ trace-all $tracefd
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo                [new Topography]
$topo load_flatgrid $val(x) $val(y)

# creating god object
create-god $val(nn)
set god_ [God instance]

# configure the nodes
$ns_ node-config -adhocRouting $val(rp) \
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
    set node_($i) [$ns_ node]      
}

# provide initial location of mobilenodes and generation of movement
source "NodesCreate.tcl"

# establishing communication
source "ConCreate.tcl"

# Define node initial position in nam
for {set i 0} {$i < $val(nn)} { incr i } {
    $ns_ initial_node_pos $node_($i) 30
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns_ at $val(stop) "$node_($i) reset";
}


# ending nam and the simulation 
$ns_ at $val(stop) "$ns_ nam-end-wireless $val(stop)"
$ns_ at $val(stop) "stop"
$ns_ at 150.01 "puts \"end simulation\" ; $ns_ halt"
proc stop {} {
    global ns_ tracefd namtrace
    $ns_ flush-trace
    close $tracefd
    close $namtrace
    #exec nam nfile.nam &
    exit 0
}

$ns_ run
