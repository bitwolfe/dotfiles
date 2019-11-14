#!/usr/bin/env zsh

alias ls='ls -G'
alias ll='ls -l'

if [[ "$OSTYPE" == darwin* ]]; then
  alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
fi