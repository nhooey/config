#!/usr/bin/perl
# cvsup
# Updates cvs directories using rover

use strict;
use File::Basename;

my %products = {
	'd2'      => 'd2_pda_qt',
	'r3d2'    => 'r3d2_pda_maemo_dev',
	'r3d2-rc' => 'r3d2_pda_qt_prod',
	'sync'    => 'sync_client_maemo'
};

if (scalar @ARGV != 2) {
	usage();
	exit 1;
}

sub usage()
{
	my $progname = basename $0;
	print "usage: $progname <source-dir> <product>\n" .
	      "Choose a product from the list:\n";
}
