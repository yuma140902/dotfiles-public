{ nixpkgs, stateVersion, nixos-wsl, ... }: let
	hostname = "raytrek-wsl";
	pkgs = import nixpkgs {
		system = "x86_64-linux";
		config.allowUnfree = true;
	};
in {
	name = hostname;
	value = nixpkgs.lib.nixosSystem {
		system = "x86_64-linux";
		modules = [
			nixos-wsl.nixosModules.default {
				system.stateVersion = stateVersion;
				networking.hostName = hostname;
				nix.settings.experimental-features = ["nix-command" "flakes"];
				wsl = {
					enable = true;
					defaultUser = "yuma";
					docker-desktop.enable = true;
					interop.includePath = false;
				};
				users.users.yuma = {
					isNormalUser = true;
					home = "/home/yuma";
					extraGroups = ["wheel"];
					shell = pkgs.zsh;
				};
				programs.zsh.enable = true;
				environment.pathsToLink = [
					"/share/zsh"
				];
			}

		];
	};
}
