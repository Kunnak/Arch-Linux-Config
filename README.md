# Arch Linux Config

Meine persönliche Hyprland-Konfiguration mit Gruvbox Theme.

## Enthaltene Komponenten

- **hypr/** - Window Manager
- **waybar/** - Status Bar
- **rofi/** - App Launcher
- **kitty/** - Terminal
- **nvim/** & **vim/** - Editoren
- **wlogout/** - Logout Menu
- **autostart/** - Autostart-Apps

## Installation

```bash
git clone https://github.com/Kunnak/Arch-Linux-Config.git
cd Arch-Linux-Config
cp -r .config/* ~/.config/
cp .bashrc ~/
hyprctl reload
