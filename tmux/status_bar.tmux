#!/bin/bash

# reference: https://github.com/odedlaz/tmux-onedark-theme

black="#282c34"
blue="#61afef"
yellow="#e5c07b"
red="#e06c75"
white="#aab2bf"
green="#98c379"
purple="#c678dd"
visual_grey="#3e4452"
comment_grey="#5c6370"

function set {
   local option=$1
   local value=$2
   tmux set-option -g "$option" "$value"
}

function setw {
   local option=$1
   local value=$2
   tmux set-window-option -g "$option" "$value"
}

set status-position bottom
set status-interval 1
set status-left-length 90
set status-right-length 90

set status-bg "$black"
set status-fg "$white"

set status-right "#H #{tmux_mode_indicator}"
set status-left "#[bg=$green,fg=$black] #S #[default] "

set "display-panes-active-colour" "$yellow"
set "display-panes-colour" "$blue"

setw window-status-format "#[bg=$visual_grey,fg=$white] #I: #W "
setw window-status-current-format "#[bg=$purple,fg=$black,bold] #I: #W "
