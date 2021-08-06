#!/bin/sh 

steghide extract -sf /home/cognusboi/scripts/tree.jpg -p naughty -xf /tmp/names -f -q

case $1 in
	-w|--write)
		if [[ -z $2 ]]; then
			echo "Please enter the name to add."
			exit
		fi
		echo "Adding $2 to list of names"
		echo $2 >> /tmp/names
		steghide embed -cf /home/cognusboi/workspace/scripts/tree.jpg -p naughty -ef /tmp/names -f -q
		exit
		;;
	-a|--all)
		cat /tmp/names
		exit
		;;
	-d|--delete)
		if [[ -z $2 ]]; then
			echo "Please enter the name to delete."
			exit
		fi
		echo "Deleting $2 from the list"
		sed -i '/$2/ d' /tmp/names
		steghide embed -cf /home/cognusboi/workspace/scripts/tree.jpg -p naughty -ef /tmp/names -f -q
		exit
		;;
	-h|--help)
		echo "Usage: $0 [-w|--write NAME] [-d|--delete NAME] [-a|--all] [-h|--help]"
		exit
		;;
esac

lines=$(cat /tmp/names | wc -l)

awk -v r=$(($RANDOM % $lines)) 'NR==r' /tmp/names | tr -d '\n' | xclip -selection clipboard

notify-send "$(xclip -o -selection clipboard) copied to clipboard" -t 2500

rm /tmp/names
