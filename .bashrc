# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

echo_dot_bashrc=':'
if [ -f "$HOME/.echo_login" ]; then
    echo_dot_bashrc="echo '~/.bashrc'"
fi

$echo_dot_bashrc '>>'

ssh_latest_agent_file="${HOME}/bin/ssh-save-agent"
if [ -f ${ssh_latest_agent_file} ]; then
    . ${ssh_latest_agent_file}
fi

### Added by the Heroku Toolbelt
export PATH="$PATH:/usr/local/heroku/bin"

# Go Path
export GOPATH='/usr/local/opt/go/libexec/bin'
export GNUBIN_GREP_PATH='/usr/local/Cellar/grep/3.3/libexec/gnubin'
export GNUBIN_SED_PATH='/usr/local/opt/gnu-sed/libexec/gnubin:$PATH'
export PATH="$GNUBIN_GREP_PATH:$GNUBIN_SED_PATH:$PATH:$GOPATH/bin"

$echo_dot_bashrc '<<'
