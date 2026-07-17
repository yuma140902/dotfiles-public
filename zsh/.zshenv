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
