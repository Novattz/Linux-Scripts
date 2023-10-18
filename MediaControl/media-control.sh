#!/bin/bash

# Function to check if Spotify is active
is_spotify_active() {
    playerctl -l | grep -q spotify
}

# Function to check if Spotify is playing
is_spotify_playing() {
    playerctl --player=spotify status | grep -q Playing
}

# Function to check if Spotify window is active
is_spotify_window_active() {
    wmctrl -lx | grep -i spotify.Spotify | grep -q "$(printf '%x\n' "$(xdotool getactivewindow)")"
}

# Function to check if Chrome is the active window
is_chrome_active() {
    xdotool getactivewindow getwindowname | grep -q -e "Google Chrome" -e "Chromium"
}

# Control playback based on the argument
case "$1" in
    play-pause)
        if { ! is_chrome_active && (is_spotify_active || is_spotify_playing || is_spotify_window_active); } then
            playerctl --player=spotify play-pause
        else
            playerctl play-pause
        fi
        ;;
    next)
        if { ! is_chrome_active && (is_spotify_active || is_spotify_playing || is_spotify_window_active); } then
            playerctl --player=spotify next
        else
            playerctl next
        fi
        ;;
    previous)
        if { ! is_chrome_active && (is_spotify_active || is_spotify_playing || is_spotify_window_active); } then
            playerctl --player=spotify previous
        else
            playerctl previous
        fi
        ;;
    *)
        echo "Usage: $0 {play-pause|next|previous}"
        exit 1
        ;;
esac
