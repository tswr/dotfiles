local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Monokai Soda color scheme
config.colors = {
    foreground = "#c4c4b5",
    background = "#171421",
    cursor_bg = "#f6f6ec",
    cursor_border = "#f6f6ec",
    cursor_fg = "#111111",
    selection_bg = "#343434",
    selection_fg = "#191919",
    ansi = { "#191919", "#f3005f", "#97e023", "#fa8419", "#9c64fe", "#f3005f", "#57d1ea", "#c4c4b5" },
    brights = { "#615e4b", "#f3005f", "#97e023", "#dfd561", "#9c64fe", "#f3005f", "#57d1ea", "#f6f6ee" },
}

config.font = wezterm.font("MonoLisa")
config.font_size = 11

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

return config
