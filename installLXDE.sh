#!/bin/bash
# Install LXDE (Lightweight Desktop Environment) on a NVIDIA Jetson Developer Kit
# using GDM3 as the display manager and disable auto‑login.

set -e   # stop on first error

# ----------------------------------------------------------------------
# 1. Update package sources
# ----------------------------------------------------------------------
echo "Updating package lists..."
sudo apt update

# ----------------------------------------------------------------------
# 2. Install LXDE and the Compton compositor
# ----------------------------------------------------------------------
echo "Installing LXDE and compton..."
sudo apt install -y lxde compton

# ----------------------------------------------------------------------
# 3. Autostart Compton for LXDE
# ----------------------------------------------------------------------
echo "Creating LXDE Compton autostart entry..."
sudo tee /etc/xdg/autostart/lxde-compton.desktop > /dev/null <<'EOF'
[Desktop Entry]
Type=Application
Name=Compton (X Compositor)
GenericName=X compositor
Comment=A X compositor
TryExec=compton
Exec=compton --backend glx -b
OnlyShowIn=LXDE
EOF

# ----------------------------------------------------------------------
# 4. Disable automatic login in GDM3
# ----------------------------------------------------------------------
GDM_CONF="/etc/gdm3/custom.conf"

echo "Disabling automatic login in $GDM_CONF..."
sudo cp "$GDM_CONF" "${GDM_CONF}.bak"   # keep a backup

sudo sed -i \
    -e 's/^AutomaticLoginEnable\s*=.*/AutomaticLoginEnable=false/' \
    -e 's/^AutomaticLogin\s*=.*/#AutomaticLogin=/' \
    "$GDM_CONF"

# ----------------------------------------------------------------------
# 5. Reconfigure GDM3 (ensures changes are picked up)
# ----------------------------------------------------------------------
echo "Reconfiguring GDM3..."
sudo dpkg-reconfigure gdm3

# ----------------------------------------------------------------------
# 6. Optional: put a LXTerminal shortcut on the desktop
# ----------------------------------------------------------------------
if [[ -f lxterminal.desktop ]]; then
    echo "Copying LXTerminal desktop file to the user's Desktop..."
    cp lxterminal.desktop "$HOME/Desktop/lxterminal.desktop"
else
    echo "Warning: lxterminal.desktop not found - skipping copy."
fi

# ----------------------------------------------------------------------
# 7. Finish
# ----------------------------------------------------------------------
echo
echo "Installation complete."
echo "Reboot for changes to take effect."
echo "After reboot, select LXDE from the session menu on the GDM login screen."
