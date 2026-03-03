-- Pull in the wezterm API
local wezterm = require 'wezterm'
local status = require 'status'
local keybindings = require 'keybindings'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 30

-- or, changing the font size and color scheme.
config.font_size = 12
config.font = wezterm.font 'JetBrainsMonoNL Nerd Font Mono'
config.color_scheme = 'Gruvbox Dark (Gogh)'


-- default shell & working directory for windows
-- config.default_cwd = "/code"
-- config.default_prog = { 'pwsh.exe' }
-- config.default_prog = { 'pwsh.exe', '-NoProfile'}


-- key binding
keybindings.configure_keybindings(config)

-- update status bar
status.configure_status_bar()

-- Finally, return the configuration to wezterm:
return config
