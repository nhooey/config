# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=always'

alias config='git --git-dir=/home/neil/.config.git/ --work-tree=/home/neil'

alias tree='tree -C | less -R'

if [ -f '/usr/local/Cellar/coreutils/8.12/aliases' ]; then
	. '/usr/local/Cellar/coreutils/8.12/aliases'
fi

ANT="$HOME/code/oss/apache-ant-1.8.2/bin/ant"
if [ -f $ANT ]; then
	alias ant="JAVA_HOME=$HOME/code/oss/jdk1.6.0_24 $ANT"
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	eval "`dircolors -b`"
	if alias ls > /dev/null 2>&1; then
		LS_CMD=$(alias ls | perl -pe "s/[^\']+[\']([^\']+)'/\1/")
		alias ls="$LS_CMD --color=auto"
	fi
	alias dir='ls --color=auto --format=vertical'
	alias vdir='ls --color=auto --format=long'
fi
