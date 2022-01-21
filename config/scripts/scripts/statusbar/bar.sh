#!/bin/bash

dark=#292e42
orange=#ff9e64
yellow=#e0af68
cyan=#7dcfff
blue=#7aa2f7

volume() {
	vol=$(pamixer --get-volume)

	if [[ $vol -gt 70 ]]; then
		icon="墳"
	elif [[ $vol -gt 30 ]]; then
		icon="奔"
	elif [[ $vol -gt 0 ]]; then
		icon="奄"
	else
		printf "婢" && exit
	fi
	printf "$icon $vol%%"
}

brightness() {
	actual=$(cat /sys/class/backlight/*/actual_brightness)
	max=$(cat /sys/class/backlight/*/max_brightness)

	printf "^c$yellow^  $((actual*100/max))%%"
}

wlan() {
	case "$(cat /sys/class/net/wlp3s0/operstate 2>/dev/null)" in
	up) printf "^c$blue^直 Connected" ;;
	down) printf "^c$blue^睊 Disonnected" ;;
	esac
}

lan() {
	case "$(cat /sys/class/net/enp2s0/operstate 2>/dev/null)" in
	up) printf "^c$blue^ Connected" ;;
	down) printf "^c$blue^ Disonnected" ;;
	esac
}

clock() {
	printf "^c$blue^  $(date '+%d %b %a %I:%M %p')"
}

battery() {
	printf "^c$cyan^ $(cat /sys/class/power_supply/BAT1/capacity)%%"
}

sep() {
	printf "^c$dark^|"
}

while true; do

	sleep 1 && xsetroot -name "$(volume) $(sep) $(brightness) $(sep) $(battery) $(sep) $(wlan) $(lan) $(sep) $(clock) "
done
