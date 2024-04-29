local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 18

config.color_scheme = "Night Owl (Gogh)"
config.window_close_confirmation = "NeverPrompt"

config.keys = {
	{
		key = "d",
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
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Down"),
	},
}

return config
