vim.loader.enable()
require 'rc.disable_default_plugins'
require 'rc.base'
require 'rc.gui'
require 'rc.plugins'
require 'keymaps'.register_keymaps()
