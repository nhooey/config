# .bash_profile

echo_dot_bashprofile=':'
if [ -f "$HOME/.echo_login" ]; then
    echo_dot_bashprofile="echo '~/.bash_profile' $*"
fi

$echo_dot_bashprofile '>>'

# Run stuff that's not on every machine
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

unset USERNAME

export HOMEBREW_GITHUB_API_TOKEN='641dbfbb2c1f68ea38d0801f4fb7f38170ab4a95'

export EDITOR=vim
export CLICOLOR=1

if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

if [ -f "$HOME/bin/visible-term-color.sh" ]; then
    . "$HOME/bin/visible-term-color.sh"
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# refuse to clobber files with '>', force with '>|'
shopt -s -o noclobber

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Inherit owner and group for new files
umask 002

function __color()
{
    __visible_term_color "$(($(echo $1 | cksum | cut -c1-3) % 256))" "$1"
}

function __virtual_host()
{
    VHOST=$(echo $HOSTNAME | cut -f 1-2 -d.)
    if [[ $1 && $1 -gt 0 ]]; then
        printf "%-$1s\n" $VHOST
    else
        echo $VHOST
    fi
}

function __host_ps1()
{
    __color "$(__virtual_host)"
}

HOSTNAME_COLOR=$(__host_ps1)
UNIQUE_ID="$(hostname):$(tty)"
mkdir $HOME/.bashrc.variables 2> /dev/null

function __color_pwd()
{
    __color "$(pwd | sed -e "s,^$HOME,~,")"
}

function __git_ps1_branch()
{
    GITDIR=$(__gitdir 2> /dev/null)
    GITDIR_SUCCESS=$?

    # Colourize the git directory if it exists
#    if [ $GITDIR_SUCCESS -eq 0 ]; then
#        __color "[$(basename "$(dirname "$(echo $(cd "$GITDIR"; pwd))")")]"
#    fi

    GIT_PS1=$(__git_ps1 "[%s]" 2> /dev/null)
    GIT_PS1_SUCCESS=$?

#    if [[ $GIT_PS1 != "" ]]; then
#        if [[ $GIT_PS1 =~ '\|' ]]; then
#            tput setaf 1
#            echo $GIT_PS1
#            tput sgr0
#        elif [[ $GIT_PS1 =~ ':' ]]; then
#            tput setaf 2
#            echo $GIT_PS1
#            tput sgr0
#        else
            GIT_PS1_COLOR=$(__color "$GIT_PS1")
            echo $GIT_PS1_COLOR
#        fi
#    fi
}

# Enable 256 colours in tmux
alias tmux='TERM=xterm-256color tmux'

# Fix ncurses refresh inside tmux
if [ -n $TMUX ] && infocmp screen-256color > /dev/null 2>&1; then
    export TERM='screen-256color'
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm*|linux|screen*|vt320|ansi)
    # Detect screen's window number
    SCREEN_WIN=""
    if [ "x$WINDOW" != "x" ]; then
        SCREEN_WIN="[$WINDOW]"
    fi

    PS1='\[\033[40;1;41m\]$(r=$?; if test $r -ne 0; then echo "[$r]"; set ?=$r; unset r; fi)\[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;37m\]\u\[\033[01;30m\]@$HOSTNAME_COLOR$(__git_ps1_branch):$(__color_pwd)
\[\033[01;30m\]$(date +"%Y-%m-%d %H:%M:%S")\[\033[00m\] \[\033[00;34m\]\$\[\033[00m\] '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

if [[ $OSTYPE == darwin* ]]; then
    if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
        source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|screen*)
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
alias grep='grep --color=auto'
export GREP_COLOR='0;36'
export HISTCONTROL=erasedups
export HISTSIZE=1000000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Git
if [ -f "$HOME/.git-completion.bash" ]; then
    source "$HOME/.git-completion.bash"
fi

alias config="git --git-dir=$HOME/.config.git/ --work-tree=$HOME"

COLORS="$HOME/.dircolors"
if [ -f $COLORS ]; then
    eval `dircolors --sh "$COLORS" 2>/dev/null`
fi

if [[ $OSTYPE == darwin* ]]; then
    PATH_BREW="$(brew --prefix coreutils)/libexec/gnubin"
    PATH_GEM="$(gem env | grep 'EXECUTABLE DIRECTORY' | egrep -o '[^ ]+$')"
    MANPATH="$(brew --prefix)/opt/coreutils/libexec/gnuman:${MANPATH}:/usr/local/git/share/man"
fi

export PATH="$HOME/bin/tunnelbear:$HOME/bin:$PATH_BREW:$PATH_GEM:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/share/npm/bin:$PATH"
export MANPATH

# dottools: add distribution binary directories to PATH
if [ -r "$HOME/.tools-cache/setup-dottools-path.sh" ]; then
  . "$HOME/.tools-cache/setup-dottools-path.sh"
fi

$echo_dot_bashprofile '<<'
