# Spotify-control
Control Spotify and Chrome seamlessly using media keys. This script checks your last active window and lets you manage your media playback in Linux with ease. The script comes in 2 parts which is media-control.sh itself and save_windows.sh. save_windows.sh should run constantly as it updates the tmp file made in /tmp.

Place script anywhere you want and do ```chmod +x path/to/script.sh```

Example sxhkd config:
```
XF86Audio{Prev,Next,Play}
    ~/path/to/script/media-control.sh save; ~/path/to/script/media-control.sh {previous,next,play-pause}
```
Required packages:
```playerctl wmctrl xdotool```
