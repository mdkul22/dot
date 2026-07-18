#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
    PM="brew"
elif [[ -f /etc/debian_version ]]; then
    OS="linux"
    PM="apt"
else
    echo "Unsupported OS."
    exit 1
fi

echo "Detected OS: $OS"

# Install Homebrew on Linux if needed
if [[ "$OS" == "linux" && ! $(command -v brew) ]]; then
    echo "Installing Homebrew for Linux..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    PM="brew"
fi

# Install packages
install_pkg() {
    local command_name=$1
    local brew_package=${2:-$command_name}
    local apt_package=${3:-$brew_package}

    if ! command -v "$command_name" &>/dev/null; then
        echo "Installing $command_name..."
        if [[ "$PM" == "brew" ]]; then
            brew install "$brew_package"
        else
            sudo apt-get update
            sudo apt-get install -y "$apt_package"
        fi
    else
        echo "$command_name already installed."
    fi
}

install_pkg zsh
install_pkg tmux
install_pkg neovim
install_pkg ripgrep
install_pkg fzf
install_pkg bat
install_pkg eza
install_pkg task task taskwarrior

if [[ "$OS" == "mac" ]]; then
    install_pkg rem BRO3886/tap/rem-cli
fi

# WezTerm and zk are not always in default repos
if [[ "$PM" == "brew" ]]; then
    brew install wezterm || true
else
    # WezTerm
    if ! command -v wezterm &>/dev/null; then
        echo "Installing WezTerm..."
        wget https://github.com/wez/wezterm/releases/download/nightly/WezTerm-nightly.Ubuntu22.04.deb -O /tmp/wezterm.deb
        sudo apt install -y /tmp/wezterm.deb
    fi
fi

# Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]] || git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# Link dotfiles so edits in the live configuration and repository stay in sync.
"$SCRIPT_DIR/link-dotfiles.sh"

echo "Setup complete! Start using nvim, tmux, wezterm, and zsh."

# Optional: change default shell to zsh
if [[ "$SHELL" != *zsh ]]; then
    chsh -s "$(command -v zsh)"
    echo "Default shell changed to zsh. Please log out and log back in."
fi
