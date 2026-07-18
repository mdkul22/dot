#!/usr/bin/env bash

set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
backup_stamp="$(date +%Y%m%d-%H%M%S)"

link_dotfile() {
    local source=$1
    local target=$2

    mkdir -p "$(dirname "$target")"

    if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
        echo "Already linked: $target"
        return
    fi

    if [[ -e "$target" || -L "$target" ]]; then
        local backup="${target}.backup-${backup_stamp}"
        mv "$target" "$backup"
        echo "Backed up: $target -> $backup"
    fi

    ln -s "$source" "$target"
    echo "Linked: $target -> $source"
}

link_dotfile "$dotfiles_dir/.zshrc" "$HOME/.zshrc"
link_dotfile "$dotfiles_dir/.tmux.conf" "$HOME/.tmux.conf"
link_dotfile "$dotfiles_dir/.wezterm.lua" "$HOME/.wezterm.lua"
link_dotfile "$dotfiles_dir/.taskrc" "$HOME/.taskrc"
link_dotfile "$dotfiles_dir/nvim" "$HOME/.config/nvim"
link_dotfile "$dotfiles_dir/kitty.conf" "$HOME/.config/kitty/kitty.conf"
