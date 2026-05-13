-- VARIABLES
local mods = {
    main = "SUPER",
    backup = "ALT",
}

local dirs = {
    scripts = "~/.config/hypr/scripts"
}

local apps = {
    terminal = "kitty",
    editor = "kitty nvim",
    explorer = "kitty -o confirm_os_window_close=0 yazi",
    browser = "firefox-developer-edition",
    menu = "rofi -dmenu",
    launcher = "rofi -show drun -show-icons"
}

local autostart = {
    "systemctl --user start hyprpolkitagent",
    "waybar",
    "wpaperd",
    "wl-paste --watch cliphist store",
    "hypridle",
    "thunar --daemon",
    "nm-applet",
    "swayosd-server",
    "$scripts/batterynotify.sh"
}

-- Quick functions
local exec = hl.exec_cmd
local b = hl.bind
local bm = function (key, dispatcher, opts) b(mods.main .. " + " .. key, dispatcher, opts) end
local bb = function (key, dispatcher, opts) b(mods.backup .. " + " .. key, dispatcher, opts) end
local e = hl.dsp.exec_cmd
local wr = hl.window_rule

-- AUTOSTART
hl.on("hyprland.start", function ()
    for _, v in ipairs(autostart) do exec(v) end
end)

-- MONITORS
require("monitors")

-- BINDS
-- Window Management
bm("Q", hl.dsp.window.kill())
b("ALT + F4", hl.dsp.window.kill())
bm("Delete", hl.dsp.exit())
bb("W", hl.dsp.window.float())
bm("G", hl.dsp.group.toggle())
b("SHIFT + F11", hl.dsp.window.fullscreen())
bm("L", e("hyprlock"))
bm("SHIFT + F", function ()
    local w = hl.get_active_window()

    if w == nil then return end

    if not w.floating and not w.pinned then
        hl.dsp.window.float()
    end

    hl.dsp.window.pin();

    if w.floating and not w.pinned then
        hl.dsp.window.float()
    end
end)

-- Window Movement / Resizing
bm("SHIFT + CONTROL + Left", function ()
    if hl.get_active_window().floating then
        hl.dsp.window.move(-30, 0)
    else
        hl.dsp.window.move("l")
    end
end, { repeating = true })
bm("SHIFT + CONTROL + Right", function ()
    if hl.get_active_window().floating then
        hl.dsp.window.move(30, 0)
    else
        hl.dsp.window.move("r")
    end
end, { repeating = true })
bm("SHIFT + CONTROL + Up", function ()
    if hl.get_active_window().floating then
        hl.dsp.window.move(0, -30)
    else
        hl.dsp.window.move("u")
    end
end, { repeating = true })
bm("SHIFT + CONTROL + Down", function ()
    if hl.get_active_window().floating then
        hl.dsp.window.move(0, 30)
    else
        hl.dsp.window.move("d")
    end
end, { repeating = true })
bm("mouse:272", hl.dsp.window.drag(), { mouse = true })
bm("mouse:273", hl.dsp.window.resize(), { mouse = true })
bm("Z", hl.dsp.window.drag(), { mouse = true })
bm("X", hl.dsp.window.resize(), { mouse = true })

-- Workspaces
bm("CONTROL + Right", hl.dsp.focus({ workspace = "r+1" }))
bm("CONTROL + Left", hl.dsp.focus({workspace = "r-1" }))
bm("CONTROL + Down", hl.dsp.focus({workspace = "empty" }))
bm("CONTROL + ALT + Right", hl.dsp.window.move({workspace = "r+1" }))
bm("CONTROL + ALT + Left", hl.dsp.window.move({ workspace = "r-1" }))
bb("SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
bb("S", hl.dsp.workspace.toggle_special())

-- Quick launch
bm("T", e(apps.terminal))
bm("B", e(apps.browser))
bm("E", e(apps.explorer))
bm("C", e(apps.editor))
bm("SHIFT + E", e("thunar"))

-- launcher
bm("A", e(apps.launcher))
bm("semicolon", e("flatpak run it.mijorus.smile"))

-- Hardware Control: Audio
b("XF86AudioMute", e("swayosd-client --output-volume mute-toggle"), { locked = true })
b("XF86AudioMicMute", e("swayosd-client --input-volume mute-toggle"), { locked = true })
b("XF86AudioLowerVolume", e(dirs.scripts .. "/volume.sh d"), { locked = true, repeating = true })
b("XF86AudioRaiseVolume", e(dirs.scripts .. "/volume.sh u"), { locked = true, repeating = true })

-- Hardware Control: Media
b("XF86AudioPlay", e("swayosd-client --playerctl play-pause"), { locked = true })
b("XF86AudioPause", e("swayosd-client --playerctl play-pause"), { locked = true })
b("XF86AudioNext", e("swayosd-client --playerctl next"), { locked = true })
b("XF86AudioPrev", e("swayosd-client --playerctl previous"), { locked = true })

-- Hardware Control: Display
b("XF86MonBrightnessUp", e(dirs.scripts .. "/brightness.sh u"), { locked = true, repeating = true })
b("XF86MonBrightnessDown", e(dirs.scripts .. "/brightness.sh d"), { locked = true, repeating = true })

-- Utilities
bm("ALT + P", e("hyprpicker -an"))
bm("V", e("cliphist list | " .. apps.menu .. " | cliphist decode | wl-copy"))
bm("P", e("grimblast -n -f copy area"))
bm("SHIFT + P", e("grimblast -n -f copysave area"))
bm("ALT + SHIFT + P", e("grimblast -n -f edit area"))

-- Wallpaper
bm("ALT + Left", e("wpaperctl previous"))
bm("ALT + Right", e("wpaperctl next"))

-- WINDOWRULES
local function concat(...)
    local r = "^("
    for _, v in ipairs(...) do
        r = r .. v .. ")$|^("
    end
    return r:sub(1, -4)
end

wr({
    match = {
        class = "^(kitty)$"
    },
    opacity = "0.8 override 0.8 override 1",
})

wr({
    match = {
        class = "^(.*vlc.*)$|^(.*[Ss]potify.*)$|^(.*firefox-developer-edition.*)$"
    },
    idle_inhibit = "fullscreen"
})

wr({
    match = {
        title = "^(win\\d+)$",
        class = "^(jetbrains-.*)$"
    },
    float = true,
    no_focus = true
})

wr({
    match = {
        class = "^(jetbrains-.*)$"
    },
    no_initial_focus = true
})

wr({
    match = {
        class = concat(
            "it.mijorus.smile",
            "blueman-manager",
            "nm-connection-editor",
            "zenity",
            "xdg-portal-gtk",
            "steam_proton"
        )
    },
    float = true
})

wr({
    match = {
        class = "^(it.mijorus.smile)$"
    },
    move = "onscreen cursor"
})

wr({
    match = {
        title = "^((?:[Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)|(?:[Ii]ncrustation\\s[vV]idéo))(.*)$"
    },
    float = true,
    keep_aspect_ratio = true,
    move = "73% 72%",
    size = "25% 25%",
    pin = true,
    no_follow_mouse = true
})

wr({
    match = {
        initial_title = "^(Discord Popout)$"
    },
    float = true,
    keep_aspect_ratio = true,
    move = "73% 72%",
    size = "25% 25%",
    pin = true,
    no_follow_mouse = true
})

-- INPUT
hl.config({
    input = {
        kb_layout = "fr,us",
        kb_options = "grp:win_space_toggle",
        numlock_by_default = true,
        touchpad = {
            natural_scroll = true,
            disable_while_typing = false
        }
    }
})

