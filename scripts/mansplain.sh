#!/bin/sh

man -k . | rofi -dmenu -p "Select a command" | awk '{print $1}' | xargs -r man -Tpdf | zathura - 
