{ pkgs
, ... 
}:

{
 foot.enable          = true;
 mako.enable          = true;
 bemenu.enable        = true;
 waybar.enable        = true;
 amd-cpu.enable       = true;
 amd-gpu.enable       = true;
 freetube.enable      = true;
 hyprland.enable      = true;
 services.gvfs.enable = true;

 xdg.portal = {
   enable = true;

   config.common.default = [
     "gtk"
   ];

   extraPortals = with pkgs; [
     xdg-desktop-portal-gtk
     xdg-desktop-portal-hyprland
   ];
 };

 services = {
   nginx = {
     enable = true;
   };
 };

 environment.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    fi
 '';

 networking = {
   useDHCP                          = false;
   defaultGateway                   = "192.168.0.1";
   nameservers                      = [ "8.8.8.8" "8.8.4.4" ];
   interfaces.enp1s0.ipv4.addresses = [ { address = "192.168.0.10"; prefixLength = 24; } ];
 };

 users.users.vonix = {
   name           = "V-Lenovo";
   hashedPassword = "$y$j9T$eDooCqRrtgj05orlhUujQ1$RDV9aOlJZkKZI6wtkpR.YD00ELzIlNZbDWY8IiDIxfB";
 };
}
