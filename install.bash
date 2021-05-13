#!/usr/bin/env bash
set -x

APT_DEPS="clangd-9"

is_neovim_installed() {
  return command -v nvim &> /dev/null
}

is_nerdfonts_installed() {
  return $([ -d "$HOME"/.fonts ] && find $HOME/.fonts -name "JetBrains*Nerd Font*.ttf" | grep .)
}

is_rust_analyzer_installed() {
  return command -v rust-analyzer &> /dev/null
}

install_neovim() {
  wget "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage" -O /tmp/nvim
  sudo mv /tmp/nvim /usr/local/bin && sudo chmod +x /usr/local/bin/nvim
}

install_nerdfonts() {
  if [[ $? -eq 1 ]]; then
    mkdir -p $HOME/.fonts
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip" -O /tmp/JetBrainsMono.zip
    unzip /tmp/JetBrainsMono.zip -d $HOME/.fonts
  fi
}

install_rust_analyzer() {
    wget https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -O ~/.local/bin/rust-analyzer
    chmod +x ~/.local/bin/rust-analyzer
}


install() {
  sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    $APT_DEPS

  if [[ ! is_nerdfonts_installed -eq 0 ]]; then  install_nerdfonts; fi
  if [[ ! is_neovim_installed -eq 0 ]]; then  install_neovim; fi
  if [[ is_rust_analyzer_installed -eq 0 ]]; then  install_rust_analyzer; fi
}

install


