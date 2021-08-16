#!/bin/sh

case $1 in
	-s|--stop)
		killall takeabreak.sh
		break
		;;
esac

stretch() {
	while true; do
		sleep 20m
		notify-send "Stretch for 20 seconds" -t 20000
	done
}

stretch &
