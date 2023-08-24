#!/usr/bin/env zsh

if [[ "$OSTYPE" == darwin* ]]; then
  alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder'
fi

if (( $+commands[bat] )); then
  alias cat=bat
fi

if ls --color &> /dev/null; then
    alias ls='ls --color=auto --human-readable --group-directories-first'
else
    export CLICOLOR=true
    alias ls='ls -h'
fi

if (( $+commands[exa] )); then
  alias exa='exa --git --group-directories-first --sort Name'
  alias ls=exa
else
  alias ls='ls -G'
fi
