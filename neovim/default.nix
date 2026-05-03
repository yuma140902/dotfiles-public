{ pkgs, pkgsUnstable , ... }: let
	configFiles = files: builtins.foldl' (acc: file: acc // { ${file}.source = ./. + "/${file}"; }) {} files;
in {
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		package = pkgsUnstable.neovim-unwrapped;

		extraPackages = with pkgs; [
			gcc14
			git
			fd
			ripgrep

			nodePackages.prettier
			nodejs_24
			python3
			#llvmPackages_19.clang-tools
			rust-analyzer
			cargo
		];
	};

	xdg.configFile = configFiles [
		"./nvim/after/ftplugin/markdown.lua"
		"./nvim/after/lsp/clangd.lua"
		"./nvim/after/lsp/denols.lua"
		"./nvim/after/lsp/jsonls.lua"
		"./nvim/after/lsp/lua_ls.lua"
		"./nvim/after/lsp/ts_ls.lua"
		"./nvim/ftdetect/pest.vim"
		"./nvim/ftplugin/c.lua"
		"./nvim/ftplugin/gitcommit.lua"
		"./nvim/ftplugin/nix.lua"
		"./nvim/ftplugin/plaintex.lua"
		"./nvim/ftplugin/tex.lua"
		"./nvim/init.lua"
		"./nvim/lazy-lock.json"
		"./nvim/lua/plugins/edit-ccc.lua"
		"./nvim/lua/plugins/edit-conform.lua"
		"./nvim/lua/plugins/edit-maketable.lua"
		"./nvim/lua/plugins/edit-neogen.lua"
		"./nvim/lua/plugins/edit-partedit.lua"
		"./nvim/lua/plugins/edit-qfedit.lua"
		"./nvim/lua/plugins/edit-treesj.lua"
		"./nvim/lua/plugins/git-diffview.lua"
		"./nvim/lua/plugins/git-fugitive.lua"
		"./nvim/lua/plugins/git-gitsigns.lua"
		"./nvim/lua/plugins/insert-cmp.lua"
		"./nvim/lua/plugins/insert-copilot.lua"
		"./nvim/lua/plugins/insert-lexima.lua"
		"./nvim/lua/plugins/insert-surround.lua"
		"./nvim/lua/plugins/insert-vsnip.lua"
		"./nvim/lua/plugins/lib-ambiwidth.lua"
		"./nvim/lua/plugins/lib-io.lua"
		"./nvim/lua/plugins/lib-nvim-web-devicons.lua"
		"./nvim/lua/plugins/lib-plenary.lua"
		"./nvim/lua/plugins/lib-treesitter.lua"
		"./nvim/lua/plugins/lisp-paredit.lua"
		"./nvim/lua/plugins/lisp-parinfer.lua"
		"./nvim/lua/plugins/lisp-rainbow-delimiters.lua"
		"./nvim/lua/plugins/lsp-aerial.lua"
		"./nvim/lua/plugins/lsp-fidget.lua"
		"./nvim/lua/plugins/lsp-hlchunk.lua"
		"./nvim/lua/plugins/lsp-lsp_signature.lua"
		"./nvim/lua/plugins/lsp-lspconfig.lua"
		"./nvim/lua/plugins/lsp-lspsaga.lua"
		"./nvim/lua/plugins/lsp-mason-lspconfig.lua"
		"./nvim/lua/plugins/lsp-mason.lua"
		"./nvim/lua/plugins/lsp-schemastore.lua"
		"./nvim/lua/plugins/lua-lazydev.lua"
		"./nvim/lua/plugins/nav-todo-comments.lua"
		"./nvim/lua/plugins/nav-treesitter-context.lua"
		"./nvim/lua/plugins/nav-trouble.lua"
		"./nvim/lua/plugins/other-onedark.lua"
		"./nvim/lua/plugins/other-persisted.lua"
		"./nvim/lua/plugins/other-pest.lua"
		"./nvim/lua/plugins/other-telescope.lua"
		"./nvim/lua/plugins/run-dap-ui.lua"
		"./nvim/lua/plugins/run-dap.lua"
		"./nvim/lua/plugins/run-neotest.lua"
		"./nvim/lua/plugins/rust-crates.lua"
		"./nvim/lua/plugins/rust-rustaceanvim.lua"
		"./nvim/lua/plugins/tool-fterm.lua"
		"./nvim/lua/plugins/tool-linediff.lua"
		"./nvim/lua/plugins/tool-oil.lua"
		"./nvim/lua/plugins/tool-qfreplace.lua"
		"./nvim/lua/plugins/tool-suda.lua"
		"./nvim/lua/plugins/ui-auto-split-direction.lua"
		"./nvim/lua/plugins/ui-lightline.lua"
		"./nvim/lua/plugins/ui-lualine.lua"
		"./nvim/lua/plugins/ui-notify.lua"
		"./nvim/lua/plugins/ui-scrollview.lua"
		"./nvim/lua/plugins/ui-which-key.lua"
		"./nvim/lua/rc/base.lua"
		"./nvim/lua/rc/commands.lua"
		"./nvim/lua/rc/disable_builtin_plugins.lua"
		"./nvim/lua/rc/gui.lua"
		"./nvim/lua/rc/keymaps.lua"
		"./nvim/lua/rc/plugin.lua"
		"./nvim/lua/rc/util.lua"
	];
}
