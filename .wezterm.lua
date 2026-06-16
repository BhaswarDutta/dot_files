local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 12

config.color_scheme = 'catppuccin-mocha'
config.default_prog = { 'pwsh.exe', '-NoLogo' }

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.window_decorations = "RESIZE"

config.window_close_confirmation = "NeverPrompt"

config.window_padding = {
    left = 30,
    right = 30,
    top = 30,
    bottom = 30,
}

config.default_cursor_style = "SteadyBar"

config.keys = {
    {
        key = "t",
        mods = "CTRL",
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    {
        key = "T",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SpawnCommandInNewTab({
            args = { "wsl.exe", "-d", "archlinux", "--cd", "~" },
        }),
    },
    {
        key = "v",
        mods = "CTRL",
        action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
        key = "w",
        mods = "CTRL",
        action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
}

config.colors = {
    tab_bar = {
        background = "#181825",

        active_tab = {
            bg_color = "#cba6f7",
            fg_color = "#11111b",
        },

        inactive_tab = {
            bg_color = "#313244",
            fg_color = "#cdd6f4",
        },

        inactive_tab_hover = {
            bg_color = "#45475a",
            fg_color = "#cdd6f4",
        },

        new_tab = {
            bg_color = "#181825",
            fg_color = "#6c7086",
        },

        new_tab_hover = {
            bg_color = "#313244",
            fg_color = "#cdd6f4",
        },
    },
}

wezterm.on("format-tab-title", function(tab)
    local bg = "#313244"
    local fg = "#cdd6f4"

    if tab.is_active then
        bg = "#cba6f7"
        fg = "#11111b"
    end

    local title = tab.active_pane.title

    return {
        { Background = { Color = "#181825" } },
        { Foreground = { Color = bg } },
        { Text = "" },

        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = " 󰆍 " .. title .. " " },

        { Background = { Color = "#181825" } },
        { Foreground = { Color = bg } },
        { Text = "" },
    }
end)

return config
