#!/bin/sh

init="$(cat /sys/class/net/wlp3s0/statistics/rx_bytes)"

printf "Recording bandwidth. Press enter to stop."

read -r lol

fin="$(cat /sys/class/net/wlp3s0/statistics/rx_bytes)"

printf "%4sB of bandwidth used.\\n" $(numfmt --to=iec $(($fin - $init)))
