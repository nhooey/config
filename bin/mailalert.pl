#!/usr/bin/perl -w

# usage: mailalert.pl %sound %count %server %folder %sender %subject %charset

my $messager = 'gmessage';
my $player = 'play';
my $default_args = '-wrap -nofocus -center -font "sans 10"';
$default_args .= " -timeout 5";
#$default_args .= " -buttons \"\"";


my $sound = shift();
my $arg1 = shift();
my $arg2 = shift();
my $arg3 = shift();
my $arg4 = shift();
my $arg5 = shift();
my $arg6 = shift();

if ($arg6) {
	  $default_args .= " -encoding ".$arg6;
}


my $line1 = $arg1." new messages on ".$arg2."/".$arg3;
my $line2 = "Most recent from: ".$arg4;
my $line3 = "Subject: ".$arg5;

my $size = (length($line1) ) * 8;
my $size2 = (length($line2) ) * 8;

if ($size2 > $size) {
	  $size = $size2;
}

$size2 = (length($line3) ) * 8;

if ($size2 > $size) {
	  $size = $size2;
}

my $geom = "-geometry ${size}x1";
my $tempfile = `mktemp`;

system("echo '$line1' >> $tempfile");
system("echo '$line2' >> $tempfile");
system("echo '$line3' >> $tempfile");

my $cmd = $messager." ".$default_args." ".$geom." -file ".$tempfile;
#".$line1." ".$line2." ".$line3." ";

print STDERR  "ARGS: ".$arg1." ".$arg2." ".$arg3." ".$arg4." ".$arg5."\n";
print STDERR "LOG: ".$cmd."\n";

my $playcmd = $player." \"".$sound."\" &";

system($playcmd);
system($cmd);
system("rm $tempfile");
