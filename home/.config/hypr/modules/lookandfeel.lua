-- look
hl.config({
    general = {
        resize_on_border = true,
        layout      = "scrolling",
        gaps_in     = 5,
        gaps_out    = 5,
        border_size = 1,
        col = {
            active_border   = "rgba(3d3d3dff)",
            inactive_border = "rgba(1a1a1aff)",
        },
    },
})

hl.config({
    scrolling = {
        column_width = 0.5,
        fullscreen_on_one_column = true,
        focus_fit_method = 1,
        explicit_column_widths = "0.5, 1.0",
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
        rounding           = 16,
		rounding_power     = 4.0,
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


hl.config({
    plugin = {
        scrolloverview = {
            gesture_distance = 300,
            scale = 0.5,
            workspace_gap = 100,
            layout = "vertical",
            wallpaper = 2,
            blur = true,

            shadow = {
                enabled = true,
                range = 50,
            },
        },
    },
})

if hl.plugin.dynamic_cursors then
  hl.config { plugin = { dynamic_cursors = {
    enabled = true,

    -- default behaviour for every cursor
    mode = "rotate",
    threshold = 1,

    rotate = {
      length = 24,   -- matches your cursor size
      offset = 0.0,  -- tweak if the arrow points the wrong way while moving
    },

    stretch = {
      limit = 3000,
      activation = "quadratic",
      window = 100,
    },

    -- shake to find, capped at your Twilight theme's biggest image (48px = 24 x 2)
    shake = {
      enabled = true,
      base = 2.0,
      limit = 2.0,
      timeout = 5000,
      effects = true,
    },

    hyprcursor = {
      enabled = true,
      nearest = 1,
      resolution = -1,   -- loads magnified shapes at 24 x base = 48px
    },
  }}}

  -- stretch on the hand and grab cursors, rotate everywhere else
  hl.plugin.dynamic_cursors.shape_rule { shape = "pointer", mode = "stretch" }
  hl.plugin.dynamic_cursors.shape_rule { shape = "grab",    mode = "stretch" }
end
