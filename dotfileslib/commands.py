import pathlib
import sys

from . import module

def install(args):
    allow_overwrite = args.allow_overwrite
    modules = []
    if args.all:
        modules = get_list_of_all_modules()
    else:
        for name in args.module:
            mod = module.create_module_info(pathlib.Path.cwd() / name)
            if mod is not None:
                modules.append(mod)

    all_ok = False
    for mod in modules:
        print("Installing " + mod.get_name())
        if not mod.install_files(allow_overwrite=allow_overwrite):
            all_ok = False

    if not all_ok:
        sys.exit(1)


def list(args):
    modules = get_list_of_all_modules()
    for mod in modules:
        print(module_to_oneline(mod))

def info(args):
    cwd = pathlib.Path.cwd()
    mod = module.create_module_info(cwd / args.module)
    if mod is None:
        print("not found")
        sys.exit(1)
    print_module(mod)

def get_list_of_all_modules():
    cwd = pathlib.Path.cwd()
    lst = []
    for dir in cwd.iterdir():
        module_info = module.create_module_info(dir)
        if module_info is not None:
            lst.append(module_info)
    return lst

def module_to_oneline(module_info):
    name = module_info.get_name()
    desc = module_info.get_description()
    if desc is None:
        return name
    else:
        return name + " - " + desc.replace("\r\n", " ").replace("\n", " ")

def print_module(module_info):
    name = module_info.get_name()
    desc = module_info.get_description()
    files = module_info.get_install_files()
    notice = module_info.get_notice()

    print("-" * max(len(name), 10))
    print(name)
    print("-" * max(len(name), 10))
    print(desc)
    print("Files:")
    for f in files:
        print(f.dst + " -> " + f.src)
    print("-" * max(len(name), 10))
    print(notice)
    print("-" * max(len(name), 10))
