# dotfiles

[![Neovim Benchmark](https://github.com/yuma140902/dotfiles-public/actions/workflows/nvim_bench.yml/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/nvim_bench.yml)
[![pages-build-deployment](https://github.com/yuma140902/dotfiles-public/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/pages/pages-build-deployment)

いろいろなアプリケーションの設定ファイルを管理しています。

## Install

まずリポジトリをクローンします。クローン先は自由です。

```sh
git clone https://github.com/yuma140902/dotfiles-public
cd dotfiles-public
```

### Nix を使用しない方法

`./dotfiles` スクリプトを使用してアプリケーションごとに設定ファイルのインストールができます。
例えば Neovim の設定ファイルをインストールするには `./dotfiles install neovim` を実行します。
`./dotfiles` は設定ファイルの設置のみを行い、アプリケーション自体のインストールは行いません。

`./dotfiles install` を使って必要なモジュールをインストールします。
インストール可能なモジュールは `./dotfiles list` で確認できます。
Python 3 が必要です。

### Nix を使用する方法

以下に示す場所に空のディレクトリが必要です。

```sh
mkdir -p /home/yuma/repos/nixfiles-private/
```

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
home-manager switch --flake .
```

または

```sh
home-manager switch --flake '.#usernamehogehoge'
```

## ベンチマーク

GitHub Actions で Neovim のベンチマークを行っています。
ベンチマーク結果は <https://yuma14.net/dotfiles-public/> で見ることができます。
