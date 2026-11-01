-- hyperexpo
local user = os.getenv("USER") or os.getenv("LOGNAME") or ""
hl.plugin.load("/var/cache/hyprpm/" .. user .. "/hyprexpo/hyprexpo.so")

-- autostart 
require("modules.autostart")

-- environment
require("modules.environmentvariables")

-- input
require("modules.input")

-- look and feel
require("modules.lookandfeel")

-- window rules
require("modules.windowrules")

-- monitors
require("modules.monitors")

-- keybindings
require("modules.keybindings")

