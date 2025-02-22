{ pkgs, ... }: let
	configFiles = files: builtins.foldl' (acc: file: acc // { ${file}.source = ./. + "/${file}"; }) {} files;
in {
	programs.neovim = {
		enable = true;
		defaultEditor = true;

		extraPackages = with pkgs; [
			gcc14
			git
			fd
			ripgrep

			nodePackages.prettier
			nodejs_23
			python3
			#llvmPackages_19.clang-tools
			rust-analyzer
			cargo
		];
	};

	xdg.configFile = configFiles [
		"./nvim/ginit.vim"
		"./nvim/init.lua"
		"./nvim/lazy-lock.json"
		"./nvim/ftdetect/pest.vim"
		"./nvim/ftplugin/c.lua"
		"./nvim/ftplugin/markdown.lua"
		"./nvim/ftplugin/nix.lua"
		"./nvim/ftplugin/plaintex.lua"
		"./nvim/ftplugin/tex.lua"
		"./nvim/lua/keymaps.lua"
		"./nvim/lua/pl/aerial.lua"
		"./nvim/lua/pl/ambiwidth.lua"
		"./nvim/lua/pl/auto-split-direction.lua"
		"./nvim/lua/pl/ccc.lua"
		"./nvim/lua/pl/colorful-winsep.lua"
		"./nvim/lua/pl/crates.lua"
		"./nvim/lua/pl/diffview.lua"
		"./nvim/lua/pl/ferris.lua"
		"./nvim/lua/pl/fidget.lua"
		"./nvim/lua/pl/fugitive.lua"
		"./nvim/lua/pl/gitsigns.lua"
		"./nvim/lua/pl/hlchunk.lua"
		"./nvim/lua/pl/lexima.lua"
		"./nvim/lua/pl/lightline.lua"
		"./nvim/lua/pl/lspconfig.lua"
		"./nvim/lua/pl/lspsaga.lua"
		"./nvim/lua/pl/mason-lspconfig.lua"
		"./nvim/lua/pl/mason.lua"
		"./nvim/lua/pl/mini_base16.lua"
		"./nvim/lua/pl/neodev.lua"
		"./nvim/lua/pl/neogen.lua"
		"./nvim/lua/pl/none-ls.lua"
		"./nvim/lua/pl/nvim-cmp.lua"
		"./nvim/lua/pl/nvim-dap-ui.lua"
		"./nvim/lua/pl/nvim-dap.lua"
		"./nvim/lua/pl/nvim-notify.lua"
		"./nvim/lua/pl/nvim-treesitter-context.lua"
		"./nvim/lua/pl/obsidian.lua"
		"./nvim/lua/pl/oil.lua"
		"./nvim/lua/pl/onedark.lua"
		"./nvim/lua/pl/persisted.lua"
		"./nvim/lua/pl/rustaceanvim.lua"
		"./nvim/lua/pl/scrollview.lua"
		"./nvim/lua/pl/suda.lua"
		"./nvim/lua/pl/surround.lua"
		"./nvim/lua/pl/telescope.lua"
		"./nvim/lua/pl/todo-comments.lua"
		"./nvim/lua/pl/tree-sitter.lua"
		"./nvim/lua/pl/treesj.lua"
		"./nvim/lua/pl/twilight.lua"
		"./nvim/lua/pl/vim-partedit.lua"
		"./nvim/lua/pl/which-key.lua"
		"./nvim/lua/pl/wildfire.lua"
		"./nvim/lua/rc/base.lua"
		"./nvim/lua/rc/commands.lua"
		"./nvim/lua/rc/disable_default_plugins.lua"
		"./nvim/lua/rc/gui.lua"
		"./nvim/lua/rc/lib.lua"
		"./nvim/lua/rc/plugins.lua"
	];
}
