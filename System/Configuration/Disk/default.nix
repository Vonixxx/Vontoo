{ device ? throw
, ...
}:

{
 zramSwap = {
   enable    = true;
   memoryMax = 8589934592;
 };

 disko.devices = {
   disk.main = {
     type = "disk";
     inherit device;

     content = {
       type = "gpt";

       partitions = {
         root = {
           size = "40G";

           content = {
             mountpoint = "/";
             format     = "xfs";
             type       = "filesystem";
           };
         };

         nix = {
           size = "80G";

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
