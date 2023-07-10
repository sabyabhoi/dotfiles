#!/usr/bin/bash

Clock(){
	TIME=$(date "+%H:%M:%S")
	echo -e -n " ${TIME}" 
}

Cal() {
    DATE=$(date "+%a, %d %B %Y")
    echo -e -n "${DATE}"
}

ActiveWindow(){
	len=$(echo -n "$(xdotool getwindowfocus getwindowname)" | wc -m)
	max_len=70
	if [ "$len" -gt "$max_len" ];then
		echo -n "$(xdotool getwindowfocus getwindowname | cut -c 1-$max_len)..."
	else
		echo -n "$(xdotool getwindowfocus getwindowname)"
	fi
}

#Wifi(){
#	WIFISTR=$( iwconfig wlp1s0 | grep "Link" | sed 's/ //g' | sed 's/LinkQuality=//g' | sed 's/\/.*//g')
#	if [ ! -z $WIFISTR ] ; then
#		WIFISTR=$(( ${WIFISTR} * 100 / 70))
#		ESSID=$(iwconfig wlp1s0 | grep ESSID | sed 's/ //g' | sed 's/.*://' | cut -d "\"" -f 2)
#		if [ $WIFISTR -ge 1 ] ; then
#			echo -e "${ESSID} ${WIFISTR}%"
#		fi
#	fi
#}

Battery() {
	rem=$(acpi --battery | tail -n 1 | awk -F", " '{print $2}')
	echo "Bat: $rem"
}

#Sound(){
#	NOTMUTED=$( amixer sget Master | grep "\[on\]" )
#	if [[ ! -z $NOTMUTED ]] ; then
#		VOL=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master) | sed 's/%//g')
#		if [ $VOL -ge 85 ] ; then
#			echo -e "\uf028 ${VOL}%"
#		elif [ $VOL -ge 50 ] ; then
#			echo -e "\uf027 ${VOL}%"
#		else
#			echo -e "\uf026 ${VOL}%"
#		fi
#	else
#		echo -e "\uf026 M"
#	fi
#}


while true; do
	echo -e "%{c}%{B#474973}$(ActiveWindow)" "%{r}%{B#474973}$(Battery) $(Clock) $(Cal) "
	sleep 0.1s
done
