#!/usr/bin/env bash
# @vicinae.schemaVersion 1
# @vicinae.title Focus VS Code Window
# @vicinae.mode silent

output=$(hyprctl clients -j | jq -r '.[] | select(.class == "code") | .title' | vicinae dmenu --placeholder 'Focus Code Window...')
address=$(hyprctl clients -j | jq -r ".[] | select(.title == \"${output}\") | .address")

hyprctl dispatch "hl.dsp.focus({ window = 'address:${address}' })"
hyprctl dispatch "hl.dsp.window.fullscreen({ window = 'address:${address}', mode = 'fullscreen' })"
