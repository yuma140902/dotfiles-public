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

# The following lines were added by compinstall
zstyle :compinstall filename '/home/yuma/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting

# 履歴のサジェスト
zinit light zsh-users/zsh-autosuggestions

# まだzsh本体に取り込まれていない補完スクリプト
zinit light zsh-users/zsh-completions

# プロンプト
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit light olets/zsh-abbr

if [ -d "$HOME/.local/bin/" ]; then
  PATH="$PATH:$HOME/.local/bin/"
fi
if [ -d "$HOME/go/bin" ]; then
  PATH="$PATH:$HOME/go/bin"
fi
if [ -d "$HOME/.cargo/bin" ]; then
  PATH="$PATH:$HOME/.cargo/bin"
fi
if [ -d "$HOME/.volta/bin" ]; then
  PATH="$PATH:$HOME/.volta/bin"
fi
if [ -d "$HOME/.cabal/bin" ]; then
  PATH="$PATH:$HOME/.cabal/bin"
fi
if [ -d "$HOME/.ghcup/bin" ]; then
  PATH="$PATH:$HOME/.ghcup/bin"
fi
if [ -d "/usr/local/texlive/2024/bin/x86_64-linux/" ]; then
  PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux/"
fi
export PATH

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

if type 'pyenv' > /dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

if type 'zoxide' > /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd=z
fi

if [ -f /usr/share/nvm/init-nvm ]; then
  source /usr/share/nvm/init-nvm.sh
fi

if type 'lsd' > /dev/null; then
  alias ls=lsd
fi

if [ -r "$HOME/.opam/opam-init/init.sh" ]; then
  source "$HOME/.opam/opam-init/init.sh" > /dev/null 2> /dev/null
fi

if type 'mise' > /dev/null; then
  eval "$(mise activate zsh)"
fi

if type 'brew' > /dev/null; then
  export LDFLAGS="$LDFLAGS -L/opt/homebrew/lib"
  export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/include"
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/lib/pkgconfig"
fi

if type 'sccache' > /dev/null; then
  export RUSTC_WRAPPER=$(which sccache)
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then 
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

alias grep='grep --color=auto'
alias cp='cp -i'
alias mv='mv -i'
set rmstar
alias rm='echo "rm is disabled. Use trash or command rm instead."'

if type 'fzf' > /dev/null; then
  function select-history() {
    BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
  }
  zle -N select-history
  bindkey '^r' select-history
fi

function backup() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: backup <file>"
    return
  fi
  if [ ! -e "$1" ]; then
    echo "File not found: $1"
    return
  fi
  cp "$1" "$1.`date '+%Y%m%d-%H%M%S'`.bak"
}

function mk() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: mk <task>"
    return
  fi

  pushd ~/repo/dotfiles/makefile
  make "$1"
  popd
}

function ntfy() {
  if [ "$#" -ne 1 ]; then
    echo "Usage: ntfy <message>"
    return
  fi

  curl -u writer:writerpass -d "$1" https://ntfy.yuma14.net/main
}

agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
	case $SSH_AUTH_SOCK in
	/tmp/*/agent.[0-9]*)
		ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
	esac
elif [ -S $agent ]; then
	export SSH_AUTH_SOCK=$agent
fi
