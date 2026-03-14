#-----------------------------------------------------
#   ____               _   _             
#  / ___|_ __ ___  ___| |_(_)_ __   __ _ 
# | |  _| '__/ _ \/ _ \ __| | '_ \ / _` |
# | |_| | | |  __/  __/ |_| | | | | (_| |
#  \____|_|  \___|\___|\__|_|_| |_|\__, |
#                                  |___/ 
#
#-----------------------------------------------------
# Greeting komplett deaktivieren
set -U fish_greeting ""

#-----------------------------------------------------
#     _    _ _                    
#    / \  | (_) __ _ ___ ___  ___ 
#   / _ \ | | |/ _` / __/ __|/ _ \
#  / ___ \| | | (_| \__ \__ \  __/
# /_/   \_\_|_|\__,_|___/___/\___|
#
#-----------------------------------------------------

alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='/usr/bin/nvim'
alias internet='nmcli'
alias lock='hyprlock'

# Pacman
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"

# VPN
alias vpn-on='sudo systemctl start openvpn-client@firma'
alias vpn-off='sudo systemctl stop openvpn-client@firma'
alias vpn-status='sudo systemctl status openvpn-client@firma --no-pager'
alias vpn-restart='sudo systemctl restart openvpn-client@firma'
alias vpn-logs='sudo journalctl -u openvpn-client@firma -n 20 --no-pager'
# -----------------------------------------------------
#   ___  _           __  __             ____           _     
#  / _ \| |__       |  \/  |_   _      |  _ \ ___  ___| |__  
# | | | | '_ \ _____| |\/| | | | |_____| |_) / _ \/ __| '_ \ 
# | |_| | | | |_____| |  | | |_| |_____|  __/ (_) \__ \ | | |
#  \___/|_| |_|     |_|  |_|\__, |     |_|   \___/|___/_| |_|
#                           |___/                            
# -----------------------------------------------------
oh-my-posh init fish --config ~/.config/oh-my-posh/windowsconfig.omp.json | source

# Autostart
if status is-interactive
    fastfetch
end

# -----------------------------------------------------
#   ____                      _      _   _                 
#  / ___|___  _ __ ___  _ __ | | ___| |_(_) ___  _ __  ___ 
# | |   / _ \| '_ ` _ \| '_ \| |/ _ \ __| |/ _ \| '_ \/ __|
# | |__| (_) | | | | | | |_) | |  __/ |_| | (_) | | | \__ \
#  \____\___/|_| |_| |_| .__/|_|\___|\__|_|\___/|_| |_|___/
#                      |_|                                 
# -----------------------------------------------------

# Autosuggestions aus
set -U fish_autosuggestion_enabled 0

# Tab-Completion Einstellungen
set -U fish_complete_path $fish_complete_path

# Fuzzy Completion für Tab
set -U fish_fuzzy_match 1

# -----------------------------------------------------
#   ____      _                
#  / ___|___ | | ___  _ __ ___ 
# | |   / _ \| |/ _ \| '__/ __|
# | |__| (_) | | (_) | |  \__ \
#  \____\___/|_|\___/|_|  |___/
# -----------------------------------------------------

# Commands (git, ls) - NORMAL WEIß/BEIGE
set -U fish_color_command ebdbb2

# Parameter/Argumente (status, commit) - ORANGE
set -U fish_color_param 83a598

# Optionen/Flags (-m, --help) - ORANGE
set -U fish_color_option fe8019

# Strings in "" ("test") - GRÜN
set -U fish_color_quote b8bb26

# Dateien/Pfade (config.fish) - BLAU/TÜRKIS (wie Screenshot)
set -U fish_color_valid_path 83a598

# Variablen ($HOME) - BLAU
set -U fish_color_var 83a598

# Kommentare (#) - GRAU
set -U fish_color_comment 928374

# Normaler Text - WEIß
set -U fish_color_normal ebdbb2

# Autosuggestions (graue Vorschläge) - DUNKELGRAU
set -U fish_color_autosuggestion 665c54

# Operatoren (&&, ||) - GELB
set -U fish_color_operator fabd2f

# Redirections (>, <) - LILA
set -U fish_color_redirection d3869b

# Fehler - ROT
set -U fish_color_error fb4934
