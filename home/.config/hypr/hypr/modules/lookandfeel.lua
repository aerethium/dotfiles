-- look
hl.config({
    general = {
        resize_on_border = true,
        layout      = "dwindle",
        gaps_in     = 5,
        gaps_out    = 10,
        border_size = 2,
        col = {
            active_border   = "rgba(3d3d3dff)",
            inactive_border = "rgba(1a1a1aff)",
        },
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "slave",
        mfact = 0.5,
    },
})

-- animations
hl.config({
    animations = {
        enabled = true,
    },
})

hl.curve("smooth", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
hl.curve("bouncy",  { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "workspaces",  enabled = true, speed = 4, bezier = "bouncy", style = "slide" })
hl.animation({ leaf = "windows",     enabled = true, speed = 5, bezier = "smooth", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5, bezier = "smooth", style = "popin 60%" })
hl.animation({ leaf = "fade",        enabled = true, speed = 5, bezier = "smooth" })

-- misc
hl.config({
    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms  = true,
        key_press_enables_dpms   = true,
        animate_manual_resizes   = true,
    },
})

-- decoration
hl.config({
    decoration = {
        active_opacity     = 0.95,
        inactive_opacity   = 0.75,
        fullscreen_opacity = 1.0,
        rounding           = 6,
        dim_inactive       = true,
        dim_strength       = 0.15,
        blur = {
            enabled              = true,
            size                 = 4,
            passes               = 2,
            ignore_opacity       = true,
            xray                 = false,
            noise                = 0.0117,
            contrast             = 0.89,
            brightness           = 0.82,
            vibrancy             = 0.17,
            vibrancy_darkness    = 0.5,
            new_optimizations    = true,
            popups               = true,
            popups_ignorealpha   = 0.2,
        },
        shadow = {
            enabled      = true,
            range        = 30,
            render_power = 4,
            color = 0x66000000,
        },
    },
})

-- hyprexpo
if hl.plugin.hyprexpo ~= nil then
    hl.config({
        plugin = {
            hyprexpo = {
                columns          = 3,
                gaps_in          = 5,
                gaps_out         = 0,
                bg_col           = "rgb(111111)",
                workspace_method = "center current",
                cancel_key       = "escape",
                show_cursor      = 1,
            },
        },
    })
end
