#!/usr/bin/env zsh
# Setting and editing of env variables.
export EDITOR='nano'
export SUDO_EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Add things to PATH
[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
[ -d "$DOTFILES/bin" ] && export PATH="$DOTFILES/bin:$PATH"
[ -d "$HOME/.npm-global" ] && export PATH="$HOME/.npm-global/bin:$PATH"

# Remove duplicates in PATH
typeset -U PATH

# GPG 2.1.x SSH support
# See : http://incenp.org/notes/2015/gnupg-for-ssh-authentication.html
if [[ "$OSTYPE" == darwin* ]]; then
  gpg-connect-agent /bye
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

  ssh-add -A 2>/dev/null

  GPG_TTY=$(tty)
  export GPG_TTY
fi
