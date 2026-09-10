local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.initial_cols = 120
config.initial_rows = 28

config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 12

config.color_scheme = 'Tokyo Night'
config.default_prog = { 'pwsh.exe', '-NoLogo' }

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

config.window_decorations = "TITLE | RESIZE"

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
    background = "#1a1b26",

    active_tab = {
      bg_color = "#7aa2f7",
      fg_color = "#1a1b26",
    },

    inactive_tab = {
      bg_color = "#24283b",
      fg_color = "#c0caf5",
    },

    inactive_tab_hover = {
      bg_color = "#2f3549",
      fg_color = "#c0caf5",
    },

    new_tab = {
      bg_color = "#1a1b26",
      fg_color = "#565f89",
    },

    new_tab_hover = {
      bg_color = "#24283b",
      fg_color = "#c0caf5",
    },
  },
}

wezterm.on("format-tab-title", function(tab)
  local bg = "#24283b"
  local fg = "#c0caf5"

  if tab.is_active then
    bg = "#7aa2f7"
    fg = "#1a1b26"
  end

  local title = tab.active_pane.title

  return {
    { Background = { Color = "#1a1b26" } },
    { Foreground = { Color = bg } },
    { Text = "" },

    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = " 󰆍 " .. title .. " " },

    { Background = { Color = "#1a1b26" } },
    { Foreground = { Color = bg } },
    { Text = "" },
  }
end)

-- Start WezTerm maximized
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)


return config
