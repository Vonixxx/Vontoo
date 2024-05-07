{ lib
, config
, ...
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf (config.freetube.enable) {
   home-manager.users.vonix.programs = {
     freetube = {
       enable = true;

       settings = {
         proxyVideos             = true;
         useRssFeeds             = true;
         hidePlaylists           = true;
         hideHeaderLogo          = true;
         useSponsorBlock         = true;
         hideLabelsSideBar       = true;
         hidePopularVideos       = true;
         defaultTheatreMode      = true;
         hideTrendingVideos      = true;
         allowDashAv1Formats     = true;
         commentAutoLoadEnabled  = true;
         expandSideBar           = false;
         checkForUpdates         = false;
         checkForBlogPosts       = false;
         displayVideoPlayButton  = false;
         hideActiveSubscriptions = false;
         listType                = "list";
         defaultQuality          = "1080";
         baseTheme               = "catppuccinMocha";
         mainColor               = "CatppuccinMochaRed";
         secColor                = "CatppuccinMochaLavender";

         sponsorBlockSelfPromo = {
           color = "Yellow";
           skip  = "autoSkip";
         };

         sponsorBlockInteraction = {
           color = "Green";
           skip  = "autoSkip";
         };
       };
     };
   };
 };
}
