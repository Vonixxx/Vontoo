{ lib
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.lsd.enable) {
   home-manager.users.vonix.programs = {
     lsd = {
       enable = true;

       settings = {
         indicators           = true;
         layout               = "tree";
         size                 = "short";
         color.when           = "never";
         sorting.dir-grouping = "first";
         icons.when           = "always";

         recursion = {
           depth   = 2;
           enabled = true;
         };
       };
     };
   };
 };
}
