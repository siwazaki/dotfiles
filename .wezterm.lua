local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Dracula (Gogh)"
-- config.color_scheme = "Dracula++"
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"
config.use_ime = true

config.font = wezterm.font("FiraCode Nerd Font Mono", {weight="Regular", stretch="Normal", italic=false})
config.font_size = 14.0

return config