{ pkgs, ... }:

{
	home.packages = with pkgs; [
		fd
		unzip
		wget
	];

	programs.bat.enable = true;
	programs.ripgrep.enable = true;
	programs.less.enable = true;
	programs.htop.enable = true;
	programs.btop.enable = true;
	programs.btop.settings = {
		color_theme = "onedark";
	};
}
