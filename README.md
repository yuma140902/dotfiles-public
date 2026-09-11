# dotfiles

[![Neovim Benchmark](https://github.com/yuma140902/dotfiles-public/actions/workflows/benchmark.yml/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/benchmark.yml)
[![Dotfiles setup test](https://github.com/yuma140902/dotfiles-public/actions/workflows/tests.yml/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/tests.yml)

## Requirements

- Python3

## Install

まずリポジトリをクローンする。クローン先は `~/repos/dotfiles-public/` 推奨。

```sh
git clone https://github.com/yuma140902/dotfiles-public ~/repos/dotfiles-public/
cd ~/repos/dotfiles-public
```

`./dotfiles` スクリプトを使用してアプリケーションごとに設定ファイルのインストールができる。
例えば Neovim の設定ファイルをインストールするには 

```sh
./dotfiles install neovim
```

を実行する。`./dotfiles` は設定ファイルの設置のみを行い、アプリケーション自体のインストールは行わない。

インストール可能なモジュールの一覧は `./dotfiles list` で確認できる。

## Mise

Mise を使ってツール類のインストールができる。まず

```sh
./dotfiles install mise
```

で mise の設定ファイルを設置する。そして、何らかの方法で mise 自体をインストールし、`mise i` で設定ファイルをもとにツール達をインストールする。

## 追加の設定

このリポジトリが提供している設定を微調整したり設定を追加したりしたい場合があると思うので、そのための方法を用意してある。

### git の email, name の設定

`~/.gitconfig.private` に以下のような内容を書く。このファイルは .gitconfig から読み込まれるように設定されている。

```gitconfig
[user]
name = "hogehoge"
email = "hogehoge@example.com"
```

### zsh

`$HOME/.include.zsh` を使用する。このスクリプトは .zshrc から source される。

## ベンチマーク

GitHub Actions で Neovim のベンチマークを行っている。
ベンチマーク結果は <https://dotfiles-benchmark-data.yuma140902-cloudflare.workers.dev/neovim/> で見ることができる。

## 注意事項

### zsh-abbr

zsh-abbr コマンドを使って `~/.config/zsh-abbr/user-abbreviations` を編集すると、シンボリックリンクが切れて新しいファイルが作られてしまう。
