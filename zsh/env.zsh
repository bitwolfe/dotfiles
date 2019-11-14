#!/usr/bin/env zsh
# Setting and editing of env variables.
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

export EDITOR='nano'
export SUDO_EDITOR='nano'
export VISUAL='nano'
export PAGER='less'

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

# Add things to PATH
[ -d "$HOME/.bin" ] && export PATH="$HOME/.bin:$PATH"
[ -d "$DOTFILES/bin" ] && export PATH="$DOTFILES/bin:$PATH"
[ -d "$HOME/.npm-global" ] && export PATH="$HOME/.npm-global/bin:$PATH"
[ -d "$HOME/.rvm/bin" ] && export PATH="$HOME/.rvm/bin:$PATH"

# Remove duplicates in PATH
typeset -U PATH

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

if [ -d $HOME/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

if [ -d $HOME/.rvm ]; then
  [ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"
fi