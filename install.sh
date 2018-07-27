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
    chsh -s "$(which zsh)"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
fi

echo "Moving .zshrc and .vimrc"
echo "source ~/dotfiles/zsh/.zshrc" >> ~/.zshrc
echo "source ~/dotfiles/nvim/.vimrc" >> ~/.vimrc
mkdir .config/nvim
cp ~/dotfiles/zsh/init.vim .config/nvim/

echo "Restarting terminal"
echo "Brew installing....."
echo "Brewing ripgrep"
brew install neovim
brew install ripgrep
brew install fd
brew install bat
brew install python3
brew install diff-so-fancy
brew install powerlevel9k

echo "Installing vim plugins...."
vim +'PlugInstall --sync' +qa
echo "Installed vim plugins"
echo "Done..."
