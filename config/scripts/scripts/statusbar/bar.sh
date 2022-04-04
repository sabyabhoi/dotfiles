#!/bin/bash

dark=#292e42
red=#f7768e
orange=#ff9e64
yellow=#e0af68
cyan=#7dcfff
blue=#7aa2f7
magenta=#bb9af7

music() {
	icon=""
	paused=$(mpc status | grep --only-matching "paused")
	playing=$(mpc status | grep --only-matching "playing")

	current=$(mpc current)

	if [[ -n $paused ]]; then
		icon=" "
	elif [[ -n $playing ]]; then
		icon=" "
	fi

	printf "$icon${current:0:40}"
}

volume() {
	vol=$(pamixer --get-volume)

	mute=$(pamixer --get-mute)
	if [[ $mute == true ]]; then
		printf "婢" && exit
	elif [[ $vol -gt 70 ]]; then
		icon="墳"
	elif [[ $vol -gt 30 ]]; then
		icon="奔"
	elif [[ $vol -gt 0 ]]; then
		icon="奄"
	else
		printf "婢" && exit
	fi
	printf "^c$magenta^$icon $vol%%"
}

brightness() {
	actual=$(cat /sys/class/backlight/*/actual_brightness)
	max=$(cat /sys/class/backlight/*/max_brightness)

	printf "^c$yellow^  $((actual*100/max))%%"
}

wlan() {
	case "$(cat /sys/class/net/wlp3s0/operstate 2>/dev/null)" in
	up) printf "^c$blue^直" ;;
	down) printf "^c$red^睊" ;;
	esac
}

lan() {
	case "$(cat /sys/class/net/enp2s0/operstate 2>/dev/null)" in
	up) printf "^c$blue^ " ;;
	down) printf "^c$red^ " ;;
	esac
}

clock() {
	printf "^c$blue^  $(date '+%d %b %a %I:%M %p')"
}

battery() {
	value="$(cat /sys/class/power_supply/BAT1/capacity)"
	icon=""

	status="$(cat /sys/class/power_supply/BAT1/status)"
	if [[ $status == "Charging" ]]; then
		icon=""
		printf "^c$cyan^$icon $value%%"
		exit
	fi

	if [[ $value -gt 94 ]]; then
		icon=""
	elif [[ $value -gt 70 ]]; then
		icon=""
	elif [[ $value -gt 55 ]]; then
		icon=""
	elif [[ $value -gt 40 ]]; then
		icon=""
	elif [[ $value -gt 20 ]]; then
		icon=""
	fi

	printf "^c$cyan^ $icon $value%%"
}

sep() {
	printf "^c$dark^|"
}

while true; do

	sleep 1 && xsetroot -name "$(music) $(sep) $(volume) $(sep) $(brightness) $(sep) $(battery) $(sep) $(wlan) $(sep) $(lan) $(sep) $(clock) "
done
