# Arch Linux Config

Meine persönliche Hyprland-Konfiguration.

## Enthaltene Komponenten

- **Hyprland**: Window Manager
- **Waybar**: Status Bar (Gruvbox Theme)
- **Rofi**: App Launcher (Gruvbox Theme)
- **Kitty**: Terminal

## Installation

```bash
# Backup erstellen
mv ~/.config/hypr ~/.config/hypr.backup
mv ~/.config/waybar ~/.config/waybar.backup
mv ~/.config/rofi ~/.config/rofi.backup

# Configs kopieren
cp -r .config/hypr ~/.config/
cp -r .config/waybar ~/.config/
cp -r .config/rofi ~/.config/

# Neuladen
hyprctl reload
