#!/bin/awk -f
BEGIN {
    seqno = -1; 
    droppedPackets = 0;
    receivedPackets = 0;
    count = 0;
    totalTime = 150;
    controlPackets = 0;
}
{
    #packet delivery ratio
    if($4 == "AGT" && $1 == "s" && seqno < $6) {
        seqno = $6;
    } else if(($4 == "AGT") && ($1 == "r")) {
        receivedPackets++;
    } else if ($1 == "D" && $7 == "tcp" && $8 > 512){
        droppedPackets++; 
    }
    #end-to-end delay
    if($4 == "AGT" && $1 == "s") {
        start_time[$6] = $2;
    } else if(($7 == "tcp") && ($1 == "r")) {
        end_time[$6] = $2;
    } else if($1 == "D" && $7 == "tcp") {
        end_time[$6] = -1;
    }
    #control packets
    if (($1 == "s" || $1 == "f") && $4 == "RTR" && ($7 =="AODV" || $7 =="DSDV" || $7 =="DSR" || $7 =="message")) {
        controlPackets++;
    }
}
END { 
    for(i=0; i<=seqno; i++) {
        if(end_time[i] > 0) {
            delay[i] = end_time[i] - start_time[i];
            count++;
        }
        else {
            delay[i] = -1;
        }
    }
    for(i=0; i<count; i++) {
        if(delay[i] > 0) {
            n_to_n_delay = n_to_n_delay + delay[i];
        } 
    }
    n_to_n_delay = n_to_n_delay/count;
    # Throughput
    print "TP\t" receivedPackets/150;
    # Packet Delivery Ratio
    print "PDR\t" receivedPackets/(seqno+1)*100;
    # Average End-to-End Delay
    print "AED\t" n_to_n_delay * 1000;
    # Control or Routing overhead
    print "CO\t" controlPackets;    
    # GeneratedPackets
    #print "GP\t" seqno+1;
    # ReceivedPackets
    #print "RP\t" receivedPackets;    
    # Total Dropped Packets
    #print "TDP\t" droppedPackets;
    
}
