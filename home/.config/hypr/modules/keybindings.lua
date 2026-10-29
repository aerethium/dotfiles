local defaults = require("modules.defaults")
local mainMod = "SUPER"

-- wlogout menue
hl.bind("SUPER + Escape", hl.dsp.exec_cmd("pkill -x wlogout || wlogout -b 6 -c 0 -r 0 -m 50 -T 480 -B 480"))

-- notifications menue
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t"))

-- terminal
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(defaults.terminal))

-- vicinae
hl.bind("ALT + space", hl.dsp.exec_cmd("vicinae toggle"))

-- close window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- nautilus
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd("nautilus --new-window"))

-- floating window toggle
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))

-- split screen toggle
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- pin window
hl.bind("SUPER + P", hl.dsp.window.pin())

-- zen-browser
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("zen-browser"))

-- obsidian
hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("obsidian"))

-- tauon music player
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("tauon"))

-- kill all active windows of the selected app
hl.bind(
    "SUPER + SHIFT + Q",
    hl.dsp.exec_cmd([[bash -c 'pkill -9 -i $(hyprctl activewindow -j | jq -r ".class" | awk -F. "{print \$NF}")']]),
    { description = "Kill all instances" }
)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9], move window to workspace with + SHIFT
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume / mic / brightness (locked = works even on the lock screen, repeating = holdable)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 2%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 2%-"),                   { locked = true, repeating = true })

-- Media keys (requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Screenshot all
hl.bind(
    "SUPER + CTRL + A",
    hl.dsp.exec_cmd([[grim /tmp/screenshot.png && wl-copy < /tmp/screenshot.png && cp /tmp/screenshot.png ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png]])
)
-- Screenshot section
hl.bind(
    "SUPER + CTRL + S",
    hl.dsp.exec_cmd([[grim -g "$(slurp)" /tmp/screenshot.png && wl-copy < /tmp/screenshot.png && cp /tmp/screenshot.png ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png]])
)

-- hyprexpo toggle
hl.bind("SUPER + W", function() hl.plugin.hyprexpo.expo("toggle") end)
