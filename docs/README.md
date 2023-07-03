# ドキュメント

## `manifest.json`の書き方

### 例1

`${HOME}/.zshrc`から`dotfiles/zsh/.zshrc`へのリンクを作る。

ディレクトリ構造:

- dotfiles/zsh/
  - manifest.json
  - .zshrc

manifest.json

```json
{
    "name": "zsh",
    "description": "...",
    "files": [
        ".zshrc"
    ]
}
```

### 例2

- dotfiles/neovim/
  - manifest.json
  - nvim/
    - init.lua
    - lua/
      - ...
    - ftplugin
      - ...

```json
{
    "name": "Neovim",
    "files": [
        {
            "src": "nvim",
            "dst": "${XDG_CONFIG_HOME}/nvim"
        }
    ]
}
```

### 例3

- dotfiles/git
  - .gitconfig.linux
  - .gitconfig.windows

```json
{
    "name": "Git",
    "files": [
        {
            "cond": "platform.system() in ('Linux', 'Darwin')",
            "src": ".gitconfig.linux",
            "dst": ".gitconfig"
        },
        {
            "cond": "platform.system() == 'Windows'",
            "src": ".gitconfig.windows",
            "dst": ".gitconfig"
        }
    ]
}
```

### `cond`について

`cond`はbool値を返すPythonコードを書くことができる。`platform`モジュールを使うことができる。

### `dest`で使える変数について

`dest`の先頭でのみ、以下の変数を使うことができる。

- `${HOME}` - ユーザーのホームディレクトリ
- `${XDG_CONFIG_HOME}` - `XDG_CONFIG_HOME`環境変数。デフォルト値は`${HOME}/.config`または`%LOCALAPPDATA%`。
- `${XDG_DATA_HOME}` - `XDG_DATA_HOME`環境変数。デフォルト値は`${HOME}/.local/share`または`%LOCALAPPDATA%`。
- `${XDG_STATE_HOME}` - `XDG_STATE_HOME`環境変数。デフォルト値は`${HOME}/.local/state`または`%APPDATA%`。
