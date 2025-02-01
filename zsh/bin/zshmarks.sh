# Based on bashmarks from https://github.com/twerth/dotfiles
# Modified for zsh compatibility
#
# Start by sourcing this file in your .zshrc
#
# To bookmark a folder, simply go to that folder, then bookmark it with:
#   bookmark foo
#
# The bookmark will be named "foo"
#
# When you want to get back to that folder use:
#   go-bookmark foo
# (This is set to an alias `g` at the end of this file)
#
# To see a list of bookmarks:
#   bookmarksshow
#
# Your bookmarks are stored in the ~/.bookmarks file

bookmarks_file=~/.bookmarks

# Create bookmarks_file if it doesn't exist
[[ ! -f $bookmarks_file ]] && touch $bookmarks_file

bookmark() {
    local bookmark_name=$1

    if [[ -z $bookmark_name ]]; then
        echo 'Invalid name, please provide a name for your bookmark. For example:'
        echo '  bookmark foo'
    else
        local bookmark="$(pwd)|$bookmark_name"

        if [[ -z $(grep "$bookmark" $bookmarks_file) ]]; then
            echo $bookmark >> $bookmarks_file
            echo "Bookmark '$bookmark_name' saved"
        else
            echo "Bookmark already existed"
        fi
    fi
}

# Show a list of the bookmarks
bookmarksshow() {
    awk '{ printf "%-40s%-40s%s\n",$1,$2,$3}' FS=\| $bookmarks_file
}

go-bookmark() {
    local bookmark_name=$1

    local bookmark=$(grep "|$bookmark_name\$" "$bookmarks_file")

    if [[ -z $bookmark ]]; then
        echo 'Invalid name, please provide a valid bookmark name. For example:'
        echo '  g foo'
        echo
        echo 'To bookmark a folder, go to the folder then do this (naming the bookmark '\''foo'\''):'
        echo '  bookmark foo'
    else
        local dir=$(echo "$bookmark" | cut -d\| -f1)
        cd "$dir"
    fi
}

# Zsh completion function
_go_bookmark() {
  # We declare that there is one argument (bookmark name).
  # When zsh is about to complete that argument,
  # we run our own compadd code to produce the completions:
  _arguments \
    '1:bookmark name:->bm' && return 0

  # If zsh says we’re completing the 'bm' state above,
  # we do the compadd:
  if [[ $state = bm ]]; then
    local -a bookmarks
    bookmarks=("${(@f)$(cut -d'|' -f2 $bookmarks_file)}")
    compadd -X 'Bookmarks:' $bookmarks
    return 0
  fi
}
compdef _go_bookmark go-bookmark g

# Alias
alias g=go-bookmark
