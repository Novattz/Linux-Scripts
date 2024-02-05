#!/bin/bash

LAST_ACTIVE_WINDOW_FILE="/tmp/last_active_window"

get_current_active_window() {
    xdotool getactivewindow getwindowname
}

# Function to save the current active window if it's Spotify or Chrome
save_current_active_window() {
    current_window=$(get_current_active_window)

    if [[ $current_window == *"Spotify Free"* ]]; then
        echo "Spotify" > "$LAST_ACTIVE_WINDOW_FILE"
    elif [[ $current_window == *"Google Chrome"* ]]; then
        echo "Chrome" > "$LAST_ACTIVE_WINDOW_FILE"
    fi
}

read_last_active_window() {
    if [ -f "$LAST_ACTIVE_WINDOW_FILE" ]; then
        cat "$LAST_ACTIVE_WINDOW_FILE"
    else
        echo "No window"
    fi
}

is_spotify_active() {
    playerctl -l | grep -q spotify
}

is_spotify_playing() {
    playerctl --player=spotify status | grep -q Playing
}

control_playback() {
    if [ -f "$LAST_ACTIVE_WINDOW_FILE" ]; then
        last_window=$(cat "$LAST_ACTIVE_WINDOW_FILE")

        if [[ $last_window == "Spotify" ]]; then
            playerctl --player=spotify "$1"
        elif [[ $last_window == "Chrome" ]]; then
            playerctl --player=chromium "$1"
        fi
    fi
}

case "$1" in
    save)
        save_current_active_window
        ;;
    play-pause)
        control_playback play-pause
        ;;
    next)
        control_playback next
        ;;
    previous)
        control_playback previous
        ;;
    *)
        echo "Usage: $0 {save|play-pause|next|previous}"
        exit 1
        ;;
esac
