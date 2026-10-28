hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name  = "waydroid-fullscreen",
    match = { class = "Waydroid" },
    float      = true,
    fullscreen = true,
})

hl.window_rule({
    name  = "pavucontrol-float",
    match = { class = "^(org.pulseaudio.pavucontrol)$" },
    float = true,
    size  = "600 400",
    move  = "1314 50",
})

hl.window_rule({
    name  = "bluetui-float",
    match = { class = "^(kitty)$", title = "^(bluetui)$" },
    float = true,
    size  = "600 400",
    move  = "1314 50",
})

hl.window_rule({
    name  = "nmtui-float",
    match = { class = "^(kitty)$", title = "^(nmtui)$" },
    float = true,
    size  = "600 400",
    move  = "1314 50",
})

hl.window_rule({
    name  = "kitty-full-opacity",
    match = { class = "^(kitty)$" },
    opacity = "1.0 1.0",
})
