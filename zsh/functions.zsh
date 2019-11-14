#!/usr/bin/env zsh
# Update Zsh plugins
uz(){
  antibody bundle <~/.dotfiles/zsh/plugins.txt >~/.zsh_plugins.sh
  antibody update
  compaudit | xargs -I ARG chmod go-w ARG
}

terminate() {
  if [ -z "$1" ]; then
    echo "Usage: terminate [numeric port identifier]" >&2
    return 1
  fi
  lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
}

# Set terminal window title
function precmd {
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}