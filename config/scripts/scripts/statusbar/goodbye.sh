#!/bin/bash

cmd=$(printf "Poweroff\nReboot\nCancel\n" | rofi -dmenu)

case "$cmd" in 
	Poweroff)
		systemctl poweroff
		;;
	Reboot)
		systemctl reboot
		;;
	Cancel)
		;;
	*)
		;;
esac
