#!/bin/bash

# Get the current keycode assigned to Caps Lock
capslock=$(xmodmap -pke | grep -E 'keycode\s+66\s+=\s+' | awk '{print $NF}')

if [[ $capslock == "Caps_Lock" ]]; then
  # Change Caps Lock to Hyper_L (mod3)
  xmodmap -e "keycode 66 = Hyper_L"
  echo "Caps Lock changed to Hyper_L"
else
  # Change Hyper_L (mod3) back to Caps Lock
  xmodmap -e "keycode 66 = Caps_Lock"
  echo "Hyper_L changed back to Caps Lock"
fi

