#!/usr/bin/env bash

source ${ROOT_DIR}/colors.sh
source ${ROOT_DIR}/functions.sh

set -euo pipefail

CHANGES_MADE=0

msg "🔍 Checking Avahi configuration..."

# 1. Check hostname
HOSTNAME=""

if [[ -f /etc/hostname ]]; then
    HOSTNAME="$(tr -d ' \t\n' </etc/hostname)"
fi

if [[ -z "$HOSTNAME" ]]; then
    HOSTNAME="$(hostnamectl --static 2>/dev/null || true)"
fi

if [[ -z "$HOSTNAME" || "$HOSTNAME" == "localhost" ]]; then
    msg "❌ Hostname is not properly set."
    msg "   Set a hostname with:"
    msg "     sudo hostnamectl set-hostname <name>"
    exit 1
else
    msg "✔ Hostname set to '$HOSTNAME'"
fi

# 2. Check nss-mdns in nsswitch.conf
if grep -qE '^hosts:.*mdns' /etc/nsswitch.conf; then
    msg "✔ nss-mdns already configured in /etc/nsswitch.conf"
else
    msg "🛠 Adding mdns to /etc/nsswitch.conf"
    sudo sed -i \
        's/^hosts:\(.*\)resolve\(.*\)$/hosts:\1mdns_minimal [NOTFOUND=return] resolve\2/' \
        /etc/nsswitch.conf
    CHANGES_MADE=1
fi

# 3. Enable avahi-daemon
if systemctl is-enabled avahi-daemon &>/dev/null; then
    msg "✔ avahi-daemon already enabled"
else
    msg "🛠 Enabling avahi-daemon"
    run sudo systemctl enable avahi-daemon
    CHANGES_MADE=1
fi

# 4. Start avahi-daemon
if systemctl is-active avahi-daemon &>/dev/null; then
    msg "✔ avahi-daemon already running"
else
    msg "🛠 Starting avahi-daemon"
    run sudo systemctl start avahi-daemon
    CHANGES_MADE=1
fi

# 5. Final result
if [[ "$CHANGES_MADE" -eq 0 ]]; then
    msg "✅ Avahi already configured — nothing to do."
    exit 0
else
    msg "🎉 Avahi configuration completed."
    msg "   You should now be able to access:"
    msg "     ${HOSTNAME}.local"
fi
