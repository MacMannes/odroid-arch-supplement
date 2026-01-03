#!/bin/bash

source ${SOURCE_DIR}/colors.sh
source ${SOURCE_DIR}/functions.sh

SSHD_CONFIG="/etc/ssh/sshd_config"

if systemctl is-enabled sshd >/dev/null 2>&1 &&
    systemctl is-active sshd >/dev/null 2>&1; then
    msg "sshd already enabled and running"
    done_step
    exit 0
fi

msg "enabling and starting sshd"
run sudo systemctl enable sshd
run sudo systemctl start sshd

msg "configuring sshd"

# Backup once
if ! sudo test -f "${SSHD_CONFIG}.bak"; then
    run sudo cp "$SSHD_CONFIG" "${SSHD_CONFIG}.bak"
fi

run sudo sed -i \
    -e 's/^#\?PermitRootLogin.*/PermitRootLogin no/' \
    -e 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' \
    -e 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' \
    "$SSHD_CONFIG"

run sudo systemctl restart sshd

done_step
