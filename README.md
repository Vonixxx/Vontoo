# NixOS Configuration
*A minimal and fully declarative setup utilising NixOS, with a personalised setup for each machine.*

## Sytem Information

### The structure of the configuration is as such:

```
flake.nix
│
├/Users
│ └/<surname initial>
│   └<user>
│
└/System
  ├/UI
  │ ├/Gnome
  │ └/Hyprland
  │
  ├/Configuration
  │ ├/Disk
  │ ├/Model
  │ ├/General
  │ ├/Packages
  │ └/Impermanence
  │
  └/Programs
    ├/Bat
    ├/LSD
    ├/Git
    ├/ZSH
    ├/Atuin
    ├/Helix
    ├/Firefox
    ├/Freetube
    └/Printing
```

flake.nix lies at the root of this directory, and each / represents a subfolder. Within each subfolder
lies a default.nix, wherein lies the configuration for the given aspect of the system as described in the parent directory.
The `System` and `Users` folders each have a default.nix file at their base, they serve the role of importing all the files
that lie within the subfolders, which then get imported back to flake.nix in order to instantiate the system. The structure
is arbitrary and is simply meant to provide clarity.

### User-specific configuration is as such:

```
<user> = mkSystem <bool> toggle TLP.
                  <bool> toggle printing capabilities.
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

Users are configured in `Users/default.nix`, each also imports their respective user folders further down the directory tree.
These options are provided as such, and not in their respective user folders, simply because I deemed it more convenient.
These are basic settings each user needs to have setup for a functional system. The configuration within the respective
user directories consists of bookmarks (for FireFox) and highly specific configuration when deemed necessary by the given user.
For example if someone has accesibility issues, those settings would be toggled in their respective folder.

## Special Thanks
- [FireFox Theme](https://codeberg.org/Freeplay/Firefox-Onebar/)
- [JRMurr's NixOS Configuration](https://github.com/JRMurr/NixOsConfig/tree/main)
- [Matthias' NixOS Configuration](https://github.com/MatthiasBenaets/nixos-config/)
- [Declarative Gnome Configuration](https://hoverbear.org/blog/declarative-gnome-configuration-in-nixos/)
