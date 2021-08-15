#!/bin/sh

IMG=$(i3-input -P "Name of file: " | tail -n 1 | awk -F " = " '{print $2}')

import -window root /tmp/$IMG.jpg
notify-send "Screenshot saved to /tmp/$IMG.jpg" -t 2500
