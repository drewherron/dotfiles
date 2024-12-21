# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Path configuration
# Instead of overwriting PATH, append to it
export PATH="$PATH:/usr/local/apps/bin:$HOME/.local/bin:$HOME/bin:/usr/games"
export MANPATH="/usr/local/man:/usr/man:/usr/share/man"

# Load secrets/environment variables
if [ -f "$HOME/.bash_secrets" ]; then
    set -a  # automatically export all variables
    source "$HOME/.bash_secrets"
    set +a
else
    echo "Warning: ~/.bash_secrets not found"
fi

# Load additional configurations
for config in "$HOME"/.{bash_prompt,bash_aliases,bash_history_config}; do
    if [ -f "$config" ]; then
        source "$config"
    else
        echo "Warning: ${config#$HOME/} not found"
    fi
done

# Load bashmarks if available
if [ -f "$HOME/bin/bashmarks.sh" ]; then
    source "$HOME/bin/bashmarks.sh"
else
    echo "Warning: ~/bin/bashmarks.sh not found"
fi

# Update lines and columns when window size changes
shopt -s checkwinsize

# Editor configuration
export EDITOR="emacsclient"
export VISUAL="$EDITOR"
export PAGER=less
export MORE="-c"
set -o emacs

# Load additional configurations
for config in "$HOME"/.{bash_prompt,bash_aliases}; do
    [ -f "$config" ] && source "$config"
done

# Enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Load bash completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Utility functions
extract() {
    if [ -f "$1" ] ; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"   ;;
            *.tar.gz)    tar xzf "$1"   ;;
            *.bz2)       bunzip2 "$1"   ;;
            *.rar)       unrar x "$1"   ;;
            *.gz)        gunzip "$1"    ;;
            *.tar)       tar xf "$1"    ;;
            *.tbz2)      tar xjf "$1"   ;;
            *.tgz)       tar xzf "$1"   ;;
            *.zip)       unzip "$1"     ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"      ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Auto-ls on cd
cd() {
    builtin cd "$@" && ls -F --group-directories-first
}

# Enable keypad (fixes Del key in st)
tput smkx 2>/dev/null

# Python environment setup
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv virtualenv-init -)"
fi

# Rust setup
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Load bashmarks if available
[ -f "$HOME/bin/bashmarks.sh" ] && source "$HOME/bin/bashmarks.sh"
