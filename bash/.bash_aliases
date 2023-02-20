alias bashreload="source ~/.bashrc && echo Bash config reloaded"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ll="ls -ahlF --group-directories-first"
alias la="ls -A --group-directories-first"
alias l="ls -CF --group-directories-first"

alias cat="batcat"
alias cls="clear"
alias cp="cp -vi"
alias mv="mv -vi"
alias tree="tree -C"
alias gh="history|grep"
#alias grep="grep --color"
alias sus="slock_off && systemctl suspend"

alias py="python3"
alias e="emacsclient -nw -s /tmp/emacs1000/server"
alias v="vim"
alias z="zathura"
alias zyp="zypper"

# Trash/rm
#alias rm="rm -v"
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"
#alias trash="mv --force -t ~/.local/share/Trash/files"
alias del="trash-put" # works better

# Wrapper scripts
alias lf="lfrun"
alias sxiv="sxivrun"
