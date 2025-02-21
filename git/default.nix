{ pkgs, ... }:

{
	home.packages = with pkgs; [
		git
	];

	programs.git = {
		enable = true;
		aliases = {
			plog = "log --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=iso";
			glog = "plog --all --graph";
			ignore = "!gi() { curl -sL https://www.gitignore.io/api/$@ ;}; gi";
		};
		extraConfig = {
			core = {
				autoCRLF = false;
				editor = "nvim -N";
				quotepath = false;
			};
			pull.rebase = false;
		};
		lfs.enable = true;
	};
}
