{ device ? throw
, ...
}:

{
 zramSwap = {
   memoryPercent = 25;
   enable        = true;
 };

 disko.devices = {
   nodev."/" = {
     fsType = "tmpfs";

     mountOptions = [
       "size=4G"
       "defaults"
       "mode=755"
     ];
   };

   disk.main = {
     type = "disk";
     inherit device;

     content = {
       type = "gpt";

       partitions = {
         nix = {
           size = "30G";

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
