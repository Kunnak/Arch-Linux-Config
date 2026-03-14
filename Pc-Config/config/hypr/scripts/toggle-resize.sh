#!/bin/bash
# ~/.config/hypr/scripts/toggle-resize.sh

WIDTH=1600
HEIGHT=800

hyprctl dispatch togglefloating active

sleep 0.05

FLOATING=$(hyprctl activewindow -j | jq '.floating')

if [ "$FLOATING" = "true" ]; then
    hyprctl dispatch resizeactive exact $WIDTH $HEIGHT
fi
