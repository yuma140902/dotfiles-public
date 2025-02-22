{ pkgs, ... }:

{
	home.packages = [
		pkgs.zsh
	];

	home.file = {
		"./.zshrc".source = ./.zshrc;
	};

	xdg.configFile = {
		"zsh-abbr/user-abbreviations".source = ./user-abbreviations;
	};
}
