#!/bin/bash

source ./colors.sh
source ./functions.sh

if which gum >/dev/null 2>&1; then
    msg "gum already installed"
else
    msg "installing gum"
    run pacman -S --needed --noconfirm gum
fi

done_step
