local mod = "SUPER"

local terminal = "kitty"
local fileManager = "nautilus"
local launcher = "rofi -show drun"
local powerMenu = "rofi -show power"
local locker = "hyprlock"

local workspaceCount = 6

local colors = {
    active = "rgba(63008dff)",
    inactive = "rgba(414b50ff)",
}

local screenshot = [[g=$(slurp) && grim -g "$g" - | wl-copy]]


hl.monitor({ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "-1920x0", scale = 1 })


hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


hl.on("hyprland.start", function()
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("/home/ult/.local/bin/start-audio")
    hl.exec_cmd([[sh -c 'until python /home/ult/distro-rpc.py; do sleep 10; done']])
    hl.exec_cmd("hyprctl setcursor breeze_cursors 24")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
end)


hl.config({
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle",
    },

    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 0,
        col = {
            active_border = colors.active,
            inactive_border = colors.inactive,
        },
        layout = "dwindle",
    },

    decoration = {
        rounding = 12,
        blur = { enabled = false },
        dim_inactive = true,
        dim_strength = 0.12,
    },

    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },

    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },

    animations = {
        enabled = true,
    },
})


hl.bind(mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("ski"))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(launcher))
hl.bind(mod .. " + L", hl.dsp.exec_cmd(locker))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(powerMenu))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot))

hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, workspaceCount do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))

    hl.workspace_rule({ workspace = tostring(i), persistent = true })
end

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })


hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.layer_rule({
    name = "rofi-no-anim",
    match = { namespace = "^rofi$" },
    no_anim = true,
})


hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })
hl.curve("easeOutQuad", { type = "bezier", points = { { 0.25, 0.46 }, { 0.45, 0.94 } } })
hl.curve("easeInQuad", { type = "bezier", points = { { 0.55, 0.085 }, { 0.68, 0.53 } } })
hl.curve("springSoft", { type = "bezier", points = { { 0.18, 1.18 }, { 0.32, 1 } } })
hl.curve("glide", { type = "bezier", points = { { 0.12, 0.9 }, { 0.2, 1 } } })


hl.animation({ leaf = "global", enabled = true, speed = 7, bezier = "default" })

hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.4, bezier = "springSoft", style = "popin 55%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "easeInQuad", style = "popin 70%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.8, bezier = "glide" })

hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "easeOutQuad" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.4, bezier = "easeInQuad" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 2.1, bezier = "easeOutQuad" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 2.1, bezier = "easeOutQuad" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 3.4, bezier = "easeOutQuad" })

hl.animation({ leaf = "border", enabled = true, speed = 2.8, bezier = "easeOutQuad" })

hl.animation({ leaf = "layersIn", enabled = true, speed = 2.1, bezier = "easeOutExpo", style = "popin 90%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "easeInQuad", style = "fade" })

hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3.1, bezier = "easeOutQuint", style = "slidefade 25%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.1, bezier = "easeOutQuint", style = "slidefade 25%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2.8, bezier = "easeOutQuint", style = "slidefadevert 20%" })


require("hyprland-gui")
