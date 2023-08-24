#!/usr/bin/env zsh

# Use cache for slow functions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZDOTDIR/cache

# Ignore completion for non-existant commands
zstyle ':completion:*:functions' ignored-patterns '_*'

# Smart case-y completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Fuzzy completion matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Allow more errors for longer commands
zstyle -e ':completion:*:approximate:*' \
        max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# If using a directory as arg, remove the trailing slash (useful for ln)
zstyle ':completion:*' squeeze-slashes true

# Dircolors on completions
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

zstyle ':completion:*:ls:*' file-patterns '%p:globbed-files' '*(/):directories'

# Complete manual by their section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Rehash if command not found (possibly recently installed)
zstyle ':completion:*' rehash true

# Menu if nb items > 2
zstyle ':completion:*' menu select=2
