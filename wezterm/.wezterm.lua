local wezterm = require "wezterm"
local config = wezterm.config_builder()
local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_windows = wezterm.target_triple:find("windows") ~= nil

-- Default theme
config.color_scheme = "rose-pine-moon"

-- Custom font-size
config.font_size = 11

-- Default window size
config.initial_cols = 140
config.initial_rows = 80

-- Disable multiplexer elements as we are using tmux
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_close_confirmation = "NeverPrompt"

-- Keybindings
local mod = "ALT"
if is_darwin then
	mod = "CMD"
end

config.use_dead_keys = false
config.keys = {
	{ key = "p", mods = mod,             action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "e", mods = mod,             action = wezterm.action.SendString("\x00\x65") },
	{ key = "z", mods = mod,             action = wezterm.action.SendString("\x00\x7a") },
	{ key = "v", mods = mod,             action = wezterm.action.SendString("\x00\x76") },
	{ key = "w", mods = mod,             action = wezterm.action.SendString("\x00\x77") },
	{ key = "d", mods = mod,             action = wezterm.action.SendString("\x00\x64") },
	{ key = "t", mods = mod,             action = wezterm.action.SendString("\x00\x74") },
	{ key = "h", mods = mod,             action = wezterm.action.SendString("\x00\x68") },
	{ key = "j", mods = mod,             action = wezterm.action.SendString("\x00\x6a") },
	{ key = "k", mods = mod,             action = wezterm.action.SendString("\x00\x6b") },
	{ key = "l", mods = mod,             action = wezterm.action.SendString("\x00\x6c") },
	{ key = "h", mods = mod .. "|SHIFT", action = wezterm.action.SendString("\x00\x48") },
	{ key = "j", mods = mod .. "|SHIFT", action = wezterm.action.SendString("\x00\x4a") },
	{ key = "k", mods = mod .. "|SHIFT", action = wezterm.action.SendString("\x00\x4b") },
	{ key = "l", mods = mod .. "|SHIFT", action = wezterm.action.SendString("\x00\x4c") },
	{ key = "-", mods = mod,             action = wezterm.action.SendString("\x00\x2d") },
	{ key = "1", mods = mod,             action = wezterm.action.SendString("\x00\x31") },
	{ key = "2", mods = mod,             action = wezterm.action.SendString("\x00\x32") },
	{ key = "3", mods = mod,             action = wezterm.action.SendString("\x00\x33") },
	{ key = "4", mods = mod,             action = wezterm.action.SendString("\x00\x34") },
	{ key = "5", mods = mod,             action = wezterm.action.SendString("\x00\x35") },
	{ key = "6", mods = mod,             action = wezterm.action.SendString("\x00\x36") },
	{ key = "7", mods = mod,             action = wezterm.action.SendString("\x00\x37") },
	{ key = "8", mods = mod,             action = wezterm.action.SendString("\x00\x38") },
	{ key = "9", mods = mod,             action = wezterm.action.SendString("\x00\x39") },
}

-- Start WSL on windows
if is_windows then
	config.default_prog = { "wsl", "--exec", "zsh" }
end

-- End
return config

