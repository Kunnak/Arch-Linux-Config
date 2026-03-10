#!/bin/bash

# Bildschirmbreite automatisch ermitteln
SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d'x' -f1)

# Kalender-Breite
CAL_WIDTH=280

# Position: Rechts unter dem Datum-Modul
POS_X=$((SCREEN_WIDTH - CAL_WIDTH - 100))
POS_Y=50

yad --calendar \
    --undecorated \
    --fixed \
    --posx=$POS_X \
    --posy=$POS_Y \
    --no-buttons \
    --close-on-unfocus \
    --width=$CAL_WIDTH \
    --height=220 \
    --title='waybar-calendar'
