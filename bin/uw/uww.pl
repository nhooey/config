#!/usr/bin/perl
# iwc.pl
# Wireless Connector

use strict;
use warnings;
use Switch;

my $INTERFACE = 'eth1';
my %waps;


sub enumerate_waps();


sub enumerate_waps()
{
	my $iwlist_scan = `iwlist $INTERFACE scan`;

	foreach my $line ($iwlist_scan)
	{
		if ($line =~ /^\s*Cell [0]*([0-9]+) - Address: (([0-9]{2}:){5}[0-9]{2})/)
		{
			print "Cell [$1]: $2\n";
		}
	}
}


enumerate_waps();
