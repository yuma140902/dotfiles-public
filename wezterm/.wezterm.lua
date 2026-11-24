local wezterm = require 'wezterm'
local config = wezterm.config_builder()

if config.mux_enable_ssh_agent then
  config.mux_enable_ssh_agent = false
end

local font_name = 'UDEV Gothic NFLG'
--config.font = wezterm.font 'HackGen Console NF'
--config.font = wezterm.font 'UDEV Gothic NF'
config.font = wezterm.font(font_name)
--config.font = wezterm.font 'PlemolJP Console NF'
config.font_size = 10.0
if wezterm.target_triple == 'aarch64-apple-darwin' then
  config.font_size = 12.0
  config.font_rules = {
    -- Prevent normal italic text from slanting
    {
      italic = true,
      intensity = 'Normal',
      font = wezterm.font(font_name, { style = 'Normal' }),
    },
    -- Prevent bold italic text from slanting
    {
      italic = true,
      intensity = 'Bold',
      font = wezterm.font(font_name, { weight = 'Bold', style = 'Normal' }),
    },
  }
end

config.use_ime = true
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

config.color_scheme = 'OneDark (base16)'

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

local extra = {}

---@class Wallpaper
---@field name string 壁紙の名前
---@field filename string ファイル名．`~/.config/wezterm/` からの相対パス
---@field image_brightness number 画像の明るさ．1.0 が元の明るさ
---@field text_brightness number 文字の明るさ．1.0 が元の明るさ

---@return Wallpaper[]
function extra.list_wallpapers()
  return {}
end

---@param wallpapers Wallpaper[]
local function make_wallpaper_choices(wallpapers)
  local ret = {}
  ret[1] = {
    label = 'No wallpaper',
    id = "0",
  }
  for i, wallpaper in ipairs(wallpapers) do
    ret[i + 1] = {
      label = wallpaper.name,
      id = tostring(i),
    }
  end
  return ret
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
        if id == nil then
          return
        end
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
    },
    {
      brief = '[custom] Change wallpaper',
      icon = 'md_wallpaper',
      action = wezterm.action_callback(function(window, pane, line)
        local wallpapers = extra.list_wallpapers()
        if #wallpapers == 0 then
          wezterm.log_info('No wallpapers found')
        end

        window:perform_action(wezterm.action.InputSelector {
          title = 'Select wallpaper',
          action = wezterm.action_callback(function(window, pane, id, label)
            if id == nil then
              return
            end
            local overrides = window:get_config_overrides() or {}
            if id == "0" then
              overrides.background = {}
              overrides.foreground_text_hsb = {}
            else
              local id_num = tonumber(id)
              overrides.background = {
                {
                  source = { File = wezterm.home_dir .. '/.config/wezterm/' .. wallpapers[id_num].filename },
                  hsb = {
                    brightness = wallpapers[id_num].image_brightness,
                  },
                  horizontal_align = 'Center',
                }
              }
              overrides.foreground_text_hsb = {
                brightness = wallpapers[id_num].text_brightness,
              }
            end
            window:set_config_overrides(overrides)
          end),
          choices = make_wallpaper_choices(wallpapers),
          fuzzy = true,
        }, pane)
      end)
    }
  }
end)

-- マシン固有の設定
local local_config = wezterm.home_dir .. '/.wezterm.local.lua'
local file = io.open(local_config, 'r')
if file then
  file:close()
  dofile(local_config)(wezterm, config, extra)
end

return config
