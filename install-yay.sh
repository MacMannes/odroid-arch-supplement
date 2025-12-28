#!/bin/bash

source ./colors.sh
source ./functions.sh

if which yay >/dev/null 2>&1; then
    msg "yay already installed"
else
    run sudo pacman -S --needed --noconfirm yay
fi

done_step
