# .bash_profile

echo_dot_bashprofile=''
if [ -f "/tmp/echo-login-script" ]; then
	echo_dot_bashprofile="echo '~/.bash_profile'"
fi

$echo_dot_bashprofile

# Run stuff that's not on every machine
if [ -f ~/.bash_local ]; then
	. ~/.bash_local
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/bin:$HOME/bin/shutter:$PATH
alias config='git --git-dir=/home/neil/.config.git/ --work-tree=/home/neil'

export PATH
unset USERNAME

$echo_dot_bashprofile
