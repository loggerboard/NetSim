# type: perl throughput.pl <trace file> <required node> <granularity> > file

$infile=$ARGV[0];
$tonode=$ARGV[1];
$granularity=$ARGV[2];

#we compute how many bytes were transmitted during the time period specified by granularity parameter in seconds
$sum=0;
$clock=0;

open (DATA, "<$infile") || die "Can't open $infile $!";
while (<DATA>) {
    @x=split(' ');
    #col 1 is time
    if ($x[1]-$clock <= $granularity)
    {
        #checking if the event corresponds to a reception
        if($x[0] eq 'r')
        {
            #checking if the destination corresponds to 1st arguement
            if ($x[2] eq '_'.$tonode.'_')
            {
                #checking if packet type is TCP
                if ($x[6] eq 'tcp')
                {
                    $sum=$sum+$x[7];
                }
            }
        }
    }
    else
    {
        $throughput=$sum/$granularity;
        print STDOUT "$x[1] $throughput\n";
        $clock=$clock+$granularity;
        $sum=0;
    }
}
$throughput=$sum/$granularity;
print STDOUT "$x[1] $throughput\n";
$clock=$clock+$granularity;
$sum=0;

close DATA;
exit(0);
