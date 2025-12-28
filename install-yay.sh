#!/bin/bash

source ./colors.sh
source ./functions.sh

if which yay >/dev/null 2>&1; then
    msg "yay already installed"
else
    run sudo pacman -S --needed base-devel git
    run sudo pacman -S --needed git base-devel
    run pushd ~
    run git clone https://aur.archlinux.org/yay.git
    run cd yay
    run makepkg -si
    run popd
fi

done_step
