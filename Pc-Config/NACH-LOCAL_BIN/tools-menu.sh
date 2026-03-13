#!/bin/bash
# tools-menu.sh – Rofi Tools Menü
# Benötigt: rofi, wl-copy, uuidgen, bc, python3 (für Einheitenumrechnung)

# ─── Hilfsfunktionen ───────────────────────────────────────────────────────────

show_result() {
    local title="$1"
    local result="$2"

    # In Zwischenablage kopieren
    echo -n "$result" | wl-copy

    # Als Rofi-Fenster anzeigen + Bestätigung

    # Anzeige im Rofi-Stil
    echo "$result" | rofi -dmenu \
        -no-custom \
        -theme-str 'window { padding: 20px; } inputbar { enabled: false; } listview { lines: 1; } element { padding: 10px; horizontal-align: 0.5; } element-text { horizontal-align: 0.5; }'


    # echo "$result" | rofi -dmenu \
    #   -p "✅ $title" \
    #   -mesg "Ergebnis wurde in die Zwischenablage kopiert" \
    #   -theme-str 'listview { lines: 1; }' \
    #   -no-custom
    }

# ─── UUID ──────────────────────────────────────────────────────────────────────

do_uuid() {
    local choice
    choice=$(printf "🔀 Zufällige UUID (v4)\n🕐 Zeit-basierte UUID (v1)" | \
        rofi -dmenu -p "UUID Typ")

    case "$choice" in
        *"v4"*)  uuid=$(uuidgen -r) ;;
        *"v1"*)  uuid=$(uuidgen -t) ;;
        *)       return ;;
    esac

    show_result "UUID" "$uuid"
}

# ─── SHA256 ────────────────────────────────────────────────────────────────────

do_sha256() {
    local choice
    choice=$(printf "✏️  Text eingeben\n📄 Datei hashen" | \
        rofi -dmenu -p "Quelle")

    case "$choice" in
        *"Text"*)
            input=$(rofi -dmenu -p "Text: ")
            [[ -z "$input" ]] && return
            hash=$(echo -n "$input" | sha256sum | awk '{print $1}')
            show_result "SHA256" "$hash"
            ;;
        *"Datei"*)
            filepath=$(rofi -dmenu -p "SHA256 – Dateipfad eingeben")
            [[ -z "$filepath" || ! -f "$filepath" ]] && \
                rofi -e "❌ Datei nicht gefunden: $filepath" && return
            hash=$(sha256sum "$filepath" | awk '{print $1}')
            show_result "SHA256" "$hash"
            ;;
        *) return ;;
    esac
}

# ─── Taschenrechner ────────────────────────────────────────────────────────────

do_calculator() {
    local expr
    expr=$(rofi -dmenu -p "🧮 Rechner")
    [[ -z "$expr" ]] && return

    # Einheitenumrechnung via Python
    result=$(python3 - "$expr" <<'PYEOF'
import sys, re

expr = sys.argv[1].strip().lower()

# Einheitenumrechnung
unit_conversions = [
  (r'([\d.]+)\s*km\s+in\s+miles?',   lambda m: f"{float(m.group(1)) * 0.621371:.6f} miles"),
  (r'([\d.]+)\s*miles?\s+in\s+km',   lambda m: f"{float(m.group(1)) * 1.60934:.6f} km"),
  (r'([\d.]+)\s*kg\s+in\s+lbs?',     lambda m: f"{float(m.group(1)) * 2.20462:.6f} lbs"),
  (r'([\d.]+)\s*lbs?\s+in\s+kg',     lambda m: f"{float(m.group(1)) / 2.20462:.6f} kg"),
  (r'([\d.]+)\s*m\s+in\s+ft',        lambda m: f"{float(m.group(1)) * 3.28084:.6f} ft"),
  (r'([\d.]+)\s*ft\s+in\s+m',        lambda m: f"{float(m.group(1)) / 3.28084:.6f} m"),
  (r'([\d.]+)\s*°?c\s+in\s+°?f',     lambda m: f"{float(m.group(1)) * 9/5 + 32:.2f} °F"),
  (r'([\d.]+)\s*°?f\s+in\s+°?c',     lambda m: f"{(float(m.group(1)) - 32) * 5/9:.2f} °C"),
  (r'([\d.]+)\s*l\s+in\s+gal',       lambda m: f"{float(m.group(1)) * 0.264172:.6f} gal"),
  (r'([\d.]+)\s*gal\s+in\s+l',       lambda m: f"{float(m.group(1)) / 0.264172:.6f} l"),
  (r'([\d.]+)\s*cm\s+in\s+inch',     lambda m: f"{float(m.group(1)) / 2.54:.6f} inch"),
  (r'([\d.]+)\s*inch\s+in\s+cm',     lambda m: f"{float(m.group(1)) * 2.54:.6f} cm"),
  (r'([\d.]+)\s*€\s+in\s+\$',        lambda m: f"{float(m.group(1)) * 1.08:.2f} $ (ca.)"),
  (r'([\d.]+)\s*\$\s+in\s+€',        lambda m: f"{float(m.group(1)) / 1.08:.2f} € (ca.)"),
]

for pattern, converter in unit_conversions:
  m = re.match(pattern, expr)
  if m:
    print(converter(m))
    sys.exit(0)

# Normaler Taschenrechner mit math-Funktionen
import math
safe_env = {k: getattr(math, k) for k in dir(math) if not k.startswith('_')}
safe_env['abs'] = abs
safe_env['round'] = round
try:
  result = eval(expr, {"__builtins__": {}}, safe_env)
  print(round(result, 10) if isinstance(result, float) else result)
except Exception as e:
  print(f"Fehler: {e}")
PYEOF
)

show_result "Ergebnis" "$result"
}

# ─── Hauptmenü ─────────────────────────────────────────────────────────────────

main() {
    local choice
    choice=$(printf "🔑 UUID generieren\n🔒 SHA256 Hash\n🧮 Taschenrechner" | \
        rofi -dmenu -p "🛠️  Tools")

    case "$choice" in
        *"UUID"*)         do_uuid ;;
        *"SHA256"*)       do_sha256 ;;
        *"Taschenrechner"*) do_calculator ;;
        *) exit 0 ;;
    esac
}

main
