-------------
---- SMW ----
-------------

local monitors_amount = #hl.get_monitors();
local workspace_count = 8

if monitors_amount < 2 then
    hl.notification.create({ text = "applying configuration for 1 monitor setup", timeout = 5000 })
    workspace_count = 8
elseif monitors_amount == 2 then
    hl.notification.create({ text = "applying configuration for 2 monitors setup", timeout = 5000 })
    workspace_count = 6
else
    hl.notification.create({ text = "applying configuration for 3+ monitors setup", timeout = 5000 })
    workspace_count = 4
end

package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")

smw.setup({
    workspace_count = workspace_count,
    enable_wrapping = false,
})


for i = 1, smw.get_amount_of_workspaces() do
    local n = tostring(i)
    -- Switch to the Nth workspace on the currently focused monitor.
    hl.bind(mainMod .. " +" .. n, smw.workspace(n))
    -- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
    hl.bind(mainMod .. " + SHIFT +" .. n, smw.move_to_workspace_silent(n))
end

hl.bind(mainMod .. " + mouse_down",     smw.cycle_workspaces("next"))
hl.bind(mainMod .. " + mouse_up",       smw.cycle_workspaces("prev"))
hl.bind("CTRL + SHIFT + RIGHT",         smw.workspace("+1"))   -- Next workspace (relative).
hl.bind("CTRL + SHIFT + LEFT",          smw.workspace("-1")) -- Previous workspace (relative).
hl.bind(mainMod .. " + SHIFT + G",      smw.grab_rogue_windows())


local window_workspace_map = {
    [1] = {
        ["firefox"]    = { target = "1" },
        ["code"]       = { target = "2" },
        ["kitty"]      = { target = "3" },
        ["gitkraken"]  = { target = "4", silent = true },
        ["slack"]      = { target = "5" },
        ["chromium"]   = { target = "6" },
    },
    [2] = {
        ["slack"]     = { target = "1" },
        ["chromium"]  = { target = "2" },
        ["firefox"]   = { target = "7" },
        ["code"]      = { target = "8" },
        ["kitty"]     = { target = "9" },
        ["gitkraken"] = { target = "10", silent = true },
    },
    [3] = {
        ["slack"]     = { target = "1" },
        ["firefox"]   = { target = "5" },
        ["code"]      = { target = "6" },
        ["kitty"]     = { target = "9" },
        ["gitkraken"] = { target = "10", silent = true },
        ["chromium"]  = { target = "11" },
    },
}


local function apply_rules_and_remap()
    local n = #hl.get_monitors()

    if n > 3 then n = 3 elseif n < 1 then n = 1 end
    local ws_map = window_workspace_map[n]
    if not ws_map then return end

    for class, entry in pairs(ws_map) do
        local ws_str = entry.target
        if entry.silent then ws_str = ws_str .. " silent" end
        hl.window_rule({ workspace = ws_str, match = { class = class } })
    end

    for _, win in ipairs(hl.get_windows()) do
        if not win.mapped or win.special or not win.class or not win.workspace then
            goto continue
        end

        local entry = ws_map[win.class]
        if not entry then goto continue end

        if win.workspace.name ~= entry.target then
            hl.dispatch(hl.dsp.window.move({ workspace = entry.target, window = win, follow = false }))
            -- use this for debugging:
            -- watch -n 0.1 "grep \"SMW\" $XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/hyprland.log | tail -n 20"
            print("[SMW] Moved window " .. win.class .. " from workspace " .. win.workspace.name .. " to workspace " .. entry.target)
        end

        ::continue::
    end
end

apply_rules_and_remap()


hl.on("monitor.added", function()
    -- for callbacks it could be more reliable to async the update
    hl.exec_cmd("bash -c 'sleep 0.4 && hyprctl reload'")
    -- apply_rules_and_remap()
end)
hl.on("monitor.removed", function()
     -- for callbacks it could be more reliable to async the update
    hl.exec_cmd("bash -c 'sleep 0.4 && hyprctl reload'")
    -- apply_rules_and_remap()
end)
-- hl.dsp.window.
