local mod = "SUPER"

local terminal = "foot"
local fileManager = "nemo"
local launcher = "rofi -show drun"
local wallpaperMenu = "rofi -show wallpaper -theme ~/.config/rofi/wallpaper.rasi"
local audioMenu = "rofi -show audio"
local powerMenu = "rofi -show power"
local locker = "hyprlock"

local workspaceCount = 6

local colors = {
    active = "rgba(a7c080ff)",
    inactive = "rgba(414b50ff)",
}

local screenshot = [[g=$(slurp) && { wayshot -g "$g" --clipboard || wayshot -s "$g" --stdout | wl-copy; }]]

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.on("hyprland.start", function()
hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
hl.exec_cmd("awww-daemon")
hl.exec_cmd("waybar")
hl.exec_cmd("mako")
hl.exec_cmd([[sh -c 'until python /home/ult/distro-rpc.py; do sleep 10; done']])
hl.exec_cmd("hyprctl setcursor breeze_cursors 24")
end)

hl.config({
    input = {
        kb_layout = "us,ru",
        kb_options = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity = 0,
    },

    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = colors.active,
            inactive_border = colors.inactive,
        },
        layout = "dwindle",
        resize_on_border = false,
        allow_tearing = false,
    },

    decoration = {
        rounding = 4,
        blur = { enabled = false },
        shadow = { enabled = false },
    },

    dwindle = {
        preserve_split = true,
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
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(launcher))
hl.bind(mod .. " + V", hl.dsp.exec_cmd(wallpaperMenu))
hl.bind(mod .. " + A", hl.dsp.exec_cmd(audioMenu))
hl.bind(mod .. " + L", hl.dsp.exec_cmd(locker))
hl.bind(mod .. " + W", hl.dsp.exec_cmd(powerMenu))

hl.bind(mod .. " + C", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle",
}))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({
    mode = "maximized",
    action = "toggle",
}))
hl.bind(mod .. " + SHIFT + V", hl.dsp.window.float({
    action = "toggle",
}))
hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + M", hl.dsp.exit())

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + comma", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + period", hl.dsp.window.move({ direction = "right" }))

for i = 1, workspaceCount do
    hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))

    hl.workspace_rule({
        workspace = tostring(i),
                      persistent = true,
    })
    end

    hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshot))

    hl.bind("XF86AudioRaiseVolume",
            hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
            { locked = true, repeating = true })

    hl.bind("XF86AudioLowerVolume",
            hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
            { locked = true, repeating = true })

    hl.bind("XF86AudioMute",
            hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
            { locked = true })

    hl.bind("XF86AudioMicMute",
            hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
            { locked = true })

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

    hl.window_rule({
        name = "float-pavucontrol",
        match = { class = "^org.pulseaudio.pavucontrol$" },
        float = true,
    })

    hl.layer_rule({
        name = "rofi-no-anim",
        match = { namespace = "^rofi$" },
        no_anim = true,
    })

    hl.curve("easeOutExpo", {
        type = "bezier",
        points = { { 0.16, 1 }, { 0.3, 1 } },
    })

    hl.curve("easeOutQuad", {
        type = "bezier",
        points = { { 0.25, 0.46 }, { 0.45, 0.94 } },
    })

    hl.curve("easeInOutCubic", {
        type = "bezier",
        points = { { 0.65, 0 }, { 0.35, 1 } },
    })

    hl.animation({
        leaf = "global",
        enabled = true,
        speed = 10,
        bezier = "default",
    })

    hl.animation({
        leaf = "windowsIn",
        enabled = true,
        speed = 1.8,
        bezier = "easeOutExpo",
        style = "popin 88%",
    })

    hl.animation({
        leaf = "windowsOut",
        enabled = true,
        speed = 1.2,
        bezier = "easeOutQuad",
        style = "popin 92%",
    })

    hl.animation({
        leaf = "windowsMove",
        enabled = true,
        speed = 2,
        bezier = "easeInOutCubic",
    })

    hl.animation({
        leaf = "fade",
        enabled = true,
        speed = 1.8,
        bezier = "easeOutQuad",
    })

    hl.animation({
        leaf = "border",
        enabled = true,
        speed = 3,
        bezier = "easeOutQuad",
    })

    hl.animation({
        leaf = "layers",
        enabled = true,
        speed = 1.5,
        bezier = "easeOutQuad",
        style = "fade",
    })

    hl.animation({
        leaf = "workspaces",
        enabled = true,
        speed = 2.2,
        bezier = "easeOutExpo",
        style = "slidefade 15%",
    })
