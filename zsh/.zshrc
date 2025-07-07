# Add extra directories to PATH
export PATH="$PATH:/usr/local/apps/bin:$HOME/bin:$HOME/.local/bin:/usr/games"

# Set MANPATH
export MANPATH="/usr/local/man:/usr/man:/usr/share/man"

# Set ZDOTDIR to use XDG-compliant directory
export ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# Use modern completion system
autoload -Uz compinit
compinit

# Colors
# If `dircolors` is available, initialize $LS_COLORS from it.
if command -v dircolors &> /dev/null; then
    eval "$(dircolors -b)"
fi

# If you are on macOS/BSD and want color, you might set:
# export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad

# Wrap `ls` in a function to always use color (GNU ls).
ls() {
    command ls --color=auto "$@"
}

# Source secrets file
if [ -f "$HOME/SECRETS" ]; then
    source "$HOME/SECRETS"
fi

# Source config files
for config in "$ZDOTDIR"/.{zsh_prompt,zsh_aliases}; do
    if [ -f "$config" ]; then
        source "$config"
    else
        echo "Warning: ${config#$ZDOTDIR/} not found"
    fi
done

# Load bashmarks (if available)
if [ -f "$HOME/bin/zshmarks.sh" ]; then
    source "$HOME/bin/zshmarks.sh"
else
    echo "Warning: ~/bin/zshmarks.sh not found"
fi

# Try emacsclient, fall back to regular emacs if server isn't running
export EDITOR="emacsclient --tty --alternate-editor=emacs"
export VISUAL="emacsclient --tty --alternate-editor=emacs"

# Emacs keybindings
bindkey -e

# Emacs bulk file renaming
#brnm() {
#    emacsclient --tty --eval "(dired-rename-from-shell \"${1:-.}\")"
#}
brnm() {
    local dir="${1:-.}"
    # Check if we can write to the directory
    if [[ -w "$dir" ]]; then
        emacsclient --tty --eval "(dired-rename-from-shell \"$dir\")"
    else
        echo "Directory not writable, using sudo..."
        emacsclient --tty --eval "(dired-rename-from-shell \"/sudo::$(realpath $dir)\")"
    fi
}

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_DUPS       # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate commands from history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries to the history file

setopt INC_APPEND_HISTORY     # Write history incrementally (instead of only on exit)
setopt SHARE_HISTORY          # Share history across all sessions in real time

setopt HIST_IGNORE_SPACE      # Don't save commands that start with a space
setopt HIST_REDUCE_BLANKS     # Remove superfluous whitespace

# Globbing options
setopt EXTENDED_GLOB          # Enable extended globbing (*, ?, [], etc.)
setopt GLOB_DOTS              # Include dotfiles in glob matches
setopt NUMERIC_GLOB_SORT      # Sort globs numerically when possible
setopt MARK_DIRS              # Add trailing slash to directory names from globs
# setopt NULL_GLOB            # If no matches, remove the pattern (instead of error)
# setopt NOMATCH              # Print error if glob has no matches (default)
# setopt CSH_NULL_GLOB        # If no matches, remove pattern silently
setopt CASE_GLOB              # Case-sensitive globbing (default, shown for clarity)
# setopt NO_CASE_GLOB         # Case-insensitive globbing

# Completion styles
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
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

# Function to drop out into directory from lf
lfcd () {
    local lastdir="${XDG_CACHE_HOME:-$HOME/.cache}/lf/lastdir"
    mkdir -p "$(dirname "$lastdir")"
    /usr/bin/lf -last-dir-path="$lastdir" "$@"
    if [ -f "$lastdir" ]; then
        cd "$(cat "$lastdir")"
        rm -f "$lastdir"
    fi
}
