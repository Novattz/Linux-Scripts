#!/bin/bash

# File to store the previous volume level
temp_file="/tmp/prev_volume"

# Get the previous volume level
if [[ -f "$temp_file" ]]; then
    prev_volume=$(cat "$temp_file")
else
    prev_volume=0
fi

# Get the current volume
volume=$(amixer get Master | grep -o "[0-9]*%" | head -1 | tr -d '%')

# Determine the icon based on the change in volume level or if volume is 0
if (( volume == 0 )); then
    icon="~/.icons/dunst/volumemute.svg"
elif (( volume > prev_volume )); then
    icon="~/.icons/dunst/volumeup.svg"
elif (( volume < prev_volume )); then
    icon="~/.icons/dunst/volumedown.svg"
else
    # If the volume level hasn't changed, exit the script
    exit 0
fi

# Update the temporary file with the current volume level
echo "$volume" > "$temp_file"

# Send the notification
dunstify -i "$icon" -r 2593 "Volume: $volume%"
