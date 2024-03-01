#!/bin/bash

verbose=false

cmd() {
  local command=("$@")

  if [ "$verbose" == true ]; then
    echo "Running command: ${command[*]}"
    "${command[@]}"
  else
    "${command[@]}" > /dev/null 2>&1
  fi
}

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
  echo "This script is only for Linux"
  exit 1
fi

source /etc/os-release # now ge can get the distro in #ID

if [[ "$ID" == "fedora" ]]; then
  echo ... running dnf update
  sudo dnf update -y 
  echo ✅ dnf updated

  echo ... installing git alacritty zsh stow fzf make cmake gcc nodejs npm gh
  sudo dnf install -y git alacritty zsh stow fzf make cmake gcc nodejs npm gh
  echo ✅ packages installed
else
  echo "Distro not supported :/"
  echo "going to proceed anyway ..."
fi

# =================================
# General config
# =================================
if [ ! -f ~/.ssh/id_rsa ]; then
  ssh-keygen
fi

if ! gh auth status >/dev/null 2>&1; then
    gh auth login
fi

git config --global init.defaultBranch main

mkdir -p ~/tools  

# =================================
# Install neovim
# =================================
echo "... Installing neovim"
cd ~/tools
cmd git clone https://github.com/neovim/neovim.git
cd neovim
cmd git fetch --all
tag=$(git tag | fzf --header="-> NVIM version (Ctl-C to skip)")
if [ -n "$tag" ]; then
  echo "Installing neovim version $tag"
  cmd git checkout "tags/$tag"
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  echo "✅ Installed neovim"
else
  echo "❌ Neovim Skipped"
fi

# =================================
# Install Tmux
# =================================
echo "... Installing tmux"
cd ~/tools
cmd git clone https://github.com/tmux/tmux.git
cd tmux
cmd git fetch --all
tag=$(git tag | fzf --header="-> TMUX version (Ctl-C to skip)")
if [ -n "$tag" ]; then
  echo "Installing tmux version $tag"
  cmd git checkout "tags/$tag"
  cmd sh autogen.sh
  cmd ./configure
  cmd make
  echo "✅ Installed tmux"
else
  echo "❌ tmux Skipped"
fi
#plugins
mkdir -p ~/.tmux/plugins/tpm
cmd git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# =================================
# Install OhMyZsh
# =================================
echo "... Installing oh-my-zsh"
cmd $(yes| sh -c "$(curl -fsSL https://install.ohmyz.sh/)")
cmd git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cmd git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
rm ~/.zshrc # remove file generated by ohmyzsh
echo "✅ Installed oh-my-zsh"

# =================================
# Install Nerdfonts
# =================================
echo "... Installing JetBrainsMono Nerd Font"
mkdir -p ~/.local/share/fonts/
cmd wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.tar.xz
cmd tar -xf JetBrainsMono.tar.xz -C ~/.local/share/fonts/
cmd rm /tmp/JetBrainsMono.tar.xz
cmd fc-cache -f # force font cache update
echo "✅ Installed JetBrainsMono Nerd Font"

# =================================
# Stow
# =================================
echo "... Using stow to symlink dotfiles"
stow .
echo "✅ Used stow to symlink dotfiles"


# =================================
# 🚀🚀🚀🚀🚀
# =================================

echo "Done! 🚀🚀"
