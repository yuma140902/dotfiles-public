{ pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		enableCompletion = true;
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
			setopt EXTENDED_GLOB NOMATCH NOTIFY
			unsetopt AUTO_CD BEEP
			unsetopt CLOBBER

			HISTFILE=~/.zsh_history
			HISTSIZE=1000000
			SAVEHIST=1000000
			#HISTORY_IGNORE="(ls|cd|nvim|vim)"
			setopt HIST_IGNORE_ALL_DUPS
			setopt HIST_IGNORE_DUPS
			setopt SHARE_HISTORY
			setopt EXTENDED_HISTORY
			setopt HIST_SAVE_NO_DUPS

			bindkey -e
		'';
	};

	xdg.configFile = {
		"zsh-abbr/user-abbreviations".source = ./user-abbreviations;
	};
}
