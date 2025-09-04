#!/bin/bash

# Get current layout
current=$(setxkbmap -query | grep variant | awk '{print $2}')

if [ "$current" = "colemak_dh_ortho" ]; then
    # Switch to QWERTY
    setxkbmap us
    echo "Switched to QWERTY"
else
    # Switch to Colemak-DH Ortho
    setxkbmap us -variant colemak_dh_ortho
    echo "Switched to Colemak-DH Ortho"
fi