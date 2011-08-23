# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias config='git --git-dir=/home/neil/.config.git/ --work-tree=/home/neil'

if [ -f '/usr/local/Cellar/coreutils/8.12/aliases' ]; then
	. '/usr/local/Cellar/coreutils/8.12/aliases'
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
