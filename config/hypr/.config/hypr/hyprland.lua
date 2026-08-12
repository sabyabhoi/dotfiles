-- ----------------
-- MONITORS -------
-- ----------------

hl.monitor({
    output = "DP-2",
    mode = "2560x1440@144",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60",
    position = "2560x0",
    scale = 1,
})

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

-- -------------------
-- MY PROGRAMS --------
-- -------------------

local terminal = "ghostty"
local mainMod = "SUPER"

-- -----------------
-- AUTOSTART --------
-- -----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon --format xrgb")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

-- -----------------------------
-- ENVIRONMENT VARIABLES --------
-- -----------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- ---------------------
-- LOOK AND FEEL --------
-- ---------------------

hl.config({
    render = {
        cm_auto_hdr = 0,
        direct_scanout = 2,
    },

    general = {
        gaps_in = 5,
        gaps_out = 15,
        border_size = 1,
        resize_on_border = true,
        allow_tearing = false,
        layout = "scrolling",
    },

    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("fast", { type = "bezier", points = { {0.05, 0.0}, {0.05, 1.0} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 1, bezier = "fast", style = "slide" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 1, bezier = "fast", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1, bezier = "fast", style = "slide" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "fast", style = "slide" })
hl.animation({ leaf = "fade",       enabled = true, speed = 1, bezier = "fast" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 1, bezier = "fast" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 1, bezier = "fast" })

hl.config({
    dwindle = {
        preserve_split = true,
    },

    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.9,
        direction = "right",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
})

-- -------------
-- INPUT --------
-- -------------

hl.config({
    input = {
        kb_layout = "us,us",
        kb_variant = ",colemak",
        kb_model = "",
        kb_options = "caps:escape,ctrl:swap_lalt_lctl,grp:alt_space_toggle",
        kb_rules = "",
        repeat_delay = 200,
        repeat_rate = 25,
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- -------------------
-- KEYBINDINGS --------
-- -------------------

hl.bind("SUPER + SHIFT + space", hl.dsp.exec_cmd("hyprctl switchxkblayout sino-wealth-gaming-kb--keyboard next"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen())
hl.bind("SUPER + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + z", hl.dsp.exec_cmd("handy --toggle-transcription"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("emacsclient -c"))
hl.bind(mainMod .. " + t", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("vicinae open"))
hl.bind(mainMod .. " + p", hl.dsp.window.pseudo())

-- Scrolling layout messages
hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + comma",  hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + comma",  hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.layout("focus r"))
hl.bind(mainMod .. " + mouse_down", hl.dsp.layout("focus l"))

-- Focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + x", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind("CTRL + space", hl.dsp.exec_cmd("dunstctl close"))

-- Move current workspace to monitor
hl.bind(mainMod .. " + CTRL + l", function() hl.dispatch("movecurrentworkspacetomonitor", "r") end)
hl.bind(mainMod .. " + CTRL + h", function() hl.dispatch("movecurrentworkspacetomonitor", "l") end)

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Repeating binds (binde)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 10%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 && wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 10%-"), { repeating = true })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m region"), { repeating = true })
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m active -m window"), { repeating = true })

-- Locked binds (bindl)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +10%"), { locked = true })

-- ------------------------------
-- WINDOWS AND WORKSPACES --------
-- ------------------------------

hl.window_rule({
    name = "windowrule-1",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "windowrule-2",
    match = {
        class = "jetbrains-idea-ce",
        title = "^win(.*)",
    },
    no_initial_focus = true,
    no_focus = true,
    no_follow_mouse = true,
})
