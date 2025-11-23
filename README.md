## installLXDE  
Install LXDE on NVIDIA Jetson Developer Kits (JetPack 5.3)

### Overview  
This script installs the **LXDE** desktop environment and the **Compton** compositor, configures **GDM3** as the display manager, **disables automatic login**, and creates a desktop shortcut for LXTerminal.

### Usage  

```bash
chmod +x installLXDE.sh
./installLXDE.sh
```

After the script finishes, **reboot** the device. On the login screen select **LXDE** as the session before logging in. Because automatic login is disabled, you will be prompted for your password each boot.

### What the script does  

| Step | Action |
|------|--------|
| 1 | Updates APT package lists (`apt update`). |
| 2 | Installs `lxde` and `compton`. |
| 3 | Creates `/etc/xdg/autostart/lxde-compton.desktop` to launch Compton with the GLX backend. |
| 4 | **Disables GDM3 automatic login** by setting `AutomaticLoginEnable=false` (and commenting out `AutomaticLogin`). |
| 5 | Reconfigures **GDM3** as the default display manager (`dpkg-reconfigure gdm3`). |
| 6 | Copies `lxterminal.desktop` to the user's `~/Desktop` folder. |
| 7 | Prompts the user to reboot & manually select the LXDE session. |

### Selecting the display manager  

If the script prompts you to choose a display manager, **select `gdm3`** from the list. This ensures the system uses GDM3, which the script then configures.

### Background wallpaper  

The default Jetson background (`NVIDIA_wallpaper.jpg`) is located at:

```
/usr/share/backgrounds/NVIDIA_wallpaper.jpg
```

Enjoy a faster, lighter desktop experience!

### Known issues / troubleshooting
- **Still auto‑logging in?**  
  Verify that `/etc/gdm3/custom.conf` contains `AutomaticLoginEnable=false` (or that the line is commented out). The script backs up the original file as `custom.conf.bak` before making changes.