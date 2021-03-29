

echo Symlinking NeoVim configuration...
ln -s $(pwd)/.config/nvim $HOME/.config/nvim 
echo Done
echo Symlinking Tmux configuration
ln -s $(pwd)/.tmux.conf $HOME/.tmux.conf
