{ device ? throw
, ...
}:

{
 disko.devices = {
   disk.main = {
     type = "disk";
     inherit device;

     content = {
       type = "gpt";

       partitions = {
         root = {
           size = "100%";

           content = {
             type = "lvm_pv";
             vg   = "root_vg";
           };
         };

         esp = {
           type = "EF00";
           size = "512M";

           content = {
             format     = "vfat";
             mountpoint = "/boot";
             type       = "filesystem";
           };
         };
       };
     };
   };

   lvm_vg.root_vg = {
     type = "lvm_vg";

     lvs.root = {
       size = "100%FREE";

       content = {
         type      = "btrfs";
         extraArgs = [ "-f" ];

         subvolumes = {
           "/root".mountpoint = "/";

           "/nix" = {
             mountpoint = "/nix";

             mountOptions = [
               "noatime"
               "subvol=nix"
             ];
           };

           "/persist" = {
             mountpoint = "/persist";

             mountOptions = [
               "noatime"
               "subvol=persist"
             ];
           };
         };
       };
     };
   };
 };
}
