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

# Remove duplicates in PATH
typeset -U PATH
