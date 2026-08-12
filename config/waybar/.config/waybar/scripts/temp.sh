#!/bin/bash

# Temperature thresholds
TEMP_LOW=40
TEMP_MED=70
TEMP_HIGH=85

# Icons (placeholders)
ICON_CPU=""
ICON_GPU="󰢮"
ICON_NVME="󰋊"
ICON_TEMP_LOW=""
ICON_TEMP_MED=""
ICON_TEMP_HIGH=""
ICON_TEMP_CRITICAL=""

# Function to get temp icon based on temperature
get_temp_icon() {
    local temp=$1
    if [ "$temp" -ge "$TEMP_HIGH" ]; then
        echo "$ICON_TEMP_CRITICAL"
    elif [ "$temp" -ge "$TEMP_MED" ]; then
        echo "$ICON_TEMP_HIGH"
    elif [ "$temp" -ge "$TEMP_LOW" ]; then
        echo "$ICON_TEMP_MED"
    else
        echo "$ICON_TEMP_LOW"
    fi
}

# Get CPU temperature
cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
if [ -n "$cpu_temp" ]; then
    cpu_temp=$((cpu_temp / 1000))
else
    cpu_temp=0
fi

max_temp=$cpu_temp
tooltip=""

# Add CPU temp to tooltip
cpu_temp_icon=$(get_temp_icon "$cpu_temp")
tooltip+="${ICON_CPU} ${cpu_temp_icon} ${cpu_temp}°C\n"

# Get GPU temperature if NVIDIA GPU exists
if command -v nvidia-smi &> /dev/null; then
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

    if [ -n "$gpu_temp" ]; then
        gpu_temp=$(echo "$gpu_temp" | xargs)

        # Update max temp if GPU is hotter
        if [ "$gpu_temp" -gt "$max_temp" ]; then
            max_temp=$gpu_temp
        fi

        # Add GPU temp to tooltip
        gpu_temp_icon=$(get_temp_icon "$gpu_temp")
        tooltip+="${ICON_GPU} ${gpu_temp_icon} ${gpu_temp}°C\n"
    fi
fi

# Get NVMe/SSD temperature
nvme_temp=$(cat /sys/class/hwmon/hwmon*/temp1_input 2>/dev/null | head -1)
if [ -n "$nvme_temp" ]; then
    nvme_temp=$((nvme_temp / 1000))

    # Add NVMe temp to tooltip
    nvme_temp_icon=$(get_temp_icon "$nvme_temp")
    tooltip+="${ICON_NVME} ${nvme_temp_icon} ${nvme_temp}°C"
fi

echo "{\"text\":\"$(get_temp_icon "$max_temp") ${max_temp}°C\",\"tooltip\":\"$tooltip\"}"
