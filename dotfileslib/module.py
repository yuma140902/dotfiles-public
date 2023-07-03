import json
import platform
import pathlib
import os
import shutil
import datetime

class ModuleInfo:
    def __init__(self, dir_path):
        self.dir_path = dir_path
        self.manifest_json = (dir_path / "manifest.json").read_text(encoding="UTF-8")
        self.manifest = json.loads(self.manifest_json)
        
    def get_name(self):
        if "name" in self.manifest:
            return self.manifest["name"]
        return self.dir_path.name

    def get_description(self):
        if "description" in self.manifest:
            return self.manifest["description"]
        return None

    def get_notice(self):
        if "notice" in self.manifest:
            return self.manifest["notice"]
        return None

    def get_install_files(self):
        if "files" not in self.manifest:
            return []

        files = []
        for f in self.manifest["files"]:
            if type(f) == str:
                files.append(FileInstallation(f, f))
            elif "src" in f and "dst" in f:
                if "cond" not in f:
                    files.append(FileInstallation(f["src"], f["dst"]))
                elif condition_matches(f.cond):
                    files.append(FileInstallation(f["src"], f["dst"]))
            else:
                print("ignore " + str(f) + "")
        return files

    def install_files(self, allow_overwrite=False):
        files = self.get_install_files()
        all_ok = True
        for f in files:
            src = resolve_src_path(self.dir_path, f.src)
            dst = resolve_dst_path(f.dst)
            assert dst is not None
            print(str(dst) + " -> " + str(src))
            if not make_symlink(src, dst, allow_overwrite):
                all_ok = False
                print("failed")
        return all_ok


class FileInstallation:
    def __init__(self, src, dst):
        self.src = src
        self.dst = dst

def condition_matches(condition):
    return eval(condition, {"platform": platform})

def resolve_src_path(module_dir_path, src):
    return module_dir_path / src

def make_symlink(src, dst, allow_overwrite=False):
    if dst.exists():
        if not allow_overwrite:
            return False
        if dst.is_symlink():
            shutil.copyfile(dst, get_bak_path(dst), follow_symlinks=False)
            dst.unlink()
        else:
            shutil.move(dst, get_bak_path(dst))
        print("created backup file")
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.symlink_to(src, target_is_directory=src.is_dir())
    return True

def get_bak_path(path):
    name = path.name
    name_bak = name + "." + datetime.datetime.now().strftime("%Y%m%d%M%S") + ".bak"
    return path.parent / name_bak

home_path = pathlib.Path.home()
if platform.system() == "Windows":
    xdg_config_home = os.environ.get("XDG_CONFIG_HOME", os.environ["LOCALAPPDATA"])
    xdg_data_home = os.environ.get("XDG_DATA_HOME", os.environ["LOCALAPPDATA"])
    xdg_state_home = os.environ.get("XDG_STATE_HOME", os.environ["APPDATA"])
else:
    xdg_config_home = os.environ.get("XDG_CONFIG_HOME", "~/.config")
    xdg_data_home = os.environ.get("XDG_DATA_HOME", "~/.local/share")
    xdg_state_home = os.environ.get("XDG_STATE_HOME", "~/.local/state")
xdg_config_home_path = pathlib.Path(xdg_config_home).expanduser()
xdg_data_home_path = pathlib.Path(xdg_data_home).expanduser()
xdg_state_home_path = pathlib.Path(xdg_state_home).expanduser()

def resolve_dst_path(dst):
    if dst[0] != "$":
        dst = "${HOME}/" + dst
    if dst.startswith("${HOME}/"):
        dst = dst.lstrip("${HOME}/")
        return home_path / dst
    elif dst.startswith("${XDG_CONFIG_HOME}/"):
        dst = dst.lstrip("${XDG_CONFIG_HOME}/")
        return xdg_config_home_path / dst
    elif dst.startswith("${XDG_DATA_HOME}/"):
        dst = dst.lstrip("${XDG_DATA_HOME}/")
        return xdg_data_home_path / dst
    elif dst.startswith("${XDG_STATE_HOME}/"):
        dst = dst.lstrip("${XDG_STATE_HOME}/")
        return xdg_state_home_path / dst
    return None
    

def create_module_info(path):
    if (path / "manifest.json").is_file():
        return ModuleInfo(path)
    return None

