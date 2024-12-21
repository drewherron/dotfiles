# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# List directory contents
alias ll='ls -ahlF --group-directories-first'
alias la='ls -A --group-directories-first'
alias l='ls -CF --group-directories-first'
alias tree='tree -C'

# Colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'

# Safety features
alias cp='cp -vi'
alias mv='mv -vi'
# More comprehensive safety approach for rm
alias rm='_safe_rm'
_safe_rm() {
    echo "Use 'del' for safer removal or '/bin/rm' if you're sure."
    return 1
}
alias del='trash-put'

# File operations
alias cat='batcat'
alias gh='history | grep'

# Development
alias py='python3'
alias sa='source venv/bin/activate'

# Editors
alias e='emacsclient --tty'
alias v='vim'

# System
alias cls='clear'
alias bashreload='source ~/.bashrc && echo Bash config reloaded'
alias U='sudo apt -y update && sudo apt -y upgrade && sudo apt -y autoremove && sudo apt -y autoclean'

# Bashmarks
alias g=go-bookmark
complete -F _go-bookmark_complete -o default g

# Other
alias lf='lfrun'
alias sxiv='sxivrun'
alias z='zathura'
alias zyp='zypper'
