-- Pull in the wezterm API
local wezterm = require 'wezterm'

local M = {}

local BRANCH_SYMBOL = ""

function M.get_branch(cwd)
    local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', cwd, 'branch', '--show-current' }
    if success then
        local branch, _ = stdout:gsub("%s+", "")
        return BRANCH_SYMBOL .. ' ' .. branch
    else
        return nil
    end
end

function M.get_reponame(cwd)
    local result = ""
    local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', cwd, 'config', '--get', 'remote.origin.url' }
    local origin, _ = stdout:gsub("%s+", "")
    if not success then
        return nil
    end

    local success, stdout, stderr = wezterm.run_child_process { 'basename', '-s', '.git', origin }
    local reponame, _ = stdout:gsub("%s+", "")
    if success then
        return reponame
    end

    return nil
end

function M.get_commits_behind(cwd)
    local behind = ""
    local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', cwd, 'rev-list', '--count', 'HEAD..@{u}' }
    if success then
        behind, _ = stdout:gsub("%s+", "")
        if behind ~= "0" then
            behind = behind .. ' '
        end
    end

    return behind
end

function M.get_commits_ahead(cwd)
    local ahead = ""
    local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', cwd, 'rev-list', '--count', '@{u}..HEAD' }
    if success then
        ahead, _ = stdout:gsub("%s+", "")
        if ahead ~= "0" then
            ahead = ahead
        end
    end

    return ahead
end

return M
