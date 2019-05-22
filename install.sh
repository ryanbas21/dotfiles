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

echo "move init vim to .config/nvim"
cp ./nvim/init.vim ~/.config/nvim/ 

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
mkdir .config/nvim
cp ~/dotfiles/zsh/init.vim ~/.config/nvim/
cp ~/dotfiles/zsh/.profile ~/

echo "Restarting terminal"
echo "Brew installing....."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
brew install neovim --HEAD
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

# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*
reload

echo 'use-agent' >> ~/.gnupg/gpg.conf

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing vim plugins...."
vim +'PlugInstall --sync' +qa
nvim +'CocInstall coc-tsserver coc-json coc-css coc-html coc-jest coc-emmet coc-tslint-plugin coc-eslint coc-prettier coc-yaml coc-yank coc-git coc-python coc-snippets coc-lists coc-dictionary coc-omni coc-ultisnips coc-syntax' +qa
nvim +'CocInstall https://github.com/andys8/vscode-jest-snippets#master' +qa
nvim +'CocInstall https://github.com/xabikos/vscode-react#master' +qa
echo "Installed vim plugins"
echo "Done..."
