#!/bin/bash

WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')
WINDOWS=$(hyprctl clients -j | jq --argjson ws "$WORKSPACE" '[.[] | select(.workspace.id == $ws)]')
COUNT=$(echo "$WINDOWS" | jq 'length')
FLOATING=$(echo "$WINDOWS" | jq '[.[] | select(.floating == true)] | length')

# Monitorgröße holen
MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')
MON_W=$(hyprctl monitors -j | jq --arg m "$MONITOR" '.[] | select(.name == $m) | .width')
MON_H=$(hyprctl monitors -j | jq --arg m "$MONITOR" '.[] | select(.name == $m) | .height')

WIN_W=1200
WIN_H=600
GAP=20

arrange_windows() {
    ADDRESSES=$(hyprctl clients -j | jq --argjson ws "$WORKSPACE" \
        '[.[] | select(.workspace.id == $ws) | .address] | .[]' -r)

    # Wie viele Spalten?
    COLS=$(echo "sqrt($COUNT + 0.5)" | bc -l | awk '{print int($1 + 0.5)}')
    ROWS=$(( (COUNT + COLS - 1) / COLS ))

    # Startposition zentriert berechnen
    TOTAL_W=$(( COLS * WIN_W + (COLS - 1) * GAP ))
    TOTAL_H=$(( ROWS * WIN_H + (ROWS - 1) * GAP ))
    START_X=$(( (MON_W - TOTAL_W) / 2 ))
    START_Y=$(( (MON_H - TOTAL_H) / 2 ))

    I=0
    while IFS= read -r ADDR; do
        COL=$(( I % COLS ))
        ROW=$(( I / COLS ))
        X=$(( START_X + COL * (WIN_W + GAP) ))
        Y=$(( START_Y + ROW * (WIN_H + GAP) ))

        hyprctl dispatch resizewindowpixel exact ${WIN_W} ${WIN_H},address:${ADDR}
        hyprctl dispatch movewindowpixel exact ${X} ${Y},address:${ADDR}

        I=$(( I + 1 ))
    done <<< "$ADDRESSES"
}

if [ "$FLOATING" -lt "$COUNT" ]; then
    # Alle zu floating
    hyprctl clients -j | jq --argjson ws "$WORKSPACE" \
        '.[] | select(.workspace.id == $ws) | .address' -r | \
        xargs -I{} hyprctl dispatch setfloating address:{}
    sleep 0.01
    arrange_windows
else
    # Alle zu tiled
    hyprctl clients -j | jq --argjson ws "$WORKSPACE" \
        '.[] | select(.workspace.id == $ws) | .address' -r | \
        xargs -I{} hyprctl dispatch settiled address:{}
fi
