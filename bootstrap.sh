#!/bin/bash

# =============================================================================
# Debian 13 (Trixie) - XFCE4 Desktop Install Script
# =============================================================================
# HARDWARE:  Lenovo ThinkPad T480s
# REQUIRES:  bootstrap.sh completed first (sudo, apt no-recommends, updated)
# RUN AS:    sudo ./xfce4.sh
# =============================================================================

set -e

USERNAME="daopi"

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

# STEP 8: NETWORK MANAGER APPLET
echo "--- Installing NetworkManager applet..."
apt install -y network-manager-gnome
echo "--- NetworkManager applet done"
echo "--- Configuring nm-applet autostart..."
mkdir -p /home/$USERNAME/.config/autostart
cat > /home/$USERNAME/.config/autostart/nm-applet.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Network Manager Applet
Exec=nm-applet
NoDisplay=false
X-GNOME-Autostart-enabled=true
EOF
chown -R $USERNAME:$USERNAME /home/$USERNAME/.config/autostart
echo "--- nm-applet autostart done"

# STEP 9: BACKLIGHT FIX
echo "--- Fixing backlight permissions..."
cat > /etc/udev/rules.d/90-backlight.rules << 'EOF'
ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
EOF
usermod -aG video $USERNAME
apt install -y pkexec
apt install smbclient
echo "--- Backlight fix done"

# STEP 10: CHROMIUM
echo "--- Installing Chromium..."
apt install -y chromium
echo "--- Chromium done"

echo ""
echo "=== Install complete ==="
echo ""
echo "NEXT STEPS:"
echo "  1. Reboot: sudo reboot"
echo "  2. LightDM login screen should appear"
echo "  3. Log in, select XFCE session"
echo "  4. WiFi: nm-applet starts automatically in tray"
echo "  5. Sound: run pavucontrol to verify PipeWire output"
echo "  6. After first login run:"
echo "     systemctl --user enable --now pipewire pipewire-pulse wireplumber"
