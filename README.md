# dotfiles

## インストール方法

```sh
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
  -p PATH, --path PATH  探索パス. デフォルト: "."
[root@a1226d165c99 app]# ./dotfiles list --help
usage: dotfiles list [-h] [-p PATH]

options:
  -h, --help            show this help message and exit
  -p PATH, --path PATH  探索パス. デフォルト: "."

> ./dotfiles info --help
usage: dotfiles info [-h] MODULE

positional arguments:
  MODULE

options:
  -h, --help  show this help message and exit
```
