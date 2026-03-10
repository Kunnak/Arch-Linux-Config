#!/bin/bash
# ~/.config/hypr/scripts/toggle_float_resize.sh

WIDTH=1200
HEIGHT=800

hyprctl dispatch togglefloating active

sleep 0.01

FLOATING=$(hyprctl activewindow -j | jq '.floating')

if [ "$FLOATING" = "true" ]; then
    hyprctl dispatch resizeactive exact $WIDTH $HEIGHT
fi
