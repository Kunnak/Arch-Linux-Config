#!/usr/bin/env bash
# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────
#
THEMES_DIR="$HOME/.config/waybar/themes"
STYLE_LINK="$HOME/.config/waybar/style.css"
CURRENT_FILE="$HOME/.config/waybar/.current-theme"

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────

# Wallpaper pro Theme definieren
declare -A WALLPAPERS
WALLPAPERS["Beach"]="$HOME/Github/Wallpaper/Waypaper-Wallpaper/32:9/Anime-Girls/beach-girl-2.png"
WALLPAPERS["Blue-Asian-Arch"]="$HOME/Github/Wallpaper/Waypaper-Wallpaper/32:9/Anime-Girls/blue-moon-anime.jpg"
WALLPAPERS["Gruvbox"]="$HOME/Github/Wallpaper/Waypaper-Wallpaper/32:9/Wallpaper/orange-cool-cat.jpg"
WALLPAPERS["Red-Skeleton"]="$HOME/Github/Wallpaper/Waypaper-Wallpaper/32:9/Wallpaper/red-praying-skeleton.jpg"

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────

# Welches wlogout-Theme gehört zu welchem Waybar-Theme
declare -A WLOGOUT_THEMES
WLOGOUT_THEMES["Beach"]="sky-indigo"
WLOGOUT_THEMES["Blue-Asian-Arch"]="cyan"
WLOGOUT_THEMES["Gruvbox"]="default"
WLOGOUT_THEMES["Red-Skeleton"]="light-red"

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────

# Hyprland Border-Farben pro Theme
declare -A HYPR_BORDERS
HYPR_BORDERS["Gruvbox"]="0xaaeb2f30 0xff210a16 90deg"
HYPR_BORDERS["Beach"]="0xaa83a598 0xff0d3221 90deg"
HYPR_BORDERS["Red-Skeleton"]="0xaaeb2f30 0xff210a16 90deg"

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────

themes=$(ls "$THEMES_DIR")
current=$(cat "$CURRENT_FILE" 2>/dev/null || echo "none")

selected=$(echo "$themes" | while read -r theme; do
    if [[ "$theme" == "$current" ]]; then
        echo "$theme  (aktiv)"
    else
        echo "$theme"
    fi
done | rofi -dmenu -p "Theme" -i)

[[ -z "$selected" ]] && exit 0

theme_name=$(echo "$selected" | sed 's/  (aktiv)//')

# Symlink setzen
ln -sf "$THEMES_DIR/$theme_name/style.css" "$STYLE_LINK"
echo "$theme_name" > "$CURRENT_FILE"

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────

# Wallpaper wechseln falls definiert
if [[ -n "${WALLPAPERS[$theme_name]}" && -f "${WALLPAPERS[$theme_name]}" ]]; then
    waypaper --wallpaper "${WALLPAPERS[$theme_name]}"
fi

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────

WLOGOUT_STYLE="$HOME/.config/wlogout/style.css"
wlogout_theme="${WLOGOUT_THEMES[$theme_name]}"

if [[ -n "$wlogout_theme" ]]; then
    echo "@import \"themes/$wlogout_theme/style.css\";" > "$WLOGOUT_STYLE"
fi

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────

HYPR_CONFIG="$HOME/.config/hypr/conf/windows/window.conf"
border="${HYPR_BORDERS[$theme_name]}"

if [[ -n "$border" ]]; then
    sed -i "s|col.active_border = .*|col.active_border = $border|" "$HYPR_CONFIG"
    # Hyprland neu laden damit die Farbe sofort greift
    hyprctl reload
fi

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────

# Waybar neu laden
pkill -SIGUSR2 waybar || (pkill waybar && waybar &)

notify-send "Waybar Theme" "$theme_name" --icon=preferences-desktop-theme

# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────
