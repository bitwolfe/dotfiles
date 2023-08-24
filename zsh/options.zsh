#!/usr/bin/env zsh

unsetopt BG_NICE

setopt EXTENDED_GLOB     # Use extended globbing syntax
setopt GLOB_STAR_SHORT   # **.c == **/*.c

setopt AUTO_CD           # Auto change to a dir without typing cd
setopt CORRECT           # Try to auto-correct
setopt COMPLETE_IN_WORD
setopt PROMPT_SUBST

# Sane Quoting: '' escapes a single quote inside single quotes
setopt RC_QUOTES

# Changing Directories

DIRSTACKSIZE=8
setopt AUTO_PUSHD

# History

HISTFILE=~/.zsh_history # Where to save history to disk
HISTSIZE=1000000 # Lines of history to keep in memory for current session
SAVEHIST=$HISTSIZE # Number of history entries to save to disk

setopt EXTENDED_HISTORY         # Adds timestamps
setopt HIST_FIND_NO_DUPS        # Don't show things I scroll past
setopt HIST_IGNORE_DUPS         # Ignore duplicates
setopt HIST_IGNORE_SPACE        # Ignore lines beginning with space
setopt HIST_EXPIRE_DUPS_FIRST   # Delete dupes from history first
setopt HIST_REDUCE_BLANKS       # Reduce superfluos blanks
setopt HIST_VERIFY              # Confirm before running
setopt SHARE_HISTORY            # Share history across terminals

# Editing

WORDCHARS=${WORDCHARS/=/}

zshaddhistory () { (( $#1 < 500 )) }
