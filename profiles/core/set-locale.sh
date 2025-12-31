#!/usr/bin/env bash
set -euo pipefail

LOCALE="en_US.UTF-8"

# Check current system locale
current_locale=$(localectl status 2>/dev/null | grep "System Locale" || true)

if echo "$current_locale" | grep -q "$LOCALE"; then
    echo "Locale already set to $LOCALE"
    exit 0
fi

echo "Setting locale to $LOCALE..."

# Uncomment locale in /etc/locale.gen if needed
if ! grep -q "^$LOCALE UTF-8" /etc/locale.gen; then
    sed -i "s/^#\s*\($LOCALE UTF-8\)/\1/" /etc/locale.gen
    echo "Uncommented $LOCALE in /etc/locale.gen"
fi

# Generate locales
locale-gen

# Set system locale
echo "LANG=$LOCALE" > /etc/locale.conf

# Apply immediately (without reboot)
localectl set-locale LANG=$LOCALE

echo "Locale set to $LOCALE"

