{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.lsd.enable {
   environment.shellAliases = {
     ls = "lsd";
   };

   home-manager.users."${username}".programs = {
     lsd = {
       enable = true;

       settings = {
         indicators           = true;
         layout               = "tree";
         size                 = "short";
         sorting.dir-grouping = "first";
         color.when           = "always";
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
