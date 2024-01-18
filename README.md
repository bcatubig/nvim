# nvim

### Installation

Requirements:

- Make sure to review the readmes of the plugins if you are experiencing errors. In particular:
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
- See [Windows Installation](#windows-installation) if you have trouble with `telescope-fzf-native`
- `wl-clipboard` or `xclip` for clipboard to work

Neovim's configurations are located under the following paths, depending on your OS:

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux                | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| MacOS                | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%userprofile%\AppData\Local\nvim\`       |
| Windows (powershell) | `$env:USERPROFILE\AppData\Local\nvim\`    |

Clone kickstart.nvim:

```sh
# on Linux and Mac
git clone https://github.com/bcatubig/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

```
# on Windows (cmd)
git clone https://github.com/bcatubig/kickstart.nvim.git %userprofile%\AppData\Local\nvim\
```

```
# on Windows (powershell)
git clone https://github.com/bcatubig/kickstart.nvim.git $env:USERPROFILE\AppData\Local\nvim\
```

### Ubuntu Installation

```shell
# Install from source
cd /tmp && \
  wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
  tar -xzf nvim-linux64.tar.gz -C /usr/local --strip-components=1
```

```shell
# Install Packages
sudo apt update && sudo apt -y install \
  cargo \
  python3 \
  python3-venv \
  golang \
  npm \
  nodejs \
  ripgrep \
  fd-find \
  unzip
```

### Arch Linux Installation

```shell
yay -Syyu
```

### Windows Installation

Installation may require installing build tools, and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake, and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
