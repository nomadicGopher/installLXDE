## installLXDE  
Install LXDE on NVIDIA Jetson Developer Kits (JetPack 5.3)

### Overview  
This script installs the **LXDE** desktop environment and the **Compton** compositor, then configures **GDM3** as the display manager. It also creates a desktop shortcut for LXTerminal.

### Usage  

```bash
$ chmod +x installLXDE.sh
$ ./installLXDE.sh
```

After the script finishes, **reboot** the device. On the login screen select **LXDE** as the session before logging in.

### What the script does  

| Step | Action |
|------|--------|
| 1 | Updates APT package lists (`apt-get update`). |
| 2 | Installs `lxde` and `compton`. |
| 3 | Creates `/etc/xdg/autostart/lxde-compton.desktop` to launch Compton with the GLX backend. |
| 4 | Reconfigures **GDM3** as the default display manager (`dpkg-reconfigure gdm3`). |
| 5 | Copies `lxterminal.desktop` to the user's `~/Desktop` folder. |
| 6 | Prompts the user to reboot. |

### Background wallpaper  

The default Jetson background (`NVIDIA_wallpaper.jpg`) is located at:

```
/usr/share/backgrounds/NVIDIA_wallpaper.jpg
```

Enjoy a faster, lighter desktop experience!