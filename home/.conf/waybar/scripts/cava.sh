#!/bin/bash

bar="▁▂▃▄▅▆▇█"
max_range=7

config_file="/tmp/waybar_cava_config"

# cleanup on exit
trap "rm -f $config_file" EXIT

cat > "$config_file" <<EOF
[general]
bars = 12
framerate = 60
sensitivity = 150

[input]
method = pipewire
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = $max_range
EOF

# build sed dict dynamically from max_range so it never breaks if you change it
dict="s/;//g;"
i=0
while [ $i -le $max_range ]; do
  dict="${dict}s/$i/${bar:$i:1}/g;"
  i=$((i+1))
done

cava -p "$config_file" | while read -r line; do
  echo "$line" | sed "$dict"
done