#!/bin/bash
direction=$1
current=$(hyprctl activeworkspace -j | grep -oP '"id":\s*\K\d+')

block=$((($current - 1) / 10))
block_start=$((block * 10 + 1))
block_end=$((block * 10 + 10))

if [ "$direction" = "up" ]; then
    if [ "$current" -eq "$block_start" ]; then
        next=$block_end
    else
        next=$((current - 1))
    fi
else
    if [ "$current" -eq "$block_end" ]; then
        next=$block_start
    else
        next=$((current + 1))
    fi
fi

hyprctl dispatch workspace $next
