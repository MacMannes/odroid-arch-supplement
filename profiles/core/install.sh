#!/bin/bash

source ${ROOT_DIR}/colors.sh
source ${ROOT_DIR}/functions.sh

run ./set-shell.sh
run ./enable-elephant-service.sh
run sudo ./set-locale.sh
run ./setup-hyprland-autostart.sh
