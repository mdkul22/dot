# Dotfiles Setup

This repository contains configuration files and a setup script to quickly bootstrap your development environment on a new macOS or Linux system.
It includes configs for:
- **Neovim**
- **WezTerm**
- **tmux**
- **zsh** (with Oh My Zsh, plugins, and Powerlevel10k theme)
- Useful CLI tools (fzf, ripgrep, bat, eza, taskwarrior, timewarrior, zk)

---

## Features

- **Automated setup**: Run a single script to install all dependencies and set up your environment.
- **Custom configurations**: Pre-configured dotfiles for zsh, tmux, wezterm, and neovim.
- **Plugin management**: Installs Oh My Zsh, Powerlevel10k, and useful zsh plugins.
- **Cross-platform**: Works on macOS and Debian-based Linux systems.

---

## Quick Start

1. **Clone this repository:**

   ```bash
   git clone https://github.com/yourusername/dot.git ~/dot
   cd ~/dot
   ```

2. **Run the setup script:**

   ```bash
   bash setup.sh
   ```

   The script will:
   - Detect your OS and use the appropriate package manager (`brew` or `apt`)
   - Install required packages if missing
   - Install Oh My Zsh, plugins, and Powerlevel10k theme
   - Copy `.zshrc`, `.tmux.conf`, `.wezterm.lua` to your home directory
   - Copy the `nvim` config to `~/.config/nvim`
   - Initialize a `zk` notes directory
   - Optionally set your default shell to zsh

---

## File Overview

- [`setup.sh`](setup.sh): Main setup script for installing packages and copying configs.
- [`.zshrc`](.zshrc): zsh configuration with Oh My Zsh, plugins, Powerlevel10k, and custom aliases/functions.
- [`.tmux.conf`](.tmux.conf): tmux configuration with custom keybindings and mouse support.
- [`.wezterm.lua`](.wezterm.lua): WezTerm terminal emulator configuration.
- `nvim/`: Neovim configuration directory (copy to `~/.config/nvim`).

---

## Requirements

- macOS or a Debian-based Linux system
- `git` installed
- For Linux: `sudo` privileges for installing packages

---

## Customization

- Edit the dotfiles (`.zshrc`, `.tmux.conf`, `.wezterm.lua`, `nvim/`) as you like before or after running the script.
- The script is idempotent and safe to re-run.

---

## Notes

- For WezTerm and zk, the script uses Homebrew on macOS and Linux if available, or downloads/installers for Linux.
- If you want to use a different package manager or OS, you may need to adapt the script.
- After running, log out and log back in to activate zsh as your default shell if prompted.

---


---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.


