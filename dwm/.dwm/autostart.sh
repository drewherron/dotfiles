#!/bin/bash
sh $HOME/Pictures/wallpaper/.fehbg &

xautolock -time 10 -locker slock &

# Open st, cd to Music, and set class as music_term (tag 6 for me)
st -d ~/Music -c music_term &

dwmblocks
