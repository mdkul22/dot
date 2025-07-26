#!/usr/bin/env bash

set -e

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
if [[ -n "$TEST_MODE" ]]; then
    echo "Test mode: skipping installation."
    exit 0
fi


# Install Homebrew on Linux if needed
if [[ "$OS" == "linux" && ! $(command -v brew) ]]; then
    echo "Installing Homebrew for Linux..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    PM="brew"
fi

# Install packages
install_pkg() {
    if ! command -v "$1" &>/dev/null; then
        echo "Installing $1..."
        if [[ "$PM" == "brew" ]]; then
            brew install "$1"
        else
            sudo apt-get update
            sudo apt-get install -y "$1"
        fi
    else
        echo "$1 already installed."
    fi
}

install_pkg zsh
install_pkg tmux
install_pkg neovim
install_pkg ripgrep
install_pkg fzf
install_pkg bat
install_pkg eza
install_pkg taskwarrior
install_pkg timewarrior

# WezTerm and zk are not always in default repos
if [[ "$PM" == "brew" ]]; then
    brew install wezterm || true
    brew install zk || true
else
    # WezTerm
    if ! command -v wezterm &>/dev/null; then
        echo "Installing WezTerm..."
        wget https://github.com/wez/wezterm/releases/download/nightly/WezTerm-nightly.Ubuntu22.04.deb -O /tmp/wezterm.deb
        sudo apt install -y /tmp/wezterm.deb
    fi
    # zk
    if ! command -v zk &>/dev/null; then
        echo "Installing zk..."
        curl -s https://raw.githubusercontent.com/mickael-menu/zk/master/install.sh | bash
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

# Copy dotfiles
cp -v .zshrc ~/.zshrc
cp -v .tmux.conf ~/.tmux.conf
cp -v .wezterm.lua ~/.wezterm.lua

# Neovim config
mkdir -p ~/.config
cp -rv ./nvim ~/.config/

# ZK init
cd ~
zk init notes || true

echo "Setup complete! Start using nvim, tmux, wezterm, and zsh."

# Optional: change default shell to zsh
if [[ "$SHELL" != *zsh ]]; then
    chsh -s "$(command -v zsh)"
    echo "Default shell changed to zsh. Please log out and log back in."
fi

