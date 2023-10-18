# Volume Notification Script for Dunst
script to display volume level notifications on your desktop using the Dunst notification daemon. The script identifies whether the volume has been increased, decreased, or muted, and displays a notification with a corresponding icon.

Place script anywhere you want and do ```chmod +x path/to/script.sh```

Example sxhkd config:
```
XF86Audio{RaiseVolume,LowerVolume}
	amixer set Master {5%+,5%-}; path/to/script.sh

XF86AudioMute
	amixer set Master {mute,unmute}; path/to/script.sh```

Required packages: ```Dunst alsa-utils```
