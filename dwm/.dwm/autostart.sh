#!/bin/bash

#sh $HOME/Pictures/wallpaper/.fehbg &
xsetroot -solid black &

# Set dark theme (uncomment if/when needed)
#gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# Start settings daemon for GTK theme support
xsettingsd &

# Set slock
xautolock -time 10 -locker slock_off -detectsleep &

# Open st, cd to Music, and set class as music_term (tag 6 for me)
st -d ~/Music -c music_term &

#dwmblocks
slstatus
