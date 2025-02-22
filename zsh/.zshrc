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

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if type 'zoxide' > /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd=z
fi

export PATH=$PATH:~/.local/bin/:~/go/bin:~/.cargo/bin:~/.volta/bin:~/.cabal/bin:~/.ghcup/bin:/usr/local/texlive/2024/bin/x86_64-linux/

if [ -f /usr/share/nvm/init-nvm ]; then
  source /usr/share/nvm/init-nvm.sh
fi

if type 'lsd' > /dev/null; then
  abbr ls='lsd'
fi
alias grep='grep --color=auto'
alias cp='cp -i'
alias mv='mv -i'
set rmstar
alias rm='echo "rm is disabled. Use trash or command rm instead."'

function obs() {
  function help() {
    echo 'obs'
    echo 'Usage: obs'
    echo 'ObsidianのVaultをNeovimで開く'
    return
  }

  case $1 in
    -h|--help)
      help
      return
      ;;
  esac

  pushd ~/OneDrive/Obsidian/main
  nvim
  popd
}

if type 'fzf' > /dev/null; then
  function select-history() {
    BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
    CURSOR=$#BUFFER
  }
  zle -N select-history
  bindkey '^r' select-history
fi

function backup() {
  if [ $# -ne 1 ]; then
    echo "Usage: backup <file>"
    return
  fi
  if [ ! -e $1 ]; then
    echo "File not found: $1"
    return
  fi
  cp $1 $1.`date '+%Y%m%d-%H%M%S'`.bak
}

function mk() {
  if [ $# -ne 1 ]; then
    echo "Usage: mk <task>"
    return
  fi

  pushd ~/repo/dotfiles/makefile
  make $1
  popd
}

# opam configuration
[[ ! -r /home/yuma/.opam/opam-init/init.zsh ]] || source /home/yuma/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

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
