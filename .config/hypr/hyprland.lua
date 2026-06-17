------------------
---- MONITORS ----
------------------

local notebook_display = "eDP-1"

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- @x-cellent

hl.monitor({ output = "desc:LG Electronics LG TV 0x01010101",       mode = "preferred", position = "auto", scale = "auto", mirror = notebook_display })
hl.monitor({ output = "desc:Sharp Corporation PN-R706 0x01010101",  mode = "preferred", position = "auto", scale = "auto", mirror = notebook_display })
hl.monitor({ output = "desc:Acer Technologies P5260E J60020016010", mode = "preferred", position = "auto", scale = "auto", mirror = notebook_display })

-- @FI-TS

hl.monitor({ output = "desc:HP Inc. HP Z24n G2 6CM0141CLJ", mode = "preferred", position = "1920x0", scale = "1" })
hl.monitor({ output = "desc:HP Inc. HP Z24n G2 6CM0141CCM", mode = "preferred", position = "3840x0", scale = "1" })
hl.monitor({ output = "desc:HP Inc. HP Z24n G2 6CM909242Z", mode = "preferred", position = "1920x0", scale = "1" })
hl.monitor({ output = "desc:HP Inc. HP Z24n G2 6CM90923W3", mode = "preferred", position = "3840x0", scale = "1" })

-- @Home

hl.monitor({ output = "desc:Dell Inc. DELL U3223QE 5H9X6P3", mode = "preferred", position = "auto", scale = "1.5" })

-- @Notebook

hl.monitor({
    output   = notebook_display,
    mode     = "preferred",
    position = "0x0",
    scale    = "1.5",
})

------------------------
---- DYNAMIC CONFIG ----
------------------------

local monitors_amount = #hl.get_monitors();
local workspace_count

if monitors_amount < 2 then
    hl.notification.create({ text = "using configuration for 1 monitor", timeout = 5000 })
    workspace_count = 8
elseif monitors_amount == 2 then
    hl.notification.create({ text = "using configuration for 2 monitors", timeout = 5000 })
    workspace_count = 6
else
    hl.notification.create({ text = "using configuration for 3+ monitors", timeout = 5000 })
    workspace_count = 4
end

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "ADW_DISABLE_PORTAL=1 nautilus"
local browser     = "firefox"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--

-- most of it is started with systemd services, so not much work needed here
hl.on("hyprland.start", function ()
-- hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme \"adw-gtk3\"")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\"")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- as started through systemd, these are located at ~/.config/hyprland/env:
-- hl.env("XCURSOR_SIZE", "24")
-- hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- I don't see any positive effect with these ones:
-- GDK_BACKEND,wayland,x11,*
-- GDK_SCALE,1
-- SDL_VIDEODRIVER,wayland
-- CLUTTER_BACKEND,wayland
-- XDG_CURRENT_DESKTOP,Hyprland
-- XDG_SESSION_TYPE,wayland
-- XDG_SESSION_DESKTOP,Hyprland
-- MOZ_ENABLE_WAYLAND,1
-- HYPRLAND_TRACE,1
-- QT_AUTO_SCREEN_SCALE_FACTOR,0
-- QT_SCALE_FACTOR,1
-- QT_QPA_PLATFORM,wayland;xcb

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({
  ecosystem = {
    enforce_permissions = true,
  },
})

hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprlock", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprshot", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
        smart_split = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

hl.config({
    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
})

hl.config({
    debug = {
        disable_logs = false,
    },
})

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.config({
    gestures = {
        workspace_swipe_distance = 150,
        workspace_swipe_min_speed_to_force = 20,
        workspace_swipe_cancel_ratio = 0.2,
    },
})

-----------------
---- PLUGINS ----
-----------------

package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")

