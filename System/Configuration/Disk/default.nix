{ ... }:

{
 zramSwap = {
   memoryPercent = 15;
   enable        = true;
 };

 disko.devices = {
   nodev."/" = {
     fsType = "tmpfs";

     mountOptions = [
       "size=6G"
       "defaults"
       "mode=755"
     ];
   };

   disk.main = {
     type   = "disk";
     device = "/dev/nvme0n1";

     content = {
       type = "gpt";

       partitions = {
         nix = {
           size = "40G";

           content = {
             format     = "xfs";
             mountpoint = "/nix";
             type       = "filesystem";
           };
         };

         home = {
           size = "100%";

           content = {
             format     = "xfs";
             mountpoint = "/home";
             type       = "filesystem";
           };
         };

         persist = {
           size = "512M";

           content = {
             format     = "xfs";
             mountpoint = "/persist";
             type       = "filesystem";
           };
         };

         esp = {
           size = "512M";
           type = "EF00";

           content = {
             format     = "vfat";
             mountpoint = "/boot";
             type       = "filesystem";
           };
         };
       };
     };
   };
 };
}
