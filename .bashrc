# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

echo_dot_bashrc=''
if [ -f "$HOME/.echo_login" ]; then
	echo_dot_bashrc="echo '~/.bashrc'"
fi

if [ -f ~/.installation_environment ]; then
	. ~/.installation_environment
fi

$echo_dot_bashrc

PATH="/opt/local/libexec/gnubin:$HOME/bin/shutter:$HOME/bin:$HOME/.gem/ruby/1.8/bin:/usr/local/bin:$PATH"

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

function __shutterstock_env()
{
	hostname="$(hostname)"
	if [[ $hostname =~ '.*DEV.*' ]]; then
		echo 'dev'
	elif [[ $hostname =~ '.*QA.*' ]]; then
		echo 'qa'
	elif [[ $hostname =~ '(worker[0-9]?|lvs[0-9]c)' ]]; then
		echo 'prod'
	else
		echo 'unknown'
	fi
}

# Inherit owner and group for new files
umask 002

function __color()
{
	visible-term-color "$(($(echo $1 | cksum | cut -c1-3) % 256))" "$1"
}

function __host_ps1()
{
	__color "$(hostname | egrep -o '^[^\.]+')"
}

HOSTNAME_COLOR=$(__host_ps1)

function __get_perl5lib() {
	REPO_DIR="$(__gitdir | sed -e 's/\/\?\.git//')"
	if [ "x$REPO_DIR" == "x" ]; then
		REPO_DIR="$(readlink -f $(pwd))"
	fi
	REPO_DIR="$(cd $REPO_DIR && pwd)"
	CORRECT_LIB="$BASE_PERL5LIB:$REPO_DIR/lib:$REPO_DIR/t/lib:$REPO_DIR/lil_brother/lib:$REPO_DIR/lil_brother/t/lib"
	echo -n $CORRECT_LIB
}

function ssperl5lib() {
	export PERL5LIB="$(__get_perl5lib)"
}

function __perl5lib_ok() {
	if ! type -t __gitdir > /dev/null; then
		return 1
	fi
	if [ "x$(__gitdir)" != "x" ]; then
		if [ "$PERL5LIB" != "$(__get_perl5lib)" ]; then
			tput setaf 1
			echo -n '[p]'
			tput sgr0
		fi
	fi
}

function __git_ps1_branch()
{
	if __gitdir > /dev/null 2>&1; then
		__color "[$(basename "$(dirname "$(echo $(cd "$(__gitdir)"; pwd))")")]"
	fi
	if __git_ps1 > /dev/null 2>&1; then
		if [[ $(__git_ps1) =~ '\|' ]]; then
			tput setaf 1
			__git_ps1 "[%s]"
			tput sgr0
		elif [[ $(__git_ps1) =~ ':' ]]; then
			tput setaf 2
			__git_ps1 "[%s]"
			tput sgr0
		else
			__color "$(__git_ps1 "[%s]")"
		fi
	fi
}

alias tmux='TERM=xterm-256color tmux'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm|xterm-256color|linux|screen|vt320|ansi)
	# Detect screen's window number
	SCREEN_WIN=""
	if [ "x$WINDOW" != "x" ]; then
		SCREEN_WIN="[$WINDOW]"
	fi

	PS1='\[\033[00;31m\]$(r=$?; if test $r -ne 0; then echo "[$r]"; set ?=$r; unset r; fi)\[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;37m\]\u\[\033[01;30m\]@$HOSTNAME_COLOR$(__perl5lib_ok)$(__git_ps1_branch):\[\033[00;36m\]\w\[\033[00m\]
\[\033[01;30m\]$(date +"%Y-%m-%d %H:%M:%S")\[\033[00m\] \[\033[00;34m\]\$\[\033[00m\] '
	;;
*)
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|screen)
	PROMPT_COMMAND='history -a; history -n; echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
	;;
*)
	;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	eval "`dircolors -b`"
	alias ls='ls --color=auto'
	alias dir='ls --color=auto --format=vertical'
	alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi
if [ -f /etc/bash_completion.d/git ]; then
	. /etc/bash_completion.d/git
fi

# Neil Hooey
if [ -f /usr/bin/most ]; then
	export MANPAGER="/usr/bin/most -s"
else
	export MANPAGER="/usr/bin/less"
fi
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='0;36'
export HISTCONTROL=erasedups
export HISTSIZE=1000000
shopt -s histappend

# Shutterstock
export BASE_PERL5LIB=/home/neil/perl5/lib/perl5
export PERL5LIB="$BASE_PERL5LIB"
export CVSROOT=/data/export/code/cvsroot
export PERL_CPANM_OPT="--local-lib=~/perl5"
if [ $(__shutterstock_env) == 'dev' ]; then
	eval $(perl -I $HOME/perl5/lib/perl5 -Mlocal::lib)
fi

PATH="$HOME/bin/shutter:$HOME/bin:/usr/local/bin:$PATH"

# Git
if [ -f "/usr/local/src/git-1.7.1/contrib/completion/git-completion.bash" ]; then
	source /usr/local/src/git-1.7.1/contrib/completion/git-completion.bash
elif [ -f "$HOME/.git-completion.bash" ]; then
	source "$HOME/.git-completion.bash"
fi

alias config='git --git-dir=/home/neil/.config.git/ --work-tree=/home/neil'

# Sorting Algorithms
#hostname=$(hostname)
#if [[ $hostname =~ '.*DEV-data.*' ]]; then
#	PERL5LIB="$HOME/git/search/lib"
#	echo "Overriding PERL5LIB to $PERL5LIB"
#	export PERL5LIB
#fi

$echo_dot_bashrc
