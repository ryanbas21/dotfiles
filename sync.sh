cp -r ./nvim ~/.config/

nvim --headless +PackerClean +qall
nvim --headless +PackerInstall +qall
