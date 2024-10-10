{ lib
, config
, username
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.freetube.enable {
   home-manager.users."${username}".programs = {
     freetube = {
       enable = true;

       settings = {
         useRssFeeds             = true;
         hideHeaderLogo          = true;
         useSponsorBlock         = true;
         hideLabelsSideBar       = true;
         defaultTheatreMode      = true;
         allowDashAv1Formats     = true;
         commentAutoLoadEnabled  = true;
         expandSideBar           = false;
         checkForUpdates         = false;
         checkForBlogPosts       = false;
         hideActiveSubscriptions = false;
         defaultQuality          = "720";
         listType                = "list";
       };
     };
   };
 };
}
