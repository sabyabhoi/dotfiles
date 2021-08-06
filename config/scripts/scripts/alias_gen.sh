#!/usr/bin/bash

for FILE in /home/cognusboi/workspace/college/*; do 
	NAME=$FILE --split "//"
	echo $NAME
	if [[ -d "$FILE" ]]; then
		echo "$FILE is a directory"
	fi
done
