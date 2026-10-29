hl.config({
    input = {
        kb_layout        = "us",
        kb_options       = "compose:ralt",
        repeat_rate      = 40,
        repeat_delay     = 600,
        numlock_by_default = true,
        sensitivity      = 1,
        accel_profile    = "flat",
        follow_mouse     = 1,
        mouse_refocus    = false,
        scroll_factor    = 1,
        touchpad = {
            natural_scroll        = true,
            clickfinger_behavior  = true,
            disable_while_typing  = false,
            tap_to_click = true,
        },
    },
    gestures = {
        workspace_swipe_invert   = true,
        workspace_swipe_distance = 100,
    },
})

hl.device({
    name          = "elan06fa:00-04f3:31ad-touchpad",
    sensitivity   = 1.0,
    accel_profile = "flat",
    scroll_factor = 0.5,
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.gesture({
    fingers = 3,
    direction = "up",
    action = function() hl.plugin.hyprexpo.expo("toggle") end,
})

hl.gesture({
    fingers = 3,
    direction = "down",
    action = function() hl.plugin.hyprexpo.expo("off") end,
})

hl.window_rule({
    name  = "kitty-touchpad-scroll",
    match = { class = "(kitty)" },
    scroll_touchpad = 1.5,
})
