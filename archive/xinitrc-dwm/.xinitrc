#!/bin/bash
# Probably don't need any of this
# with the dwm autostart patch...

# invoke global X session script
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#feh --bg-fill $HOME/pictures/wallpaper
#setxkbmap -option caps:escape

#Day() {
#  printf `date "+%e" | sed -e 's/\ //'`
#
#  case `date +%d` in
#    1|21|31) printf "${day}st";;
#    2|22)    printf "${day}nd";;
#    3|23)    printf "${day}rd";;
#    *)       printf "${day}th";;
#  esac
#}
#
#Battery() {
#  dir=/sys/class/power_supply/BAT0
#
#  grep -q ^C "${dir}"/status && printf +
#  cat "${dir}"/capacity
#}
#
#while true; do
#  xsetroot -name "`date \"+%a, %b \`Day\` %k:%M\"`" # | Battery: `Battery`%"
#  sleep 15
#done &

## set status bar output
#while true; do
#    xsetroot -name "$(iwconfig wlan0 | sed 's/ /\n/g' | grep ESSID) | $(iwconfig wlan0 | sed 's/ /\n/g' | grep Quality) | $(uptime | sed 's/.*://; s/,//g') | $(date "+%F %R") |"
#    sleep 1m
#done &

#exec /usr/local/bin/dwm
exec dwm
