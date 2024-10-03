local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Default theme
config.color_scheme = "rose-pine-moon"

-- Custom font-size
config.font_size = 10
if wezterm.target_triple == "x86_64-apple-darwin" then
	config.font_size = 13
end

-- Disable multiplexer elements as we are using tmux
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_close_confirmation = "NeverPrompt"

-- Keybindings
local mod = "ALT"
if wezterm.target_triple == "x86_64-apple-darwin" then
	mod = "CMD"
end

config.use_dead_keys = false
config.keys = {

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

-- Setup tmux on start
config.default_prog = { "wsl", "--exec", "bash", "-c", "tmux attach || tmux" }
if wezterm.target_triple == "x86_64-apple-darwin" then
	config.default_prog = { "/bin/zsh", "-l", "-c", "tmux attach || tmux" }
end

-- End
return config

