# dotfiles

[![Neovim Benchmark](https://github.com/yuma140902/dotfiles-public/actions/workflows/nvim_bench.yml/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/nvim_bench.yml)
[![pages-build-deployment](https://github.com/yuma140902/dotfiles-public/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/yuma140902/dotfiles-public/actions/workflows/pages/pages-build-deployment)

いろいろなアプリケーションの設定ファイルを管理しています。
`./dotfiles` スクリプトを使用してアプリケーションごとに設定ファイルのインストールを行うことができます。
例えば Neovim の設定ファイルをインストールするには `./dotfiles install neovim` を実行します。

`./dotfiles` は設定ファイルの設置のみを行い、アプリケーション自体のインストールは行いません。つまり、`apt install` や `pacman -S` を自動で実行することはありません。
アプリケーション自体のインストールは `./dotfiles install` とは別に各パッケージマネージャを使って行う必要があります。

## 動作環境

- OS
  - Linux
  - Windows
  - macOS
- Python 3

## 使用方法

まずリポジトリをクローンします。クローン先は自由です。

```sh
git clone https://github.com/yuma140902/dotfiles-public
cd dotfiles-public
```

次に `./dotfiles` を使って必要なモジュールをインストールします。

```
> ./dotfiles --help
usage: dotfiles [-h] [-y] [-v] {install,list,info} ...

options:
  -h, --help           show this help message and exit
  -y, --noconfirm      ユーザーに入力を求めない
  -v, --version        show program's version number and exit

Sub Commands:
  {install,list,info}
    install            モジュールをインストールする
    list               モジュールを一覧表示する
    info               モジュールの情報を表示する

> ./dotfiles install --help
usage: dotfiles install [-h] [-f] [-a] [-p PATH] [MODULE ...]

positional arguments:
  MODULE                インストールするモジュールの名前

options:
  -h, --help            show this help message and exit
  -f, --allow-overwrite
                        設定ファイル等の上書きを許可する。上書きされたファイルは"元のファイル名.日時.bak"などの名前で残される
  -a, --all             すべてのモジュールをインストールする
  -p PATH, --path PATH  --allが指定されたときの探索パス. デフォルト: "."

> ./dotfiles list --help
usage: dotfiles list [-h] [-p PATH]

options:
  -h, --help            show this help message and exit
  -p PATH, --path PATH  --allが指定されたときの探索パス. デフォルト: "."

> ./dotfiles info --help
usage: dotfiles info [-h] MODULE

positional arguments:
  MODULE

options:
  -h, --help  show this help message and exit
```

## ベンチマーク

GitHub Actions で Neovim のベンチマークを行っています。
ベンチマーク結果は <https://yuma14.net/dotfiles-public/> で見ることができます。
