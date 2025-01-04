# NixOS Configuration
*A minimal and fully declarative setup utilising NixOS, with a personalised setup for each machine.*

## Default Applications
- Browser: Brave
- Terminal: Foot
- Youtube: Freetube
- UX: Hyprland + Waybar
- Productivity: LibreOffice
- Text Editor: Gnome Text Editor
  - Alternative: Helix

## System Information

### Configuration structure:

```
flake.nix
│
├/Users
│ └/<surname initial>
│   └<user>
│
└/System
  ├/UI
  │ ├/Style
  │ ├/Waybar
  │ └/Hyprland
  │
  ├/Configuration
  │ ├/Disk
  │ ├/Model
  │ ├/General
  │ └/Packages
  │
  └/Programs
    ├/Bat
    ├/LSD
    ├/Git
    ├/ZSH
    ├/Atuin
    ├/Helix
    ├/Freetube
    └/Printing
```

The `System` and `Users` folders each have a default.nix file at their base, they serve the role of importing all the files
that lie within the subfolders, which then get imported back to flake.nix in order to instantiate the system. The structure
is arbitrary and was chosen based on how intuitive it is to me.

`Users` does not always contain a user-specific directory, this depends on the degree to which the given profile is customized. Most basic customizations can be readily achieved in `Users/default.nix`. 

`System/UI/Style` contains the default values regarding the cursor, fonts and colors used in the system. Changing the values there will affect all apps which allow color customisations, the affected apps can be found in `System/Backend/Settings`.

### User-specific configurable options:

```
<user> = mkSystem <bool> TLP
                  <bool> printing capabilities
                  <bool> latest kernel
                  <bool> AMD CPU
                  <bool> AMD GPU
                  <bool> Intel CPU
                  <bool> Intel GPU
                  <string> keyboard language
                  <string> locale settings
                  <string> location, used to determine time
                  <string> username
                  <string> folder location for other user-specific configuration
                  <string> password, encoded using `mkpasswd`
                  <list> extra modules
                  <list> overlays for nixpkgs
```

## Special Thanks
- [JRMurr's NixOS Configuration](https://github.com/JRMurr/NixOsConfig/tree/main)
- [Matthias' NixOS Configuration](https://github.com/MatthiasBenaets/nixos-config/)
- [Declarative Gnome Configuration](https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/)

- [FireFox Theme](https://codeberg.org/Freeplay/Firefox-Onebar/)
  - No longer applicable.
