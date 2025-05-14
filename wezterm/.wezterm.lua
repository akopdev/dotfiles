local wezterm = require "wezterm"
local config = wezterm.config_builder()
local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil
local is_windows = wezterm.target_triple:find("windows") ~= nil

-- Default theme
config.color_scheme = "rose-pine-moon"
config.colors = {
	split = "pink",
  selection_bg = "#524f67"
}
config.hide_tab_bar_if_only_one_tab = true

-- Custom font-size
config.font_size = 11

-- Default window size
config.initial_cols = 180
config.initial_rows = 100

-- Disable multiplexer elements as we are using tmux
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_close_confirmation = "NeverPrompt"

-- Keybindings
local mod = "ALT"
if is_darwin then
	mod = "CMD"
end

local act = wezterm.action

config.use_dead_keys = false
config.keys = {
	{ key = "p", mods = mod,             action = act.PasteFrom("Clipboard") },
	{ key = "z", mods = mod,             action = act.TogglePaneZoomState },
	{ key = "v", mods = mod,             action = act.ActivateCopyMode },
	{ key = "w", mods = mod,             action = act.CloseCurrentPane { confirm = false} },
	{ key = "d", mods = mod,             action = act.SplitHorizontal{ domain = "CurrentPaneDomain" } },
	{ key = "h", mods = mod,             action = act.ActivatePaneDirection "Left" },
	{ key = "j", mods = mod,             action = act.ActivatePaneDirection "Down" },
	{ key = "k", mods = mod,             action = act.ActivatePaneDirection "Up" },
	{ key = "l", mods = mod,             action = act.ActivatePaneDirection "Right" },
	{ key = "h", mods = mod .. "|SHIFT", action = act.AdjustPaneSize { "Left", 5 } },
	{ key = "j", mods = mod .. "|SHIFT", action = act.AdjustPaneSize { "Down", 5 } },
	{ key = "k", mods = mod .. "|SHIFT", action = act.AdjustPaneSize { "Up", 5 } },
	{ key = "l", mods = mod .. "|SHIFT", action = act.AdjustPaneSize { "Right", 5 } },
	{ key = "-", mods = mod,             action = act.SplitVertical{ domain = "CurrentPaneDomain" } },
}

config.key_tables = {
	copy_mode = {
      { key = "h", action = act.CopyMode "MoveLeft" },
      { key = "l", action = act.CopyMode "MoveRight" },
      { key = "j", action = act.CopyMode "MoveDown" },
      { key = "k", action = act.CopyMode "MoveUp" },
      { key = "b", action = act.CopyMode "MoveBackwardWord" },
      { key = "e", action = act.CopyMode "MoveForwardWord" },
      { key = "0", action = act.CopyMode "MoveToStartOfLine" },
      { key = "^", action = act.CopyMode "MoveToStartOfLineContent" },
      { key = "$", action = act.CopyMode "MoveToEndOfLineContent" },
      { key = "g", action = act.CopyMode "MoveToScrollbackTop" },
      { key = "G", action = act.CopyMode "MoveToScrollbackBottom" },
      { key = "v", action = act.CopyMode { SetSelectionMode = "Cell" } },
      { key = "V", action = act.CopyMode { SetSelectionMode = "Line" } },
      { key = "\x16", action = act.CopyMode { SetSelectionMode = "Block" } }, -- Ctrl+v
      {
        key = "y",
        action = act.Multiple {
          act.CopyTo "ClipboardAndPrimarySelection",
          act.CopyMode "Close",
        },
      },
      { key = "q", action = act.CopyMode "Close" },
      { key = "Escape", action = act.CopyMode "Close" },
      { key = "H", action = act.CopyMode "MoveBackwardWord" },
      { key = "L", action = act.CopyMode "MoveForwardWord" },
			{ key = "K",  action =  act.Multiple {
					act.CopyMode "MoveUp",
					act.CopyMode "MoveUp",
					act.CopyMode "MoveUp",
					act.CopyMode "MoveUp",
					act.CopyMode "MoveUp",
				},
			},
			{ key = "J",  action =  act.Multiple {
					act.CopyMode "MoveDown",
					act.CopyMode "MoveDown",
					act.CopyMode "MoveDown",
					act.CopyMode "MoveDown",
					act.CopyMode "MoveDown",
				},
			},
			{ key = "h", mods = "CTRL", action = act.CopyMode "MoveToStartOfLineContent" },
			{ key = "l", mods = "CTRL", action = act.CopyMode "MoveToEndOfLineContent" }
	}
}

-- Start WSL on windows
if is_windows then
	config.default_prog = { "wsl", "--exec", "zsh" }
end

-- End
return config
