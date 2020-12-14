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
[ -d "$HOME/.rvm/bin" ] && export PATH="$HOME/.rvm/bin:$PATH"

# Remove duplicates in PATH
typeset -U PATH

# Key bindings
autoload zkbd
[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && zkbd
source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
# [[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
# [[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# History partial search with up/down arrow
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# bindkey "^[[A" history-beginning-search-backward-end
# bindkey "^[[B" history-beginning-search-forward-end
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" history-beginning-search-backward-end
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" history-beginning-search-forward-end

# GPG 2.1.x SSH support
# See : http://incenp.org/notes/2015/gnupg-for-ssh-authentication.html
if [[ "$OSTYPE" == darwin* ]]; then
  gpg-connect-agent /bye
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

  ssh-add -A 2>/dev/null

  GPG_TTY=$(tty)
  export GPG_TTY
fi

# Load NVM
if [ -d $HOME/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# Load RVM
if [ -d $HOME/.rvm ]; then
  [ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"
fi
