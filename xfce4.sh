#!/bin/bash

# =============================================================================
# Debian 13 (Trixie) - XFCE4 Desktop Install Script
# =============================================================================
# HARDWARE:  Lenovo ThinkPad T480s
# REQUIRES:  bootstrap.sh completed first (sudo, apt no-recommends, updated)
# RUN AS:    sudo ./xfce4.sh
# =============================================================================

set -e

echo "=== XFCE4 Desktop Install for T480s ==="

# STEP 1: DRIVERS
echo "--- Installing firmware and input drivers..."
apt install -y firmware-iwlwifi
apt install -y xserver-xorg-input-libinput
echo "--- Drivers done"

# STEP 2: XORG
echo "--- Installing Xorg..."
apt install -y xorg xserver-xorg xinit
echo "--- Xorg done"

# STEP 3: XFCE4
echo "--- Installing XFCE4 core..."
apt install -y xfce4 xfce4-terminal xfce4-power-manager xfce4-notifyd
echo "--- XFCE4 done"

# STEP 4: LIGHTDM
echo "--- Installing LightDM..."
apt install -y lightdm lightdm-gtk-greeter
systemctl enable lightdm
echo "--- LightDM done"

# STEP 5: PIPEWIRE
echo "--- Installing PipeWire..."
apt install -y pipewire pipewire-pulse pipewire-alsa wireplumber pavucontrol
echo "--- PipeWire done"

# STEP 6: FONTS
echo "--- Installing fonts..."
apt install -y fonts-dejavu-core fonts-liberation
echo "--- Fonts done"

# STEP 7: BLUETOOTH
echo "--- Installing Bluetooth..."
apt install -y bluez blueman
systemctl enable bluetooth
echo "--- Bluetooth done"

echo ""
echo "=== Install complete ==="
echo ""
echo "NEXT STEPS:"
echo "  1. Reboot: sudo reboot"
echo "  2. LightDM login screen should appear"
echo "  3. Log in, select XFCE session"
echo "  4. WiFi: use nm-applet or nmtui in terminal"
echo "  5. Sound: run pavucontrol to verify PipeWire output"
echo ""
echo "OPTIONAL:"
echo "  apt install network-manager-gnome"
echo "  apt install thunar"
echo "  apt install mousepad"
echo "  apt install gvfs"
