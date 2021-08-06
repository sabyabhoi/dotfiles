#!/bin/sh

if [[ -z $1 ]]; then
	echo "Usage: $0 <markdown file> <template file> [--css] [--html]"
fi

for arg in "$@"; do
	case $arg in
		-h|--help)
			echo "Usage: $0 <markdown file> <template file> [--css] [--html]"
			;;
		--css)
			echo "Fetching css file from github..."
			curl "https://raw.githubusercontent.com/sabyabhoi/abw/main/style.css" -o style.css
			;;
		--html)
			echo "Fetching html file from github..."
			curl "https://raw.githubusercontent.com/sabyabhoi/abw/main/template.html" -o template.html
			;;
	esac
done

if [[ -z $1 ]]; then
	echo "Usage: $0 <markdown file> <template file> [--css]"
	exit
fi

TITLE=$(sed 's/# //; 1q' $1)

TEMP="${2:-template.html}"

if [[ ! -e $TEMP ]]; then
	echo "$TEMP does not exist. Getting it from github..."
	curl "https://raw.githubusercontent.com/sabyabhoi/abw/main/template.html" -o template.html
fi

sed -e 's|{0}|'"$TITLE"'|g' $TEMP | head -n -2

tail -n +2 $1 | markdown

echo "</body></html>"
