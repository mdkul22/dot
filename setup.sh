#!/bin/zsh

if [[$1 == "new"]]
    echo "This is only for OSX systems!"
    echo "Make sure oh-my-zsh and zsh are in system alongside wez"
    brew install zsh 
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    cp .zshrc ~/.zshrc
    brew install tmux
    cp .tmux.conf ~/.tmux.conf
    source ~/.zshrc
    p10k configure
    brew uninstall ctags
    brew install universal-ctags
    brew install ripgrep fzf
    brew install neovim
    brew install wezterm
    brew install zk
    brew install bat
    brew install eza
    brew install taskwarrior timewarrior
    cp .wezterm.lua ~
    curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
    curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash -s -- --branch=release-0.1
    mkdir ~/.config
    cd ~
    zk init notes

cp -r ./nvim ~/.config/.
echo "start using vi!"

