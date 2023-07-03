local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

--config.font = wezterm.font 'HackGen Console NF'
--config.font = wezterm.font 'UDEV Gothic NF'
config.font = wezterm.font 'PlemolJP Console NF'
config.font_size = 10.0
config.use_ime = true
config.color_scheme = 'OneDark (base16)'
config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.window_padding = {
  left = 1,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_opacity = 1.0
-- config.win32_system_backdrop = 'Mica'
config.default_cursor_style = 'SteadyBlock'
config.cursor_blink_rate = 800
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.initial_rows = 26
config.initial_cols = 93
config.launch_menu = {
  {
    label = 'System status (btm)',
    args = { 'btm' }
  },
  {
    label = 'cmd.exe',
    args = { 'cmd' }
  }
}

return config
