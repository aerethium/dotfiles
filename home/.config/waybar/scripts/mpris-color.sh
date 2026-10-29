#!/bin/bash

prev_url=""

while true; do
  url=$(playerctl metadata mpris:artUrl 2>/dev/null)

  if [ -z "$url" ]; then
    sleep 2
    continue
  fi

  if [ "$url" = "$prev_url" ]; then
    sleep 2
    continue
  fi

  prev_url="$url"

  tmp="/tmp/waybar_mpris_art"
  if [[ "$url" == file://* ]]; then
    cp "${url#file://}" "$tmp" 2>/dev/null
  else
    curl -s -o "$tmp" "$url" 2>/dev/null
  fi

  color=$(python3 - << 'PYEOF'
from colorthief import ColorThief
try:
    ct = ColorThief("/tmp/waybar_mpris_art")
    r, g, b = ct.get_color(quality=1)
    print(f"{r},{g},{b}")
except:
    print("61,61,61")
PYEOF
)

  echo "#mpris { border-color: rgba(${color}, 1); background-color: rgba(${color}, 0.15); }" > ~/.config/waybar/mpris-color.css
  sleep 2
done
