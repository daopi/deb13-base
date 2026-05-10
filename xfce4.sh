#!/bin/bash

# =============================================================================

# Debian 13 (Trixie) - XFCE4 Desktop Install Script

# =============================================================================

# HARDWARE:  Lenovo ThinkPad T480s

# REQUIRES:  bootstrap.sh completed first (sudo, apt no-recommends, updated)

# RUN AS:    sudo ./xfce4.sh

# =============================================================================

set -e

echo “=== XFCE4 Desktop Install for T480s ===”

# =============================================================================

# STEP 1: DRIVERS - WiFi, Bluetooth, Trackpad

# =============================================================================

echo “>>> Installing firmware and input drivers…”

# Intel 8265 WiFi + Bluetooth firmware (same package covers both)

apt install -y firmware-iwlwifi

# Trackpad - libinput (X11 driver)

apt install -y xserver-xorg-input-libinput

echo “>>> Drivers installed”

# =============================================================================

# STEP 2: XORG (X11 display server)

# =============================================================================

echo “>>> Installing Xorg…”

apt install -y   
xorg   
xserver-xorg   
xinit

echo “>>> Xorg installed”

# =============================================================================

# STEP 3: XFCE4 (lean - no plugins bloat)

# =============================================================================

echo “>>> Installing XFCE4 core…”

apt install -y   
xfce4   
xfce4-terminal   
xfce4-power-manager   
xfce4-notifyd

# Skip: xfce4-goodies (bloat), xfce4-screensaver, unnecessary plugins

echo “>>> XFCE4 installed”

# =============================================================================

# STEP 4: DISPLAY MANAGER - LightDM

# =============================================================================

echo “>>> Installing LightDM…”

apt install -y   
lightdm   
lightdm-gtk-greeter

# Enable LightDM at boot

systemctl enable lightdm

echo “>>> LightDM installed and enabled”

# =============================================================================

# STEP 5: SOUND - PipeWire

# =============================================================================

echo “>>> Installing PipeWire…”

apt install -y   
pipewire   
pipewire-pulse   
pipewire-alsa   
wireplumber   
pavucontrol

# NOTE: PipeWire is user-session based, no systemctl enable needed.

# It starts automatically via systemd user session.

# pavucontrol = GUI volume control app

echo “>>> PipeWire installed”

# =============================================================================

# STEP 6: FONTS (minimum usable set)

# =============================================================================

echo “>>> Installing base fonts…”

apt install -y   
fonts-dejavu-core   
fonts-liberation

echo “>>> Fonts installed”

# =============================================================================

# STEP 7: BLUETOOTH STACK

# =============================================================================

echo “>>> Installing Bluetooth…”

apt install -y   
bluez   
blueman

# bluez  = Bluetooth daemon

# blueman = GUI manager (XFCE-friendly)

systemctl enable bluetooth

echo “>>> Bluetooth installed and enabled”

# =============================================================================

# DONE

# =============================================================================

echo “”
echo “=== Install complete ===”
echo “”
echo “NEXT STEPS:”
echo “  1. Reboot: sudo reboot”
echo “  2. LightDM login screen should appear”
echo “  3. Log in -> XFCE4 desktop”
echo “  4. WiFi: use NetworkManager applet (nm-applet) or nmtui in terminal”
echo “  5. Sound: run pavucontrol to verify PipeWire output”
echo “”
echo “OPTIONAL (install later if needed):”
echo “  apt install network-manager-gnome   # nm-applet tray icon for WiFi”
echo “  apt install thunar                  # file manager”
echo “  apt install mousepad                # text editor”
echo “  apt install gvfs                    # USB/MTP mounting support”