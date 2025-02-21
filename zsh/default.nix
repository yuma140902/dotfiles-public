{ pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		history.append = false;
		history.expireDuplicatesFirst = true;
		history.extended = true;
		history.ignorePatterns = [ "ls" "cd" "nvim" "vim" ];
		history.save = 1000000;
		history.share = true;
		history.size = 100000;
		antidote = {
			enable = true;
			plugins = [
				"zsh-users/zsh-syntax-highlighting"
				"zsh-users/zsh-autosuggestions"
				"zsh-users/zsh-completions"
				"sindresorhus/pure"
				"olets/zsh-abbr"
				"chisui/zsh-nix-shell"
			];
		};
		initExtraFirst = ''
			setopt extendedglob nomatch notify
			unsetopt autocd beep
		'';
	};
}
