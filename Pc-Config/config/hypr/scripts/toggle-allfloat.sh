#!/bin/bash
GAP=10

WORKSPACE=$(hyprctl activeworkspace -j | jq '.id')
WINDOWS=$(hyprctl clients -j | jq --argjson ws "$WORKSPACE" '[.[] | select(.workspace.id == $ws)]')
COUNT=$(echo "$WINDOWS" | jq 'length')
FLOATING=$(echo "$WINDOWS" | jq '[.[] | select(.floating == true)] | length')

MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')
SCALE=$(hyprctl monitors -j | jq --arg m "$MONITOR" '.[] | select(.name == $m) | .scale')
MON_W=$(hyprctl monitors -j | jq --arg m "$MONITOR" ".[] | select(.name == \$m) | (.width / $SCALE)" | awk '{print int($1)}')
MON_H=$(hyprctl monitors -j | jq --arg m "$MONITOR" ".[] | select(.name == \$m) | (.height / $SCALE)" | awk '{print int($1)}')

# Fenstergröße abhängig von Anzahl
if [ "$COUNT" -le 4 ]; then
    WIN_W=1200
    WIN_H=600
else
    COLS=$(echo "sqrt($COUNT)" | bc -l | awk '{print int($1 + 0.9)}')
    [ "$COLS" -lt 1 ] && COLS=1
    ROWS=$(( (COUNT + COLS - 1) / COLS ))
    WIN_W=$(( (MON_W - GAP * (COLS + 1)) / COLS ))
    WIN_H=$(( (MON_H - GAP * (ROWS + 1)) / ROWS ))
fi

arrange_windows() {
    ADDRESSES=$(hyprctl clients -j | jq --argjson ws "$WORKSPACE" \
        '[.[] | select(.workspace.id == $ws) | .address] | .[]' -r)

    COLS=$(echo "sqrt($COUNT)" | bc -l | awk '{print int($1 + 0.9)}')
    [ "$COLS" -lt 1 ] && COLS=1
    ROWS=$(( (COUNT + COLS - 1) / COLS ))

    # Gesamtbreite/-höhe des Grids berechnen für Zentrierung
    TOTAL_W=$(( COLS * WIN_W + (COLS - 1) * GAP ))
    TOTAL_H=$(( ROWS * WIN_H + (ROWS - 1) * GAP ))
    START_X=$(( (MON_W - TOTAL_W) / 2 ))
    START_Y=$(( (MON_H - TOTAL_H) / 2 ))

    I=0
    while IFS= read -r ADDR; do
        ROW=$(( I / COLS ))
        COL=$(( I % COLS ))

        # Letzte Reihe zentrieren falls unvollständig
        LAST_ROW_COUNT=$(( COUNT - (ROWS - 1) * COLS ))
        if [ "$ROW" -eq $(( ROWS - 1 )) ] && [ "$LAST_ROW_COUNT" -lt "$COLS" ]; then
            LAST_TOTAL_W=$(( LAST_ROW_COUNT * WIN_W + (LAST_ROW_COUNT - 1) * GAP ))
            X=$(( (MON_W - LAST_TOTAL_W) / 2 + COL * (WIN_W + GAP) ))
        else
            X=$(( START_X + COL * (WIN_W + GAP) ))
        fi

        Y=$(( START_Y + ROW * (WIN_H + GAP) ))

        hyprctl dispatch resizewindowpixel exact ${WIN_W} ${WIN_H},address:${ADDR}
        hyprctl dispatch movewindowpixel exact ${X} ${Y},address:${ADDR}
        I=$(( I + 1 ))
    done <<< "$ADDRESSES"
}

if [ "$FLOATING" -lt "$COUNT" ]; then
    hyprctl clients -j | jq --argjson ws "$WORKSPACE" \
        '.[] | select(.workspace.id == $ws) | .address' -r | \
        xargs -I{} hyprctl dispatch setfloating address:{}
    sleep 0.01
    arrange_windows
else
    hyprctl clients -j | jq --argjson ws "$WORKSPACE" \
        '.[] | select(.workspace.id == $ws) | .address' -r | \
        xargs -I{} hyprctl dispatch settiled address:{}
fi
