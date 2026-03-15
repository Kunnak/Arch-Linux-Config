#!/bin/bash
WALLPAPER=$(cat /home/yannick/.cache/Yannick/Wallpaper/current_Wallpaper)
WALLPAPER="${WALLPAPER/#\~//home/yannick}"

# Dateiname extrahieren
FILENAME=$(basename "$WALLPAPER")

# Bild in den Sugar-Candy Backgrounds Ordner kopieren
cp "$WALLPAPER" "/usr/share/sddm/themes/Current-Theme/Backgrounds/$FILENAME"

# Pfad in theme.conf aktualisieren
sed -i "s|^Background=.*|Background=\"Backgrounds/$FILENAME\"|" /usr/share/sddm/themes/Current-Theme/theme.conf
