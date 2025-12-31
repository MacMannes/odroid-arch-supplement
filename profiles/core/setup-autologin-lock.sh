#!/bin/bash
set -e

USER_NAME="$(whoami)"

echo "==> Configuring TTY1 auto-login"

GETTY_DIR="/etc/systemd/system/getty@tty1.service.d"
GETTY_CONF="$GETTY_DIR/override.conf"

sudo mkdir -p "$GETTY_DIR"

if [ -f "$GETTY_CONF" ]; then
    sudo cp "$GETTY_CONF" "$GETTY_CONF.bak.$(date +%s)"
fi

sudo tee "$GETTY_CONF" >/dev/null <<EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER_NAME --noclear %I \$TERM
EOF

sudo systemctl daemon-reexec

echo "✅ Setup auto-login complete. Make sure to reboot after everything is done"

