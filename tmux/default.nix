{ pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		clock24 = true;
		escapeTime = 50;
		historyLimit = 50000;
		mouse = true;
		terminal = "xterm-256color";

		plugins = with pkgs.tmuxPlugins; [
			cpu	
			{
				plugin = onedark-theme;
				extraConfig = ''
					set -g @onedark_widgets '#{cpu_fg_color}  #{cpu_icon} #{cpu_percentage} #{tmux_mode_indicator}'
					set -g @onedark_date_format "%Y/%m/%d"
				'';
			}
			{
				plugin = resurrect;
				extraConfig = ''
					set -g @resurrect-capture-pane-contents 'on'
				'';
			}
			{
				plugin = continuum;
				extraConfig = ''
					set -g @continuum-save-interval '15'
					set -g @continuum-restore 'on'
				'';
			}
			mode-indicator
			{
				plugin = tmux-fzf;
				extraConfig = ''
					TMUX_FZF_LAUNCH_KEY="C-f"
				'';
			}
			# TODO: MunifTanjim/tmux-suspend
		];

		extraConfig = ''
			set-option -sa terminal-features ',xterm-256color:RGB'
			set-option -g focus-events on
			set -g display-time 4000
			set -g set-clipboard on

			bind-key -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
			bind-key -n WheelDownPane select-pane -t= \; send-keys -M

			setw -g mode-keys vi
			bind-key -T copy-mode-vi v send-keys -X begin-selection
			bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
			unbind -T copy-mode-vi MouseDragEnd1Pane
		'';
	};
}
