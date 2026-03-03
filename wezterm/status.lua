local wezterm = require 'wezterm'

local M = {}

function M.get_git_branch(cwd)
    if not cwd then return "" end

    if cwd:sub(1,1) == '/' then
        cwd = cwd:sub(2)
    end

    -- Run git command in the pane's directory
    local success, stdout, stderr = wezterm.run_child_process({
        'git', '-C', cwd, 'branch', '--show-current'
    })

    if success then
        -- Trim whitespace/newlines
        return stdout:gsub('%s+', '')
    end
    return "Not a git directory"
    -- return cwd .. ": " .. stderr
end

function M.add_status_tag()

end



local BRANCH_SYMBOL = ""


local function get_git_branch(cwd)
    local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', cwd, 'branch', '--show-current' }
    if success then
        local branch, _ = stdout:gsub("%s+", "")
        return BRANCH_SYMBOL .. ' ' .. branch
    else
        return nil
    end
end

local function get_git_status(cwd)
    local branch = get_git_branch(cwd)
    if branch == nil then return nil end
    local ahead = ""
    local behind = ""


    local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', cwd, 'rev-list', '--count', 'HEAD..@{u}' }
    if success then
        behind, _ = stdout:gsub("%s+", "")
        if behind ~= "0" then
            behind = behind .. ' '
        else
            behind = ""
        end
    end

    local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', cwd, 'rev-list', '--count', '@{u}..HEAD' }
    if success then
        ahead, _ = stdout:gsub("%s+", "")
        if ahead ~= "0" then
            ahead = ahead
        else
            ahead = ""
        end
    end

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

local function get_short_cwd(window)
    local cwd = window:active_pane():get_current_working_dir().file_path


    if not cwd then return "" end


    if cwd:sub(1,2) == '/C' then
        cwd = cwd:sub(2)
    end

    local home = ""
    if wezterm.target_triple == "x86_64-pc-windows-msvc" then
        home, _ = os.getenv("UserProfile"):gsub("\\","/")
    else
        home = os.getenv("env:HOME")
    end

    local homeLen = home:len()

    if cwd:sub(1,homeLen) == home then
        cwd = "~" .. cwd:sub(homeLen+1)
    end

    return cwd
end

local function segments_for_right_status(window)
    local cwd = get_short_cwd(window)
    return {
        get_git_status(cwd),
        cwd,
        wezterm.hostname(),
    }
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
    end)

end



return M
