
#!/usr/bin/perl
#
#Program to calculate end to end delay.
#
#1. Program reads the trace file, finds for combination of 's' source event and 'AGT' packet type. 
#2. For this combination, the program takes the packet id and timestamp.
#3. Within the same file, the program searches for a combination of 'r' receive event and 'AGT' packet type.
#4. For this combination, the program takes the packet id and compares with previous packet id. If they are same, timestamp is noted.
#5. Difference between step 4 timestamp and step 3 timestamp gives the end to end delay for that packet.
#6. Delays are aggregated and average delay is found.
#

#use strict;
use warnings;

$SIG{INT} = sub {
	my (@stack, $level);
	while(1)
	{
		my ($pkg, $fn, $ln, $sub) = caller($level++);
		if (!($pkg or $fn or $ln or $sub)) {
			for (my $i = 0; $i < @stack; $i++) {
				print " " x $i, $stack[$i], "\n";
			}
			exit;
		}
		unshift @stack, "-> $pkg: $fn (line $ln) sub $sub";
	}
};

#Input trace file
my($infile) =$ARGV[0]; 

#Keep track of variables
my($enqueue_time) = 0;
my($receive_time) = 0;
my($packet_id) = 0;
my($delay) = 0;
my($total_receive_count) = 0;
my($sum_of_delay) = 0;
my($average_delay) = 0;
my($simulation_time) = 0;
my($file_position) = 0;
my (@x);

open(DATA,"<","$infile" ) || die "could't open $infile$!";

while(<DATA>)
{
	@x=split(' ');
	if(($x[0] eq 's') && ($x[3] eq 'AGT'))
	{
		$file_position = tell(DATA);
		$enqueue_time = $x[1];
		$packet_id = $x[5];
		while(<DATA>)
		{
           @x=split(' ');
			if(($x[0] eq 'r') && ($x[3] eq 'AGT'))
			{
				if(($x[5] == $packet_id))
				{
					$receive_time = $x[1];
					$total_receive_count++;
					$delay = $receive_time - $enqueue_time;
					$sum_of_delay = $sum_of_delay + $delay;

					#Following is for debug.
					$delay = $delay * 1000;
					print("\nDelay:$delay");

					last;
				}
			}
		}
		#Continue to search for next 's' event from where the previous 's' was found.
		#So move to the same line where previous 's' event was found.
	seek(DATA,$file_position,SEEK_SET);
	}
	#While(<DATA>) takes care of moving to the next line.
}

$simulation_time = $x[1];

print("\n Simulation Time = $simulation_time seconds");
print("\n Total Receive Count = $total_receive_count");

if($total_receive_count != 0 )
{
	$average_delay = $sum_of_delay / $total_receive_count;
	$average_delay = $average_delay * 1000;
	print("\n Average End to End Delay = $average_delay milliseconds");
}
else
{
	print("\n No packet received.");
}

print("\n");
print("\n");
close DATA;
exit(0);
