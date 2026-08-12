#!/usr/bin/env bash

menu=(
    " Keybinds"
    " Calculator"
    "󰹑 Screenshot"
    "󰅇 Clipboard"
    " Layouts"
    "󰞅 Emojis"
    " Icons"
    " Picker"
    " VPN"
    " Packages"
    " Bluetooth"
    "󰁹 Power"
)

# Show rofi menu
selected=$(printf '%s\n' "${menu[@]}" | rofi -dmenu -i -p "Quick Actions" -theme ~/.config/rofi/quick-actions.rasi)

# Handle selection
if [ -n "$selected" ]; then
    case "$selected" in
        "󰹑 Screenshot")
            ~/.config/waybar/scripts/take-screenshot.sh
            ;;
        "󰅇 Clipboard")
            clipse-gui
            ;;
        "󰞅 Emojis")
            rofi -show emoji -theme ~/.config/rofi/config.rasi
            ;;
        " Icons")
            ~/.config/waybar/scripts/icon-picker.sh
            ;;
        " Picker")
            ~/.config/waybar/scripts/color-picker.sh
            ;;
        " VPN")
            ~/.config/waybar/scripts/tailscale.sh
            ;;
        " Packages")
            ~/.config/waybar/scripts/installer-wrapper.sh
            ;;
        " Bluetooth")
            ~/.config/waybar/scripts/rofi-bluetooth.sh
            ;;
        "󰁹 Power")
            ~/.config/waybar/scripts/power-profile.sh
            ;;
        " Keybinds")
            ~/.config/hypr/scripts/cheatsheet.sh
            ;;
        " Calculator")
            rofi -show calc -modi calc -no-show-match -no-sort
            ;;
        " Layouts")
            ~/.config/waybar/scripts/layout-switcher.sh
            ;;
    esac
fi
