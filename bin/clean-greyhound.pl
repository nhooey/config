#!/usr/bin/perl

use strict;
use Time::Normalize;

my $file_schedule;
open($file_schedule, "< $ARGV[0]") or die "Couldn't open $ARGV[0]: $!";

while (<$file_schedule>)
{
	my $line = "";

	while (/([0-9]+):([0-9]+)(am|pm)/g)
	{
		my $hour;
		my $min;
		($hour, $min, undef, undef, undef, undef) = normalize_hms($1, $2, 0, $3);

		$line .= "    " if ($line ne "");
		$line .= "$hour:$min"
	}
	while (/([0-9]+)h, ([0-9]+)m/g)
	{
		my $time = sprintf("%02d:%02dm", $1, $2);
		$line .= "    " if ($line ne "");
		$line .= "$time"
	}
	$line .= "\n";

	print $line;
}
