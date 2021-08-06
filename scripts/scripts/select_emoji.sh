#!/bin/sh

cat /home/cognusboi/workspace/scripts/emojis | rofi -dmenu | awk '{print $1}' | tr -d '\n' | xclip -selection clipboard
pgrep -x dunst >/dev/null && notify-send "$(xclip -o -selection clipboard) copied to clipboard"
