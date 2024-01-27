#!/bin/zsh

if [[$1 == "new"]]
    echo "This is only for OSX systems!"
    echo "Make sure oh-my-zsh and zsh are in system alongside iTerm"
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
    mkdir ~/.config

cp -r ./nvim ~/.config/.
echo "start using vi!"

