{ pkgs, ... }:

{
	home.packages = with pkgs; [
		git
	];

	programs.git = {
		enable = true;
		settings = {
			core = {
				autoCRLF = false;
				editor = "nvim -N";
				quotepath = false;
			};
			pull.rebase = false;
			include.path = "~/.gitconfig.private";
			alias = {
				plog = "log --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=iso";
				glog = "plog --all --graph";
				ignore = "!gi() { curl -sL https://www.gitignore.io/api/$@ ;}; gi";
			};
		};
		lfs.enable = true;
	};
}
