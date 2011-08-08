#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
my $progname = basename $0;

my $d2pda = 'mclass/d2/pda';
sub check_params();
sub usage_();

my @die_msgs = ();
(my $dir1, my $dir2, my $build_dir) = check_params();

my %object_file_globs = (
	"$d2pda/qt/$build_dir"                     => '*.o*',
	"$d2pda/qt/$build_dir/mvc"                 => 'QtViewFactory.o*',
	"$d2pda/qt/$build_dir/view/common"         => 'D2Style.o*',
	"$d2pda/qt/$build_dir/view/splash"         => 'QtSplashView.o*',
	"$d2pda/qt/$build_dir/view/classlist"      => '*.o*',
	"$d2pda/qt/$build_dir/view/common"         => '*.o*',
	"$d2pda/qt/$build_dir/view/studentsummary" => '*.o*',
	"$d2pda/$build_dir/controller2"            => 'HomeController.o*  ',
	"$d2pda/$build_dir/controller2"            => 'ClassListController.o*',
	"$d2pda/$build_dir/controller2"            => 'StudentSummaryController.o*',
	"$d2pda/$build_dir/view2/splash"           => '*.o* ',
	"$d2pda/$build_dir/view2/studentsummary"   => '*.o*',
	"$d2pda/$build_dir/view2/classlist"        => '*.o*',
);

my %obj_files = ();
foreach my $key (keys %object_file_globs) {
	my $glob = $object_file_globs{$key};
	foreach my $dir (($dir1, $dir2)) {
		foreach my $file (glob "$dir/$key/$glob") {
			$obj_files{$dir} = [] unless defined $obj_files{$dir};
			push @{$obj_files{$dir}}, $file;
		}
	}
}

use Data::Dumper;
Dumper %obj_files;

sub check_params()
{
	usage() if (scalar @ARGV < 2 or scalar @ARGV > 3);

	(my $dir1, my $dir2) = ($ARGV[0], $ARGV[1]);
	my $build_dir = "debug-DIABLO_X86";
	$build_dir = $ARGV[2] if (scalar @ARGV == 3);

	sub diel8r($) { push @die_msgs, shift }

	foreach my $dir (($dir1, $dir2)) {
		diel8r "Directory \`$dir' does not exist." unless (-d $dir);
		foreach my $qtdir (('', '/qt')) {
			my $specific_dir = "$dir/$d2pda$qtdir/$build_dir";
			diel8r "Directory \`$specific_dir' does not exist."
				unless (-d $specific_dir);
		}
	}

	if (scalar @die_msgs > 0) {
		foreach my $msg (@die_msgs) {
			print "$msg\n";
		}
		die "$progname: Some directories did not exist, cannot continue.\n";
	}

	return ($dir1, $dir2, $build_dir);
}

sub usage()
{
	print "usage: $progname <mclass-parent-1> <mclass-parent-2> [build-dir]\n";
	exit 1;
}
