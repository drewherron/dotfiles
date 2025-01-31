# Use modern completion system
autoload -Uz compinit
compinit

# Source config files
for config in "$HOME"/.{zsh_prompt,zsh_aliases}; do
    if [ -f "$config" ]; then
        source "$config"
    else
        echo "Warning: ${config#$HOME/} not found"
    fi
done

# Load bashmarks if available
if [ -f "$HOME/bin/zshmarks.sh" ]; then
    source "$HOME/bin/zshmarks.sh"
else
    echo "Warning: ~/bin/zshmarks.sh not found"
fi

# Emacs keybindings
bindkey -e

# History
HISTFILE=~/.zsh_history

HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS       # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate commands from history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file

setopt INC_APPEND_HISTORY   # Writes history incrementally (instead of on exit)
setopt SHARE_HISTORY        # Shares history across all sessions in real time

setopt HIST_IGNORE_SPACE    # Don't save commands that start with a space
setopt HIST_REDUCE_BLANKS   # Remove superfluous whitespace

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

