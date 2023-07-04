import argparse
import sys

from . import commands

if __name__ == '__main__':
    sys.path.append("./commands")
    parser = argparse.ArgumentParser(prog="dotfiles")
    parser.add_argument("-y", "--noconfirm", action="store_true",
                        help="ユーザーに入力を求めない")
    parser.add_argument("-v", "--version", action="version", version='%(prog)s 0.1.0')
    sub_parsers = parser.add_subparsers(title="Sub Commands", dest="subcmd")

    parser_install = sub_parsers.add_parser("install", help="モジュールをインストールする")
    parser_install.add_argument("module", metavar="MODULE", nargs="*",
                                help="インストールするモジュールの名前")
    parser_install.add_argument("-f", "--allow-overwrite", action="store_true", 
                                help="設定ファイル等の上書きを許可する。上書きされたファイルは\"元のファイル名.日時.bak\"などの名前で残される")
    parser_install.add_argument("-a", "--all", action="store_true",
                                help="すべてのモジュールをインストールする")
    parser_install.add_argument("-p", "--path", default=".",
                             help="--allが指定されたときの探索パス. デフォルト: \".\"")

    parser_list = sub_parsers.add_parser("list", help="モジュールを一覧表示する")
    parser_list.add_argument("-p", "--path", default=".",
                             help="--allが指定されたときの探索パス. デフォルト: \".\"")

    parser_info = sub_parsers.add_parser("info", help="モジュールの情報を表示する")
    parser_info.add_argument("module", metavar="MODULE")

    args = parser.parse_args()


    if args.subcmd == "install":
        commands.install(args)
    elif args.subcmd == "list":
        commands.list(args)
    elif args.subcmd == "info":
        commands.info(args)
    else:
        parser.print_help()
        sys.exit(1)