smw.setup({
    workspace_count = workspace_count,
    enable_wrapping = false,
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "de",
        kb_variant = "mac",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 2,

        sensitivity = -0.5, -- -1.0 - 1.0, 0 means no modification.
        numlock_by_default = 1,

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "uniw0001:00-093a:0255-touchpad",
    sensitivity = 0,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wikkii.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + W", hl.dsp.window.kill())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Z", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("CTRL + ALT + SPACE", hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"))
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("~/vscode-focus-changer.sh"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- switch-monitoring-workspaces

for i = 1, smw.get_amount_of_workspaces() do
    local n = tostring(i)
    -- Switch to the Nth workspace on the currently focused monitor.
    hl.bind(mainMod .. " +" .. n, smw.workspace(n))
    -- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
    hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end

hl.bind(mainMod .. " + mouse_down", smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + mouse_up", smw.cycle_workspaces("prev"))
hl.bind("CTRL + SHIFT + RIGHT", smw.workspace("+1"))   -- Next workspace (relative).
hl.bind("CTRL + SHIFT + LEFT", smw.workspace("-1")) -- Previous workspace (relative).
hl.bind(mainMod .. " + SHIFT + G", smw.grab_rogue_windows())

-- Workspace and window management
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("CTRL + ALT + left",  hl.dsp.focus({ workspace = "e-1" }))
hl.bind("CTRL + ALT + right", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 30, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.resize({ x = -30, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.resize({ x = 0, y = -30, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.resize({ x = 0, y = 30, relative = true}), { repeating = true })

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Special keybindings
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("amixer sset Master 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("amixer sset Master 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("amixer sset Master toggle"),     { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(""),   { locked = true, repeating = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86Calculator", hl.dsp.exec_cmd("gnome-calculator"))
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })
hl.bind(mainMod .. " + XF86MonBrightnessUp",   hl.dsp.exec_cmd("hyprctl hyprsunset gamma +10"), { locked = true, repeating = true })
hl.bind(mainMod .. " + XF86MonBrightnessDown", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -10"), { locked = true, repeating = true })

-- Hyprshot
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Tabbing
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
    hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen" }))
end)
hl.bind(mainMod .. " + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next({ next = false }))
    hl.dispatch(hl.dsp.window.bring_to_top())
    hl.dispatch(hl.dsp.window.fullscreen({ mode = "fullscreen" }))
end)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

-- Smart Gaps

hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 1 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

-- Window placement

if monitors_amount < 2 then
    hl.window_rule({ workspace = "1",         match = { class = browser }})
    hl.window_rule({ workspace = "2",         match = { class = "code" }})
    hl.window_rule({ workspace = "3",         match = { class = terminal }})
    hl.window_rule({ workspace = "4 silent",  match = { class = "gitkraken" }})
    hl.window_rule({ workspace = "5",         match = { class = "slack" }})
    hl.window_rule({ workspace = "6",         match = { class = "chromium" }})

    -- hl.workspace_rule({ workspace = "2", layout = "monocle" })
elseif monitors_amount == 2 then
    hl.window_rule({ workspace = "1",         match = { class = "slack" }})
    hl.window_rule({ workspace = "2",         match = { class = "chromium" }})
    hl.window_rule({ workspace = "7",         match = { class = browser }})
    hl.window_rule({ workspace = "8",         match = { class = "code" }})
    hl.window_rule({ workspace = "9",         match = { class = terminal }})
    hl.window_rule({ workspace = "10 silent", match = { class = "gitkraken" }})

    -- hl.workspace_rule({ workspace = "7", layout = "monocle" })
else
    hl.window_rule({ workspace = "1",         match = { class = "slack" }})
    hl.window_rule({ workspace = "5",         match = { class = browser }})
    hl.window_rule({ workspace = "6",         match = { class = "code" }})
    hl.window_rule({ workspace = "9",         match = { class = terminal }})
    hl.window_rule({ workspace = "10 silent", match = { class = "gitkraken" }})
    hl.window_rule({ workspace = "11",        match = { class = "chromium" }})

    -- hl.workspace_rule({ workspace = "6", layout = "monocle" })
end

-- Blur deactivation
hl.window_rule({ match = { class = browser }, no_blur = true })
hl.window_rule({ match = { class = "gitkraken" }, no_blur = true })
hl.window_rule({ match = { class = "code" }, no_blur = true })

-- Open on fullscreen
hl.window_rule({ match = { class = "code", float = false }, fullscreen = true })

-- Open floating
hl.window_rule({ match = { title = "Open File" }, float = true })
hl.window_rule({ match = { title = "Open Files" }, float = true })
hl.window_rule({ match = { title = "Select a File" }, float = true })
hl.window_rule({ match = { title = "Choose wallpaper" }, float = true })
hl.window_rule({ match = { title = "Open Folder" }, float = true })
hl.window_rule({ match = { title = "Add Folder to Workspace" }, float = true })
hl.window_rule({ match = { title = "Save As" }, float = true })
hl.window_rule({ match = { title = "Library" }, float = true })
hl.window_rule({ match = { title = "File Upload" }, float = true })
hl.window_rule({ match = { title = "Export slide deck" }, float = true })

hl.window_rule({ match = { class = "com.wayle.settings" }, float = true })
hl.window_rule({ match = { class = "org.gnome.Calculator" }, float = true })
hl.window_rule({ match = { class = "org.gnome.Nautilus" }, float = true })
hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, float = true })

----------------
---- EVENTS ----
----------------

hl.on("monitor.added", function(w)
    hl.dsp.exec_cmd("hyprctl reload")
end)

hl.on("monitor.removed", function(w)
    hl.dsp.exec_cmd("hyprctl reload")
end)
