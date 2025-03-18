# NixOS Configuration
*A minimal and fully declarative setup utilising NixOS, with a personalised setup for each machine.*

## Default Applications
- Browser: Brave
- Terminal: Foot
- Launcher: BeMenu
- UX: Hyprland + Waybar
- Productivity: LibreOffice
- Text Editor: Gnome Text Editor
  - Alternative: Helix
- FOSS YouTube Frontend: FreeTube

## System Information

### Configuration structure:

```
flake.nix
│
├/Options
│ 
├/Users
│ │ 
│ └/Dependencies
│
└/System
  │ 
  ├/Programs
  │ 
  ├/Settings
  │  
  ├/Configuration
  │ ├/Disk
  │ ├/General
  │ └/Packages
  │
  └/UI
    └/Hyprland_WayBar
```

`Options` defines custom options which toggle certain programs and enable customisation of both fonts colors used throughout the system, as well as the cursor.

`` defines custom options which toggle certain programs and enable customisation of both fonts colors used throughout the system, as well as the cursor.

`Users` is used for user-specific configuration.

`System` contains all needed settings for a functional system.

User-specific hardware options are automatically configured.

### User-specific configurable options:

```
 <user> = mkSystem <bool>          toggle TLP
                   <bool>          toggle printing capabilities
                   <bool>          toggle latest kernel
                   <string>        keyboard language
                   <string>        language locale
                   <string>        username
                   <string>        password, encoded using `mkpasswd`
                   <list>          extra NixOS modules
                   <list>          extra groups for the user
                   <list>          extra kernel modules
                   <list>          extra kernel parameters
                   <list>          packages
                   <attribute set> user-specific configuration
```

## Special Thanks
- [JRMurr's NixOS Configuration](https://github.com/JRMurr/NixOsConfig/tree/main/)
- [Matthias' NixOS Configuration](https://github.com/MatthiasBenaets/nixos-config/)
  - These two NixOS configurations helped lay the groundwork for my own, this likely wouldn't have been possible without them!

- [Purga](https://github.com/nikolaiser/purga/)
  - Allows for CLI arguments to be passed to the flake. This allows for necessary user-specific CPU/GPU configuration options, as well as the loading of necessary kernel modules. It is used every time the `update` and `check` commands are invoked. The implementation can be found in `System/Configuration/General`.

- [FireFox Theme](https://codeberg.org/Freeplay/Firefox-Onebar/)
  - No longer applicable.

- [Declarative Gnome Configuration](https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/)
  - No longer applicable.
