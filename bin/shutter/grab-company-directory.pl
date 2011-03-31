#!/usr/bin/perl

use strict;
use Getopt::Long;
use File::Basename;
use File::Slurp qw(slurp);
my $progname = basename $0;

my $admin_url = 'http://admin.shutterstock.com/78625';

my %hr_opts = (
	'company-directory' => $admin_url . '/company_directory.mhtml',
	'cookies'           => undef,
	'directory-path'    => '/tmp/company-directory.html',
);
my %opts = (
	"company-directory=s" => \$hr_opts{'company-directory'},
	"cookies=s"           => \$hr_opts{'cookies'},
);

my $result = GetOptions(%opts);

sub usage();

unless ($result and scalar @ARGV >= 1 and scalar @ARGV <= 1) {
	usage();
	exit 1;
}

my $dest_dir = $ARGV[0];
unless (-d $dest_dir) {
	printf STDERR "$progname: Destination directory: \`$dest_dir' does not exist.\n";
	exit 3;
}

my $wget_cookie_param = '';
if (defined $hr_opts{'cookies'} and not -e $hr_opts{'cookies'}) {
	printf STDERR "$progname: Cookie file \`" . $hr_opts{'cookies'}
		. "' does not exist.\n";
		exit 3;
} else {
	$wget_cookie_param = "--load-cookies " . $hr_opts{'cookies'};
}

my $wget_directory = "wget --no-check-certificate $wget_cookie_param '"
	. $hr_opts{'company-directory'} . "' -O " . $hr_opts{'directory-path'}
		or die "Failed to download company directory at: "
			. $hr_opts{'company-directory'} . "\n";
system $wget_directory;

my $file_text = slurp $hr_opts{'directory-path'};

while ($file_text =~ /(images\/employees\/[^\"]+\.jpg).*\n.*\n.*\n\s*(\w+\s+\w+)/g) {
	my ($employee_name, $image_address) = ($2, "$admin_url/$1");
	print "Name:    $employee_name\n"
		. "Address: $image_address\n";
	system "wget --no-check-certificate $wget_cookie_param \"$image_address\""
		. " -O \"$dest_dir/$employee_name.jpg\"";
}

sub usage()
{
	printf STDERR "usage: $progname <destination-dir>\n"
		.         "        " . (' ' x length($progname))
		. "[--company-directory http://...dir.html]\n"
		.         "        " . (' ' x length($progname))
		. "[--cookies cookies-file.txt]\n"
		. "\n"
		. "Download the Firefox addon \"IE-Like Cookie Exporter\" from here:\n"
		. "http://bit.ly/ie-like-cookie-exporter\n\n"
		. "Then click 'Tools > Export Cookies', and feed them to this script.\n"
		. "\n";
}
