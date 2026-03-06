-- Pull in the wezterm API
local wezterm = require 'wezterm'
local git = require 'git'

local M = {}

local function get_git_status(cwd)
    local branch = git.get_branch(cwd)
    if branch == nil then
        return nil
    end
    local ahead = git.get_commits_ahead(cwd)
    local behind = git.get_commits_behind(cwd)

    local diverged = ""
    if ahead ~= "" or behind ~= "" then
        diverged = "󰓢"
    end

    return branch .. ' ' .. ahead .. diverged .. behind
end

local function filter_nils(t)
    local result = {}
    for _, value in pairs(t) do
        if value ~= nil then
            table.insert(result, value)
        end
    end
    return result
end

local function get_cwd(window)
    local pane = window:active_pane()
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri == nil then
        return nil
    end

    return cwd_uri.file_path
end

local function get_short_cwd(long_cwd)
    if long_cwd == nil then
        return ""
    end

    local cwd = long_cwd

    local home = os.getenv("HOME")
    local homeLen = home:len()


    if cwd:sub(1,homeLen) == home then
        cwd = "~" .. cwd:sub(homeLen+1)
    end

    return cwd
end

local function segments_for_right_status(window)
    local cwd = get_cwd(window)
    return {
        get_git_status(cwd),
        git.get_reponame(cwd)
    }
end

local function get_workspace_elements(window)
    local elements = {}

    local active_workspace = window:active_workspace()

    local workspace = ""
    if active_workspace ~= "default" then
        workspace = active_workspace
    end

    return workspace
end

-- functions for keybindings
function M.configure_status_bar()
    wezterm.on('update-status', function(window, _)
        local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
        local segments = filter_nils(segments_for_right_status(window))

        local color_scheme = window:effective_config().resolved_palette
        -- Note the use of wezterm.color.parse here, this returns
        -- a Color object, which comes with functionality for lightening
        -- or darkening the colour (amongst other things).
        local bg = wezterm.color.parse(color_scheme.background)
        local fg = color_scheme.foreground

        -- Each powerline segment is going to be coloured progressively
        -- darker/lighter depending on whether we're on a dark/light colour
        -- scheme. Let's establish the "from" and "to" bounds of our gradient.
        local gradient_to, gradient_from = bg
        gradient_from = gradient_to:lighten(0.2)

        -- Yes, WezTerm supports creating gradients, because why not?! Although
        -- they'd usually be used for setting high fidelity gradients on your terminal's
        -- background, we'll use them here to give us a sample of the powerline segment
        -- colours we need.
        local gradient = wezterm.color.gradient(
            {
                orientation = 'Horizontal',
                colors = { gradient_from, gradient_to },
            },
            #segments -- only gives us as many colours as we have segments.
        )

        -- We'll build up the elements to send to wezterm.format in this table.
        local elements = {}

        for i, seg in ipairs(segments) do
            local is_first = i == 1

            if is_first then
                table.insert(elements, { Background = { Color = 'none' } })
            end
            table.insert(elements, { Foreground = { Color = gradient[i] } })
            table.insert(elements, { Text = SOLID_LEFT_ARROW })

            table.insert(elements, { Foreground = { Color = fg } })
            table.insert(elements, { Background = { Color = gradient[i] } })
            table.insert(elements, { Text = ' ' .. seg .. ' ' })
        end

        window:set_right_status(wezterm.format(elements))
        window:set_left_status(get_workspace_elements(window))
    end)

end

return M
