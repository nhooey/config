# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

echo_dot_bashrc=''
if [ -f "$HOME/.echo_login" ]; then
	echo_dot_bashrc="echo '~/.bashrc'"
fi

$echo_dot_bashrc '>>'

$echo_dot_bashrc '<<'
