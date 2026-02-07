# dotfiles

[![Neovim Benchmark](https://github.com/yuma140902/dotfiles-public/actions/workflows/nvim_bench.yml/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/nvim_bench.yml)
[![pages-build-deployment](https://github.com/yuma140902/dotfiles-public/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/pages/pages-build-deployment)
[![Dotfiles setup test](https://github.com/yuma140902/dotfiles-public/actions/workflows/tests.yml/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/tests.yml)

いろいろなアプリケーションの設定ファイルを管理しています。

## Install

まずリポジトリをクローンします。クローン先は `~/repos/dotfiles-public/` を推奨します。

```sh
git clone https://github.com/yuma140902/dotfiles-public ~/repos/dotfiles-public/
cd ~/repos/dotfiles-public
```

### Nix を使用しない方法

`./dotfiles` スクリプトを使用してアプリケーションごとに設定ファイルのインストールができます。
例えば Neovim の設定ファイルをインストールするには `./dotfiles install neovim` を実行します。
`./dotfiles` は設定ファイルの設置のみを行い、アプリケーション自体のインストールは行いません。

`./dotfiles install` を使って必要なモジュールをインストールします。
インストール可能なモジュールは `./dotfiles list` で確認できます。
Python 3 が必要です。

Mise を使ってツール類のインストールができます。まず `./dotfiles install mise` で mise の設定ファイルを設置し、`mise i` で設定ファイルをもとにインストールします。

### Nix を使用する方法

#### NixOS

```sh
sudo nixos-rebuild switch --flake .
```

または

```sh
sudo nixos-rebuild switch --flake '.#hostnamehogehoge'
```

#### Home Manager

```sh
home-manager switch --flake . --impure
```

ユーザ名とホームディレクトリは `$USER` と `$HOME` の値が使用されます。

## git の email, name の設定

`~/.gitconfig.private` に以下のような内容を書く。このファイルは git のメインの設定ファイルから読み込まれるように設定されている。

```
[user]
name = "hogehoge"
email = "hogehoge@example.com"
```

## ベンチマーク

GitHub Actions で Neovim のベンチマークを行っています。
ベンチマーク結果は <https://yuma14.net/dotfiles-public/> で見ることができます。

## 注意事項

### zsh-abbr

zsh-abbr は zsh 内で使える abbreviation を管理する zsh プラグインである。abbr コマンドを使ってユーザ定義の abbreviation を追加することができる。追加した abbreviation は ~/.config/zsh-abbr/user-abbreviations に保存される。

本リポジトリ dotfiles-public では、zsh モジュールをインストールすると zsh-abbr を使えるようになる。
dotfiles-public には user-abbreviations の定義も含まれていて、~/.config/zsh-abbr/user-abbreviations にシンボリックリンクが作られる。

本リポジトリから zsh モジュールをインストールした場合、abbr コマンドは使用すべきではない。abbr コマンドは user-abbreviations を削除してから新しい user-abbreviations ファイルを作るという動作をするので、シンボリックリンクではなくなってしまい git 管理から外れてしまうからである。


