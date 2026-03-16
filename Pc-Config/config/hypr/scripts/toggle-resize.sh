#!/bin/bash
WIDTH=1600
HEIGHT=800

hyprctl dispatch togglefloating active
sleep 0.001

FLOATING=$(hyprctl activewindow -j | jq '.floating')

if [ "$FLOATING" = "true" ]; then
    hyprctl dispatch resizeactive exact $WIDTH $HEIGHT
    sleep 0.001
    hyprctl dispatch centerwindow
fi
