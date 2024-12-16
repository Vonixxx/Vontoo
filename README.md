# NixOS Configuration
*A minimal and fully declarative setup utilising NixOS, with a personalised setup for each machine.*

## Default Applications
- Browser: Brave
- Text Editor: KWrite
  - Alternative: Helix
- UX: Hyprland + Waybar
- Terminal: Foot

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

`Users` does not always contain a user-specific directory, this depends on the degree to which the given profile is customized. Most basic customizations can be readily achieved in the `default.nix` which lies at the base of the `Users` directory. 

### User-specific configurable options:

```
<user> = mkSystem <bool> toggle TLP.
                  <bool> toggle printing capabilities.
                  <bool> toggle latest kernel.
                  <bool> toggle AMD CPU settings.
                  <bool> toggle AMD GPU settings.
                  <bool> toggle Intel CPU settings.
                  <bool> toggle Intel GPU settings.
                  <string> keyboard language.
                  <string> locale settings.
                  <string> location, used to determine time.
                  <string> username.
                  <string> folder location for other user-specific configuration.
                  <string> password, encoded using `mkpasswd`.
                  <list> extra modules.
                  <list> overlays for nixpkgs.
```

## Special Thanks
- [JRMurr's NixOS Configuration](https://github.com/JRMurr/NixOsConfig/tree/main)
- [Matthias' NixOS Configuration](https://github.com/MatthiasBenaets/nixos-config/)
- [Declarative Gnome Configuration](https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/)

- [FireFox Theme](https://codeberg.org/Freeplay/Firefox-Onebar/)
  - No longer applicable.
