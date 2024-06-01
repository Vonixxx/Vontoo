{ ... }:

{
 fileSystems."/persist".neededForBoot = true;

 environment.persistence."/persist" = {
   hideMounts = true;

   files = [
     "/etc/machine-id"
   ];

   directories = [
     "/var/log"
     "/var/lib/nixos"
     "/var/lib/bluetooth"
     "/var/lib/systemd/coredump"
     "/etc/NetworkManager/system-connections"
   ];
 };
}
