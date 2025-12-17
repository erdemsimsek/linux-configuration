#!/bin/bash

# Configuration
volume_step=5
brightness_step=5

# -----------------------------------------------------------------------------
# VOLUME NOTIFICATION (Uses pamixer)
# -----------------------------------------------------------------------------
function show_volume_notif {
    volume=$(pamixer --get-volume)
    is_muted=$(pamixer --get-mute)

    if [ "$is_muted" = "true" ]; then
        # Show Muted Icon and text
        dunstify -a "changeVolume" -u low -r 9993 -h int:value:"$volume" -i "audio-volume-muted" "Volume: Muted" -t 2000
    else
        # Show Volume Level
        dunstify -a "changeVolume" -u low -r 9993 -h int:value:"$volume" -i "audio-volume-high" "Volume: ${volume}%" -t 2000
    fi
}

# -----------------------------------------------------------------------------
# BRIGHTNESS NOTIFICATION (Uses brightnessctl)
# -----------------------------------------------------------------------------
function show_brightness_notif {
    # Get brightness percentage
    brightness=$(brightnessctl | grep -o "(.*" | tr -d "()")
    dunstify -a "changeBrightness" -u low -r 9994 -h int:value:"$brightness" -i "display-brightness-symbolic" "Brightness: ${brightness}%" -t 2000
}

# -----------------------------------------------------------------------------
# CONTROLS
# -----------------------------------------------------------------------------
case $1 in
    volume_up)
        pamixer -i $volume_step
        show_volume_notif
        ;;
    volume_down)
        pamixer -d $volume_step
        show_volume_notif
        ;;
    volume_mute)
        pamixer -t
        show_volume_notif
        ;;
    brightness_up)
        brightnessctl s +$brightness_step%
        show_brightness_notif
        ;;
    brightness_down)
        brightnessctl s $brightness_step%-
        show_brightness_notif
        ;;
esac