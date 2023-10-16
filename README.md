# Spotify-control
This script allows for media key control over Spotify playback on Linux. The script prioritizes Spotify unless Chrome is the active window. In addition to checking playback status, it checks for an active Spotify window and the active window being Chrome.

Place script anywhere you want and do ```chmod +x path/to/script.sh```

Example sxhkd config:
```
XF86AudioPlay
    path/to/script.sh play-pause

XF86AudioNext
    path/to/script.sh next

XF86AudioPrev
    path/to/script.sh previous
```
Required packages:
```playerctl wmctrl xdotool```
