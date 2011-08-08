#!/usr/bin/perl -w

my $arch;
my $os = `uname -s`;

# if no uname -- revert to old behavior
if ($? != 0) {
    use Config;
    my $arch_os = $Config{archname};

    # normalize ?86 architecture format
    $arch_os =~ s/[ix]86(pc)?|i[3456]86|athlon/i86pc/;
    $arch_os =~ s/i86pc_64/x86_64pc/;

    # normalize os names
    $arch_os =~ s/sun4/sparc/;
    $arch_os =~ s/SunOS/solaris/;
    $arch_os =~ s/Linux/linux/;
    $arch_os =~ s/MSWin32/win32/;

    $arch_os =~ s/-thread//;
    $arch_os =~ s/-multi//;

   	# On win32, the string is reversed
    if ($arch_os =~ /win32/) {
        ($os, $arch) = split(/-/, $arch_os);
    }
    else {
        ($arch, $os) = split(/-/, $arch_os);
    }
}

# uname is present, so use it
else {
    chomp($os);
    
    #  CYGWIN_NT-5.2-WOW64
    #  CYGWIN_NT-5.0
    
    $os =~ s/Linux/linux/;
    $os =~ s/SunOS/solaris/;
    $os =~ s/WindowsNT/win32/;
    $os =~ s/CYGWIN.*/win32/;
    $os =~ s/MINGW32.*/win32/;

    if ($os eq 'win32') {
        $arch = $ENV{PROCESSOR_ARCHITEW6432};
        $arch = $ENV{PROCESSOR_ARCHITECTURE} if !defined($arch);
        if ($arch =~ /64/) {
            $arch =~ s/AMD/x86_/;
        }
        else {
            $arch =~ s/x86/i86/
        }
    }
    else {
        if ($os eq 'solaris') {
            $arch = `/usr/bin/isainfo -n`;
            $arch =~ s/sparcv9/sparc/;
            if ($arch =~ /sparc/) {
                my $osver = `uname -r`;
            	$arch =~ s/sparc/sparc_64/ unless ($osver =~ /5\.[89]/);
            }
	        else {
                $arch =~ s/amd64/x86_64/;
            }
	    }
	    else {
	        $arch = `uname -p`;
	        $arch = `uname -m` if ($arch =~ /unknown/);
	    }
        $arch =~ s/i[3456]86|athlon/i86/;
    }
    chomp($arch);
    $arch .= "pc" if ($arch =~ /[ix]86/);
}

# now, handle requests for subparts
if (@ARGV > 0) {
	if ($ARGV[0] eq '-a') {
		print($arch, "\n");
	}
	elsif ($ARGV[0] eq '-o') {
		print($os, "\n");
	}
	else {
		die("usage: $0 [-a | -o]\n");
	}
}
else {
	print("$arch-$os\n");
}

