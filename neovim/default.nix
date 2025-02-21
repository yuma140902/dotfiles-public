{ pkgs, ... }:

{
	programs.neovim = {
		enable = true;
		defaultEditor = true;

		extraPackages = with pkgs; [
			fd
			ripgrep
			nodePackages.eslint
			nodePackages.prettier
			nodejs_23
			python3
			llvmPackages_19.clang-tools
			rust-analyzer
		];

		extraLuaConfig = ''
		'';
	};
}
