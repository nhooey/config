#!/usr/bin/perl

use strict;
use Data::Dumper;

sub debug();
sub cmp_md5($$);
sub split_md5($);

foreach (@ARGV) {
	if ($_ eq '--debug') {
		debug();
		exit 0;
	}
}

my @lines;
while (<>) {
	chomp $_;
	push @lines, $_;
}

foreach my $line (sort {cmp_md5 $a, $b} @lines) {
	my %h = %{split_md5 $line};
	printf "%42s %55s %32s\n", $h{'file'}, $h{'path'}, $h{'md5'};
}

sub split_md5($)
{
	(my $path) = @_;
	(my $md5, my $path, my $file) = ($path =~ /(\w+)\s*(.*\/)(.*)$/);
	return {
		'md5'  => $md5,
		'path' => $path,
		'file' => $file,
	};
}

sub cmp_md5($$)
{
	(my $a, my $b) = @_;
	my %ha = %{split_md5 $a};
	my %hb = %{split_md5 $b};

	foreach (('file', 'path', 'md5')) {
		my $key = $_;

		return 1  if ($ha{$key} gt $hb{$key});
		return -1 if ($ha{$key} lt $hb{$key});
	}

	return 0;
}


sub debug()
{
	print "Test: md5 mapping\n";
	my $str_split = '2197c75b247b0953e410d4d19c35f843  '
		. 'insteon-new/src-old/insteon-perl6-named-matches.pl';
	my %md5_hash = %{split_md5($str_split)};
	foreach my $key (keys %md5_hash) {
		print "    $key => " . $md5_hash{$key} . "\n";
	}
	print "\n";

	print "Test: md5 compare\n";
	my @md5_list = (
		['aaaaaaaa aaa/aaa.txt', 'aaaaaaaa aaa/aaa.txt'],
		['aaaaaaaa aaa/aaa.txt', 'aaaaaaaa aaa/bbb.txt'],
		['aaaaaaaa bbb/aaa.txt', 'aaaaaaaa aaa/aaa.txt'],

		['aaaaaaaa aaa/aaa.txt', 'aaaaaaaa aaa/aaa.txt'],
		['aaaaaaaa aaa/aaa.txt', 'aaaaaaaa bbb/aaa.txt'],
		['aaaaaaaa bbb/aaa.txt', 'aaaaaaaa aaa/aaa.txt'],

		['aaaaaaaa aaa/aaa.txt', 'aaaaaaaa aaa/aaa.txt'],
		['aaaaaaaa aaa/aaa.txt', 'bbbbbbbb aaa/aaa.txt'],
		['bbbbbbbb aaa/aaa.txt', 'aaaaaaaa aaa/aaa.txt'],
	);

	foreach (@md5_list)
	{
		my @pair = @$_;
		(my $a, my $b) = ($pair[0], $pair[1]);
		printf "    $a cmp $b = %2d\n", cmp_md5($a, $b);	
	}
}

