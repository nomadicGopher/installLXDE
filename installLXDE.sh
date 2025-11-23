#!/bin/bash
# Install LXDE (Lightweight Desktop Environment) on a NVIDIA Jetson Orin Nano
# using GDM3 as the display manager

# Update package sources
sudo apt-get update

# Install LXDE and Compton
sudo apt-get install lxde compton -y

# This tells LXDE to use the Compton compositor
sudo dd of=/etc/xdg/autostart/lxde-compton.desktop << EOF
[Desktop Entry]
Type=Application
Name=Compton (X Compositor)
GenericName=X compositor
Comment=A X compositor
TryExec=compton
Exec=compton --backend glx -b
OnlyShowIn=LXDE
EOF

# Ensure GDM3 is correctly configured
sudo dpkg-reconfigure gdm3

# Put a LXTerminal shortcut on the desktop
cp lxterminal.desktop ~/Desktop/lxterminal.desktop

echo
echo
echo 'Reboot for changes to take effect.'
echo 'After reboot, make sure that LXDE is checked when logging in.'