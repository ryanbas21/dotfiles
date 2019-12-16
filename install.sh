# This is master commit

#!      zsh
command_exists() {    
  type "$1" > /dev/null 2>&1
}

# only perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\\n\\nRunning on OSX"
    echo -e "\\n\\nInstalling Brew...."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing Vim Plug."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp -r ./.tmux  ~/
cp ./.tmux.conf ~/

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    chsh -s "$(command -v zsh)"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
fi

echo "Moving .zshrc and .vimrc"
echo "source ~/dotfiles/zsh/.zshrc" >> ~/.zshrc
echo "source ~/dotfiles/nvim/.vimrc" >> ~/.vimrc

echo "move init vim to .config/nvim"
mkdir -p ~/.config/nvim

cp ./nvim/init.vim ~/.config/nvim/ 
cp ~/dotfiles/nvim/init.vim ~/.config/nvim/
cp ~/dotfiles/zsh/.profile ~/

echo "Brew installing....."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

brew install neovim 
brew install ripgrep
brew install fd
brew install bat
brew install python2
brew install python3
brew install diff-so-fancy
brew install powerlevel9k
brew install gpg-agent pinentry-mac
brew install htop
brew install wget
brew install watch
brew install go
brew install git
brew install watchman
brew install cask
brew install mysql
brew install openssl
brew install tmux
brew install postgresql
brew install hub
brew install graphviz
npm install -g madge
brew install jq
brew install jez/formulae/git-madge
brew install ghc
brew tap phinze/cask
brew install brew-cask
brew cask install --appdir="/Applications" spectacle
brew cask install cakebrew
brew cask install --appdir="/Applications" google-chrome
brew cask install --appdir="/Applications" alfred
brew cask install --appdir="~/Applications" iterm2
brew cask alfred link
brew cask install --appdir="/Applications" caffeine
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" 1password
brew cask install 1password-cli

npm instal yarn -g
npm install neovim -g

# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

reload

echo 'use-agent' >> ~/.gnupg/gpg.conf

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing vim plugins...."
vim +'PlugInstall --sync' +qa

echo "Installed vim plugins"
sh ./git/install.sh

echo "Installing Tmux Plugins"
~/.tmux/plugins/tpm/scripts/install_plugins.sh

echo "Done..."
