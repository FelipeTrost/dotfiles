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
  cmd sudo dnf update -y
  echo ✅ dnf updated

  echo ... installing git alacritty zsh stow fzf make cmake gcc nodejs npm gh
  cmd sudo dnf install -y git alacritty zsh stow fzf make cmake gcc nodejs npm gh
  echo ✅ packages installed
else
  echo "Distro not supported :/"
  echo "going to proceed anyway ..."
fi

# =================================
# General config
# =================================
ssh-keygen
gh auth login
chsh -s $(which zsh) # Set default shell to zsh
git config --global init.defaultBranch main

echo "Using stow to symlink dotfiles"
stow .


# Install from source
mkdir ~/tools  2> /dev/null

# =================================
# Install neovim
# =================================
echo "... Installing neovim"
cd ~/tools
cmd git clone https://github.com/neovim/neovim.git
cd neovim
cmd git fetch --all
tag=$(git tag | fzf --header="-> NVIM version")
cmd git checkout "tags/$tag"
cmd make CMAKE_BUILD_TYPE=RelWithDebInfo
cmd sudo make install &> /dev/null 
echo "✅ Installed neovim"

# =================================
# Install Tmux
# =================================
echo "... Installing tmux"
cd ~/tools
cmd git clone https://github.com/tmux/tmux.git
cd tmux
cmd git fetch --all
tag=$(git tag | fzf --header="-> TMUX version")
cmd git checkout "tags/$tag"
cmd sh autogen.sh
cmd ./configure
cmd make
#plugins
cmd git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "✅ Installed tmux"

# =================================
# Install OhMyZsh
# =================================
echo "Installing oh-my-zsh"
cmd sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
cmd git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
cmd git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "✅ Installed oh-my-zsh"
