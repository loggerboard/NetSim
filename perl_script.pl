##############################################################
###################www.ns2blogger.blogspot.in#################
###################ns2blogger@gmail.com#######################


#!/usr/bin/perl

use :strict;
if($#ARGV<0){
printf("Usage: <trace-file>\n");
exit 1;
}
# to open the given trace file
open(Trace, $ARGV[0]) or die "Cannot open the trace file";
my $sc = 0; # sending counter
my $rc = 0; # receiving counter
my $rp = 0;
my $mc =0;
my %pkt_fc = (); #packet forwarding counter
while(<Trace>){ # read one line in from the file
my @line = split; #split the line with delimin as space
if($line[3] eq "AGT" && $line[6] eq "cbr"){ # an application agent trace line
if($line[0] eq "s"){ # a packet sent by some data source
$sc++;
$pkt_fc{$line[5]} = 0; #define the forwarding couter for this pkt
}
if($line[0] eq "r"){ # a packet received by sink
$rc++;
$pkt_fc{$line[5]}++; # one more hop to complement
}
}
if($line[3] eq "MAC" && $line[6] eq "cbr")
{
if ($line[0] eq "s")
{ $mc++}
}
if($line[3] eq "RTR"){ # a routing agent trace lineOD
if($line[0] eq "f")
{
$rp++;
$pkt_fc{$line[5]}++;
}
}
}
close(Trace); #close the file
my $temp_rc =0;
my $pkt = 0;
foreach $pkt ( keys %pkt_fc )
{
$temp_rc += $pkt_fc{$pkt}; #the total forwarding times
}
if($rc > 0)
{
printf("sent packets= %d\n",$sc);
printf("received packets= %d\n",$rc);
printf("packets dropped=%d\n",$sc-$rc);
printf("routing agents=%d/n",$rp);
printf("routing overhead= %f\n",$rp/$sc*100);
printf("Packet delivery ratio %f\n",$rc/$sc);
printf("Average path length %f\n", $temp_rc/$rc);
}

#Command use to run perl script from terminal 
#perl filename.p tracefilename.tr
