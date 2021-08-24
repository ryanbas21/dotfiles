cp -r ./nvim ~/.config/

nvim --headless +PlugClean +qall
nvim --headless +PlugInstall +qall
