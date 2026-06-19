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

require("configs.smw")
