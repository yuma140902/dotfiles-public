vim.loader.enable()
require 'rc.disable_builtin_plugins'
require 'rc.base'
require 'rc.gui'
require 'rc.plugin'
require 'rc.keymaps'.register_keymaps()
require 'rc.commands'
