local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 18
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.color_scheme = "Rosé Pine Moon (Gogh)"
config.default_cursor_style = "BlinkingBlock"
config.window_close_confirmation = "NeverPrompt"

config.keys = {
	{
		key = "Enter",
		mods = "SUPER",
		action = wezterm.action.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "r",
		mods = "SUPER",
		action = wezterm.action.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "w",
		mods = "SUPER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "LeftArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "SHIFT|CTRL",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "RightArrow",
		mods = "SHIFT|SUPER",
		action = act.MoveTabRelative(1),
	},
	{
		key = "LeftArrow",
		mods = "SHIFT|SUPER",
		action = act.MoveTabRelative(-1),
	},
	{
		key = "h",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "SHIFT|CTRL",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
}

return config
