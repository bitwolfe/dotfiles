#!/usr/bin/env zsh

unsetopt BG_NICE

# History
HISTFILE=~/.zsh_history # Where to save history to disk
HISTSIZE=10000 # Lines of history to keep in memory for current session
SAVEHIST=10000 # Number of history entries to save to disk

# Options - `man zshoptions`
setopt extended_history # Adds timestamps
setopt append_history # Append history to the history file (no overwriting)
setopt inc_append_history # Immediately append to the history file, not just when a term is killed
setopt share_history # Share history across terminals
setopt hist_reduce_blanks # Reduce superfluos blanks
setopt hist_ignore_dups # Ignore duplicates
setopt hist_ignore_space # Ignore lines beginning with space
setopt extended_glob # Use extended globbing syntax
setopt auto_cd # Auto change to a dir without typing cd
setopt correct # Try to auto-correct
setopt complete_in_word
setopt prompt_subst
