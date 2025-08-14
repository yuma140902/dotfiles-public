local M = {}

local function system_is_dark_mode()
  local is_dark_mode = false
  local os_name = vim.loop.os_uname().sysname

  -- OSごとにダークモードかどうかを判定
  if os_name == 'Darwin' then -- macOS
    -- "AppleInterfaceStyle" キーが存在すればダークモード
    local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null')
    if handle then
      local result = handle:read('*a')
      handle:close()
      return result:match('Dark') ~= nil
    end
  elseif os_name == 'Windows_NT' then -- Windows
    -- レジストリの値が 0 ならダークモード
    local handle = io.popen(
      'reg query "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v "AppsUseLightTheme"')
    if handle then
      local result = handle:read('*a')
      handle:close()
      return result:match('0x0') ~= nil
    end
  end

  local current_hour = tonumber(os.date("%H"))
  return current_hour >= 18 or current_hour < 6
end

function M.config()
  vim.o.termguicolors = true
  if system_is_dark_mode() then
    vim.o.background = 'dark'
  else
    vim.o.background = 'light'
  end
  require('solarized').setup {
    error_lens = {
      text = true,
      symbol = true,
    }
  }
  vim.cmd.colorscheme 'solarized'
end

return M
