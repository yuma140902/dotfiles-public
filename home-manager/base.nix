{ stateVersion, username, homeDirectory, ... }:

{
	home.username = username;
	home.homeDirectory = homeDirectory;
	home.stateVersion = stateVersion;
}
