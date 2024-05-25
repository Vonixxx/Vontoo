{ ... }:

{
 amd-cpu.enable               = true;
 amd-gpu.enable               = true;
 freetube.enable              = true;
 services.getty.autologinUser = "Vonix";

 environment.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    fi
 '';

# services = {
#   nginx = {
#     enable = true;
#   };
# };

# networking = {
#   useDHCP                          = false;
#   defaultGateway                   = "192.168.0.1";
#   nameservers                      = [ "8.8.8.8" "8.8.4.4" ];
#   interfaces.enp1s0.ipv4.addresses = [ { address = "192.168.0.10"; prefixLength = 24; } ];
# };
# };
}
