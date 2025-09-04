#!/usr/bin/env bash
#
# update_lightdm.sh
# Complete LightDM setup and configuration script
# Sets up LightDM as default display manager with custom greeter configuration

set -e

# Get script directory for relative paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up LightDM display manager..."

# Install LightDM and greeter if not already installed
if ! command -v lightdm &> /dev/null; then
    echo "Installing LightDM and GTK greeter..."
    sudo dnf install -y lightdm lightdm-gtk-greeter
else
    echo "LightDM already installed"
fi

# Disable current display manager (likely GDM)
echo "Disabling current display manager..."
sudo systemctl disable gdm.service 2>/dev/null || true

# Enable LightDM
echo "Enabling LightDM as default display manager..."
sudo systemctl enable lightdm.service

# Ensure GTK greeter is configured in main LightDM config
if [ -f /etc/lightdm/lightdm.conf ]; then
    echo "Configuring LightDM to use GTK greeter..."
    sudo sed -i 's/#greeter-session=.*/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf
fi

# Copy assets and configuration
greeter_config="$SCRIPT_DIR/lightdm-gtk-greeter.conf"
wallpaper_source="$HOME/Pictures/wallpaper/other/shotei-takahashi-starlight.night.jpg"

# Copy wallpaper to system-accessible location
if [ -f "$wallpaper_source" ]; then
    echo "Copying LightDM wallpaper to system directory..."
    sudo cp "$wallpaper_source" /usr/share/backgrounds/
    echo "✓ LightDM wallpaper copied"
else
    echo "Warning: Wallpaper not found at $wallpaper_source"
fi

# Copy user face image if it exists
if [ -f "$HOME/.face" ]; then
    echo "Copying user face image to system directory..."
    sudo cp "$HOME/.face" /usr/share/pixmaps/user-face.png
    echo "✓ LightDM user image copied"
else
    echo "Note: No user face image found at ~/.face (optional)"
fi

# Copy custom greeter configuration
if [ -f "$greeter_config" ]; then
    echo "Copying custom LightDM greeter configuration..."
    sudo cp "$greeter_config" /etc/lightdm/lightdm-gtk-greeter.conf
    echo "✓ Custom LightDM greeter configuration copied"
else
    echo "Error: Custom LightDM greeter config not found at $greeter_config"
    exit 1
fi

echo ""
echo "✓ LightDM setup completed successfully!"
echo "Note: LightDM will be active after the next reboot."
echo "Current display manager status:"
systemctl is-enabled gdm.service 2>/dev/null && echo "  GDM: enabled" || echo "  GDM: disabled"
systemctl is-enabled lightdm.service 2>/dev/null && echo "  LightDM: enabled" || echo "  LightDM: disabled"
