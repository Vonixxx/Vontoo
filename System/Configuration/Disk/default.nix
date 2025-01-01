{ device ? throw
, ...
}:

let
 GiB = 1024 * 1024 * 1024;
in {
 zramSwap = {
   enable    = true;
   memoryMax = 2 * GiB;
 };

 disko.devices.disk = {
   main = {
     type = "disk";
     inherit device;

     content = {
       type = "gpt";

       partitions = {
         root = {
           size = "100%";

           content = {
             mountpoint = "/";
             format     = "xfs";
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
