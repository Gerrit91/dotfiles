---------------------
---- MY PROGRAMS ----
---------------------

terminal    = "kitty"
fileManager = "ADW_DISABLE_PORTAL=1 nautilus"
browser     = "firefox"

---------------------
---- KEYBINDINGS ----
---------------------

mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wikkii.hypr.land/Configuring/Basics/Binds/ for more

hl.bind(mainMod .. " + T",              hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + RETURN",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SPACE",          hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + W",              hl.dsp.window.close())
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",              hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",              hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",              hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + F",              hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + Z",              hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + L",              hl.dsp.exec_cmd("hyprlock"))
hl.bind("CTRL + ALT + SPACE",           hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"))
hl.bind(mainMod .. " + ALT + SPACE",    hl.dsp.exec_cmd("/home/gerrit/.local/share/vicinae/scripts/focus-vs-code-window.sh"))

-- Move focus with mainMod + arrow keys

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspace and window management

hl.bind(mainMod .. " + SHIFT + left",   hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + right",  hl.dsp.window.move({ workspace = "e+1" }))
hl.bind("CTRL + ALT + left",            hl.dsp.focus({ workspace = "e-1" }))
hl.bind("CTRL + ALT + right",           hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse:272",      hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",      hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + CTRL + right",   hl.dsp.window.resize({ x = 30, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + left",    hl.dsp.window.resize({ x = -30, y = 0, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + up",      hl.dsp.window.resize({ x = 0, y = -30, relative = true}), { repeating = true })
hl.bind(mainMod .. " + CTRL + down",    hl.dsp.window.resize({ x = 0, y = 30, relative = true}), { repeating = true })

-- Special workspace (scratchpad)

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Special keybindings

hl.bind("XF86AudioRaiseVolume",                 hl.dsp.exec_cmd("amixer sset Master 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",                 hl.dsp.exec_cmd("amixer sset Master 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",                        hl.dsp.exec_cmd("amixer sset Master toggle"),     { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute",                  hl.dsp.exec_cmd(""),   { locked = true, repeating = true })
hl.bind("XF86AudioNext",                        hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause",                       hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",                        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",                        hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("XF86Calculator",                       hl.dsp.exec_cmd("gnome-calculator"))
hl.bind("XF86MonBrightnessUp",                  hl.dsp.exec_cmd("brightnessctl set +10%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",                hl.dsp.exec_cmd("brightnessctl set 10%-"), { locked = true, repeating = true })
hl.bind(mainMod .. " + XF86MonBrightnessUp",    hl.dsp.exec_cmd("hyprctl hyprsunset gamma +10"), { locked = true, repeating = true })
hl.bind(mainMod .. " + XF86MonBrightnessDown",  hl.dsp.exec_cmd("hyprctl hyprsunset gamma -10"), { locked = true, repeating = true })

-- Hyprshot

hl.bind("PRINT",                hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(mainMod .. " + PRINT",  hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind("SHIFT + PRINT",        hl.dsp.exec_cmd("hyprshot -m region"))

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
