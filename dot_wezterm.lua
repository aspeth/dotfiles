local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

config.font = wezterm.font("JetBrains Mono")
config.font_size = 18

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.7,
}

config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = "Night Owl (Gogh)"
config.default_cursor_style = "BlinkingBlock"
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
		key = "UpArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "ALT|SUPER",
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "r",
		mods = "CMD|SHIFT",
		action = wezterm.action.ReloadConfiguration,
	},
}

return config
