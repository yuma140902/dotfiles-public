local wezterm = require 'wezterm'

local config = wezterm.config_builder()

if wezterm.config_builder then
  config = wezterm.config_builder()
end

--config.font = wezterm.font 'HackGen Console NF'
--config.font = wezterm.font 'UDEV Gothic NF'
config.font = wezterm.font 'UDEV Gothic NFLG'
--config.font = wezterm.font 'PlemolJP Console NF'
config.font_size = 10.0
if wezterm.target_triple == 'aarch64-apple-darwin' then
  config.font_size = 12.0
end

config.use_ime = true
config.color_scheme = 'OneDark (base16)'
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'C:\\Program Files\\PowerShell\\7\\pwsh.exe' }

  config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
end
config.window_padding = {
  left = 1,
  right = 0,
  top = 0,
  bottom = 0,
}

--[[
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end
wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config_, hover, max_width)
    local title = tab_title(tab)
    local bg = '#282c34'
    local fg = 'white'
    if tab.is_active then
      bg = '#98c379'
      fg = '#282c34'
    elseif hover then
      bg = '#31353f'
    end
    if tab.is_active then
      return {
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = ' ' .. title .. ' ' },
      }
    end
    return title
  end
)
]]
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup {
  options = {
    theme = 'OneDark (base16)',
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = {},
    tabline_c = {},
    tabline_x = {},
    tabline_y = {},
    tabline_z = { 'domain' }
  },
}
--tabline.apply_to_config(config)
-- https://github.com/michaelbrusegard/tabline.wez/discussions/3
if wezterm.target_triple ~= 'x86_64-pc-windows-msvc' then
  config.use_fancy_tab_bar = false
end
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32
config.status_update_interval = 1000

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  local appearance = wezterm.gui.get_appearance()
  if appearance == 'Dark' then
    config.window_background_opacity = 0.4
    config.win32_system_backdrop = 'Tabbed'
  else
    config.window_background_opacity = 0.98
    config.win32_system_backdrop = 'Tabbed'
  end
end

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
  }
}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
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
end

---@param direction `'horizontal'` | `'vertical'`
local function make_split_with_specified_domain_action_callback(direction)
  local split_direction
  if direction == 'horizontal' then
    split_direction = 'Right'
  else
    split_direction = 'Bottom'
  end

  return wezterm.action_callback(function(window_, pane_)
    local domains = wezterm.mux.all_domains()
    local domain_choices = {}
    for i, domain in ipairs(domains) do
      if domain:is_spawnable() and not string.find(domain:label(), ' mux ') then
        table.insert(domain_choices, {
          label = domain:label(),
          id = domain:name(),
        })
      end
    end

    window_:perform_action(wezterm.action.InputSelector {
      title = 'Select domain',
      action = wezterm.action_callback(function(window__, pane__, id, label)
        pane__:split {
          domain = { DomainName = id },
          direction = split_direction,
        }
      end),
      choices = domain_choices,
      fuzzy = true,
    }, pane_)
  end
  )
end

wezterm.on('augment-command-palette', function(window, pane)
  return {
    {
      brief = '[custom] Split horizontally with specified domain',
      icon = 'cod_split_horizontal',
      action = make_split_with_specified_domain_action_callback('horizontal'),
    },
    {
      brief = '[custom] Split vertically with specified domain',
      icon = 'cod_split_vertical',
      action = make_split_with_specified_domain_action_callback('vertical'),
    }
  }
end)

return config
