{ pkgs, ... }:

{
	home.packages = with pkgs; [
		fd
	];

	programs.bat.enable = true;
	programs.ripgrep.enable = true;
	programs.less.enable = true;
}
