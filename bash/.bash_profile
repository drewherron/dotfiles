# .bash_profile is executed for login shells

# Load bashrc for login shells too
if [ -f "$HOME/.config/bash/.bashrc" ]; then
    source "$HOME/.config/bash/.bashrc"
fi

# SSH Agent configuration
if [ -z "$SSH_AUTH_SOCK" ]; then
    # Start SSH agent if not running
    eval "$(ssh-agent -s)" > "$HOME/.ssh-agent-env"

    # Add default key if it exists
    [ -f "$HOME/.ssh/id_rsa" ] && ssh-add "$HOME/.ssh/id_rsa" >/dev/null 2>&1
fi
