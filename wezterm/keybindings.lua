-- Pull in the wezterm API
local wezterm = require 'wezterm'

local M = {}

-- functions for keybindings
local function move_pane(key, direction)
    return {
        key = key,
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection(direction),
    }
end
local function resize_pane(key, direction)
    return {
        key = key,
        action = wezterm.action.AdjustPaneSize { direction, 3 }
    }
end

function M.configure_keybindings(config)
    config.leader = { key = ' ', mods = 'CTRL', timeout_milliseconds = 500 }
    config.keys = {
        {
            mods = 'LEADER',
            key = '\\',
            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },
        {
            key = '-',
            mods = 'LEADER',
            action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },
        {
            mods = 'LEADER',
            key = 'z',
            action = wezterm.action.TogglePaneZoomState,
        },
        move_pane('j', 'Down'),
        move_pane('k', 'Up'),
        move_pane('h', 'Left'),
        move_pane('l', 'Right'),
        {
            -- When we push LEADER + r...
            key = 'r',
            mods = 'LEADER',
            -- Activate the `resize_panes` keytable
            action = wezterm.action.ActivateKeyTable {
                name = 'resize_panes',
                -- Ensures the keytable stays active after it handles its
                -- first keypress.
                one_shot = false,
                -- Deactivate the keytable after a timeout.
                timeout_milliseconds = 1000,
            }
        },
    }

    config.key_tables = {
        resize_panes = {
            resize_pane('j', 'Down'),
            resize_pane('k', 'Up'),
            resize_pane('h', 'Left'),
            resize_pane('l', 'Right'),
        },
    }
end

return M
