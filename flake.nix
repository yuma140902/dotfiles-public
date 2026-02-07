{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
		home-manager.url = "github:nix-community/home-manager/release-24.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};


	outputs = { self, nixpkgs, nixpkgs-unstable, nixos-wsl, home-manager, ... } @ inputs: let
		stateVersion = "24.11";
	in {
		nixosConfigurations = builtins.listToAttrs [
			(import ./hosts/raytrek-wsl.nix (inputs // {
				stateVersion = stateVersion; 
			}))
		];

		homeConfigurations = {
			yuma = home-manager.lib.homeManagerConfiguration {
				pkgs = import nixpkgs {
					system = "x86_64-linux";
					config.allowUnfree = true;
				};
				extraSpecialArgs = {
					inherit inputs;
					username = "yuma";
					homeDirectory = "/home/yuma";
					stateVersion = stateVersion;
					pkgsUnstable = import nixpkgs-unstable {
						system = "x86_64-linux";
						config.allowUnfree = true;
					};
				};
				modules = [
					./home-manager/base.nix
					./home-manager
					./home-manager/misc-cli.nix
					./fzf
					./gh
					./git
					./neovim
					./tmux
					./zsh
				];
			};
		};
	};
}
