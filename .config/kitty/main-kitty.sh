#! /bin/bash

if [ ! -e /tmp/kitty ]; then
    kitty -o hide_window_decorations=true  -o allow_remote_control=yes --listen-on unix:/tmp/kitty
fi
