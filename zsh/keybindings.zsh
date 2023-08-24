#!/usr/bin/env zsh

# Some defaults for things not in zkbd
typeset -A key
key[Ctrl+Up]='\e[1;5A'
key[Ctrl+Down]='\e[1;5B'
key[Shift+Tab]='\e[Z'

autoload -U edit-command-line
zle -N edit-command-line

bindkey "^E" edit-command-line
bindkey "^O" accept-line-and-down-history
bindkey "^R" history-incremental-search-backward

bindkey "^[l" quote-line
bindkey "^[t" transpose-words
bindkey "^[." insert-last-word

function swap-quote-kind() {
  local c

  for (( c = $#LBUFFER; c > 0; c-- )); do
    if [[ $LBUFFER[c] == \' ]]; then
      LBUFFER[c]=\"
      break
    elif [[ $LBUFFER[c] == \" ]]; then
      LBUFFER[c]=\'
      break
    fi
  done
}

zle -N swap-quote-kind
bindkey '^Q' swap-quote-kind

# History partial search with up/down arrow
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search up-line-or-beginning-search
zle -N down-line-or-beginning-search down-line-or-beginning-search

keymap="${ZDOTDIR:-$HOME}/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}"
if [[ ! -f "$keymap" ]]; then
  keymap="${ZDOTDIR:-$HOME}/.zkbd/default-keymap"
fi
source "$keymap"

[[ -n ${key[Up]}        ]] && bindkey "${key[Up]}"          up-line-or-beginning-search
[[ -n ${key[Down]}      ]] && bindkey "${key[Down]}"        down-line-or-beginning-search
[[ -n ${key[Left]}      ]] && bindkey "${key[Left]}"        backward-char
[[ -n ${key[Right]}     ]] && bindkey "${key[Right]}"       forward-char
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}"   backward-delete-char
[[ -n ${key[Home]}      ]] && bindkey "${key[Home]}"        beginning-of-line
[[ -n ${key[End]}       ]] && bindkey "${key[End]}"         end-of-line
[[ -n ${key[PageUp]}    ]] && bindkey "${key[PageUp]}"      beginning-of-history
[[ -n ${key[PageDown]}  ]] && bindkey "${key[PageDown]}"    end-of-history
[[ -n ${key[Insert]}    ]] && bindkey "${key[Insert]}"      overwrite-mode
[[ -n ${key[Delete]}    ]] && bindkey "${key[Delete]}"      delete-char

[[ -n ${key[Shift+Tab]} ]] && bindkey "${key[Shift+Tab]}"   reverse-menu-complete
