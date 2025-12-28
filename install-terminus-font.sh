#!/bin/bash

source ./colors.sh
source ./functions.sh

FONT_NAME="ter-p32n"
VCONSOLE_CONF="/etc/vconsole.conf"

# Check if FONT is already set correctly
if grep -q "^FONT=$FONT_NAME\$" "$VCONSOLE_CONF"; then
  msg "Console font already set to $FONT_NAME"
  exit 0
fi

# If FONT exists but is different, replace it
if grep -q "^FONT=" "$VCONSOLE_CONF"; then
  msg "Updating console font to $FONT_NAME"
  run sudo sed -i "s/^FONT=.*/FONT=$FONT_NAME/" "$VCONSOLE_CONF"
else
  msg "Adding console font $FONT_NAME"
  run sudo echo "FONT=$FONT_NAME" >> "$VCONSOLE_CONF"
fi

run sudo systemctl restart systemd-vconsole-setup

done_step
