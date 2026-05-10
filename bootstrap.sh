#!/bin/bash

# =============================================================================

# Debian 13 (Trixie) - ThinkPad T480s Bootstrap Script

# =============================================================================

# GOAL: Minimal Debian install + lean desktop, no bloat

# HARDWARE: Lenovo ThinkPad T480s

# 

# HOW TO USE:

# 1. Install Debian 13 netinstall (deselect ALL in software selection)

# - Keep: “standard system utilities”

# - Skip: “Debian desktop environment”, blends, everything else

# 2. Boot to shell, login as root

# 3. Run this script as root, or with sudo after step 2 below

# 

# STATUS: Work in progress - desktop not chosen yet

# =============================================================================

set -e  # Stop on any error

echo “=== Debian 13 T480s Bootstrap ===”

# =============================================================================

# STEP 1: SUDO

# =============================================================================

# Install sudo (not present in minimal install)

# Then add your user to sudo group

# NOTE: Logout and login again after this for sudo to take effect

apt install sudo

# Replace ‘daopi’ with your actual username

USERNAME=“daopi”
usermod -aG sudo “$USERNAME”

echo “>>> Sudo installed. LOGOUT and LOGIN as $USERNAME before continuing.”
echo “>>> Then run the rest of this script with sudo.”

# =============================================================================

# STEP 2: APT - NO RECOMMENDS / NO SUGGESTS

# =============================================================================

# This makes ALL future apt installs lean by default

# File: /etc/apt/apt.conf.d/99norecommends

cat > /etc/apt/apt.conf.d/99norecommends << ‘EOF’
APT::Install-Recommends “false”;
APT::Install-Suggests “false”;
EOF

echo “>>> APT configured: no recommends, no suggests”

# =============================================================================

# STEP 3: UPDATE SYSTEM

# =============================================================================

apt update && apt upgrade -y

echo “>>> System updated”

# =============================================================================

# STEP 4: BASE TOOLS (optional but useful)

# =============================================================================

# Uncomment what you want

# apt install git curl wget        # basic download/version control tools

# apt install htop                 # better process monitor than top

# apt install nano vim             # text editors (pick one)

# apt install net-tools            # ifconfig, netstat etc

# apt install bash-completion      # tab completion in bash

# =============================================================================

# STEP 5: DRIVERS - ThinkPad T480s specific

# =============================================================================

# WiFi: Intel 8265 - firmware needed

# Bluetooth: Intel - same firmware package covers it

# Trackpad: works out of box with libinput

# Fingerprint: fprint + fprintd (optional)

# Non-free firmware repo - needed for Intel WiFi

# TODO: check if already enabled in /etc/apt/sources.list

# apt install firmware-iwlwifi     # Intel WiFi + BT firmware

# apt install libinput-tools       # trackpad (usually already present)

# apt install fprintd libfprint-2-tod1  # fingerprint (optional)

# =============================================================================

# STEP 6: DESKTOP ENVIRONMENT

# =============================================================================

# NOT DECIDED YET - options being evaluated:

# 

# MEDIUM WEIGHT (similar to XFCE):

# LXQt  - modern Qt-based, lighter than XFCE

# MATE  - classic GNOME2 feel, rock solid

# Budgie - polished, GTK, moderate weight

# Cinnamon - Windows-like, comfortable

# 

# LIGHT (below XFCE):

# Openbox - mouse-friendly, minimal, X11

# Labwc   - Openbox-like but Wayland

# Sway    - keyboard-driven, Wayland

# 

# INSTALL EXAMPLE (uncomment chosen one):

# apt install xfce4 xfce4-terminal

# apt install lxqt

# apt install mate-desktop-environment-core

# 

# DISPLAY MANAGER (login screen) - pick one:

# apt install lightdm              # lightweight, works with most desktops

# apt install sddm                 # better for LXQt/KDE

# apt install greetd               # minimal, good for Wayland

# =============================================================================

# STEP 7: FONTS & BASIC APPS

# =============================================================================

# Uncomment as needed

# apt install fonts-dejavu-core    # basic fonts

# apt install firefox-esr          # browser

# apt install thunar               # file manager (XFCE’s, works standalone)

# apt install alsa-utils pulseaudio # sound

echo “=== Bootstrap script complete ===”
echo “Next: choose desktop environment and uncomment STEP 6”