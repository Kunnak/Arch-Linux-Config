#!/usr/bin/env bash

notify-send "Wecker" "Aufstehen."

while true; do
    paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
    sleep 1
done
