
#!/bin/bash
killall rofi
icons_dir="$HOME/.config/waybar/icons"
build_menu() {
    echo -en "dwindle\0icon\x1f$icons_dir/dwindle.svg\n"
    echo -en "master\0icon\x1f$icons_dir/master.svg\n"
    echo -en "scrolling\0icon\x1f$icons_dir/scrolling.svg\n"
}
selected=$(build_menu | rofi -dmenu -i -p "Select Workspace Layout" -show-icons \
    -columns 1 \
    -theme ~/.config/rofi/grid-layouts.rasi \
    -theme-str 'element-icon { size: 6em; }' \
    -me-select-entry '' -me-accept-entry MousePrimary)
[ -z "$selected" ] && exit 0

ws=$(hyprctl activeworkspace -j | jq '.id')
window_count=$(hyprctl activeworkspace -j | jq '.windows')
[ "$window_count" -eq 0 ] && exit 

hyprctl dispatch layoutmsg setlayout "$selected"
notify-send -a "System" -i "$icons_dir/$selected.svg" "Hyprland Layout" "Set layout to: $selected"