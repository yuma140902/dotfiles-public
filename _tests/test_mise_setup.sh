#!/bin/bash

set -eux
set -o pipefail

# setup mise config
cd $HOME/repos/dotfiles-public/
./dotfiles install mise

# install mise
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash)"

# install mise tools
mise i --jobs=1
