path=(
  "$HOME/.local/share/mise/shims"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "$HOME/.volta/bin"
  "$HOME/.cabal/bin"
  "$HOME/.ghcup/bin"
  "$HOME/.lmstudio/bin"
  "/snap/bin"
  $path
)
typeset -U path PATH
path=($^path(N-/))
export PATH

if type 'sccache' > /dev/null; then
  export RUSTC_WRAPPER=$(which sccache)
fi

if type 'brew' > /dev/null; then
  export LDFLAGS="$LDFLAGS -L/opt/homebrew/lib"
  export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/include"
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/lib/pkgconfig"
  export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1
fi
