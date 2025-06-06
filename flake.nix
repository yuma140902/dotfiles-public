{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
		nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
		home-manager.url = "github:nix-community/home-manager/release-24.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
		nixfiles-private = {
			url = "path:/home/yuma/repos/nixfiles-private";
			flake = false;
		};
	};


	outputs = { self, nixpkgs, nixpkgs-unstable, nixos-wsl, home-manager, nixfiles-private, ... } @ inputs: let
		stateVersion = "24.11";
		privateModule = path: if builtins.pathExists "${nixfiles-private}/${path}" then [
			"${nixfiles-private}/${path}"
		] else builtins.trace "WARNING: not found: ${nixfiles-private}/${path}" [];
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
				]
				++ privateModule "home/git.nix";
			};
		};
	};
}
