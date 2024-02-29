#!/bin/bash

if [ ! -e ~/dotfiles ]; then
  git clone https://github.com/FelipeTrost/dotfiles.git ~/dotfiles/
fi

cd ~/dotfiles

./setup.sh
