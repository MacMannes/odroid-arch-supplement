#!/bin/bash

ZPROFILE="$HOME/.zprofile"
SNIPPET="# Auto-start Hyprland on TTY1
if [ -z \"\$WAYLAND_DISPLAY\" ] && [ \"\$XDG_VTNR\" -eq 1 ]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=hyprland
    export XDG_CURRENT_DESKTOP=Hyprland

    export XDG_RUNTIME_DIR=\"/run/user/\$(id -u)\"
    mkdir -p \"\$XDG_RUNTIME_DIR\"
    chmod 700 \"\$XDG_RUNTIME_DIR\"

    exec uwsm start hyprland
fi
"

# Check if the snippet already exists
if grep -Fxq "if [ -z \"\$WAYLAND_DISPLAY\" ] && [ \"\$XDG_VTNR\" -eq 1 ]; then" "$ZPROFILE"; then
    echo ".zprofile already configured for Hyprland auto-start."
else
    echo "Configuring .zprofile to auto-start Hyprland..."
    # Backup current .zprofile
    cp "$ZPROFILE" "${ZPROFILE}.bak.$(date +%s)"
    echo "$SNIPPET" >> "$ZPROFILE"
    echo "Done! Backup saved as ${ZPROFILE}.bak.$(date +%s)"
fi

