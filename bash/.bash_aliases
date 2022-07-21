alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias ll='ls -ahlF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

alias v="vim"
alias z="zathura"
alias py="python3"
alias tree="tree -C"
alias mv="mv -v"
alias cp="cp -vi"
alias gh="history|grep"
#alias rm="rm -v"
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"
#alias trash="mv --force -t ~/.local/share/Trash/files"
alias del="trash-put" # works better
alias grep="grep --color"
alias bashreload="source ~/.bashrc && echo Bash config reloaded"
alias sus="systemctl suspend"

alias zyp="zypper"
alias lf="lfrun"
alias sxiv="sxivrun"
