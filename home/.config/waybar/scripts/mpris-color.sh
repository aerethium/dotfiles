#!/bin/bash
out="$HOME/.config/waybar/mpris-color.css"
tmp="/tmp/waybar_mpris_art"
prev_url=""

while true; do
  url=$(playerctl metadata mpris:artUrl 2>/dev/null)
  if [ -z "$url" ] || [ "$url" = "$prev_url" ]; then
    sleep 2; continue
  fi
  prev_url="$url"

  rm -f "$tmp"
  if [[ "$url" == file://* ]]; then
    path=$(python3 -c 'import sys,urllib.parse as u; print(u.unquote(sys.argv[1][7:]))' "$url")
    cp "$path" "$tmp" 2>/dev/null
  else
    curl -sL -o "$tmp" "$url" 2>/dev/null
  fi

  color=$(python3 - <<'PYEOF'
try:
    from colorthief import ColorThief
    r, g, b = ColorThief("/tmp/waybar_mpris_art").get_color(quality=1)
    print(f"{r},{g},{b}")
except Exception:
    print("61,61,61")
PYEOF
)
  [ -z "$color" ] && color="61,61,61"

  echo "window#waybar #mpris { border-color: rgba(${color}, 1); background-color: rgba(${color}, 0.15); }" > "$out"
  pkill -SIGUSR2 waybar
  sleep 2
done
