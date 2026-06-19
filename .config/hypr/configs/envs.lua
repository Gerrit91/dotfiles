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
