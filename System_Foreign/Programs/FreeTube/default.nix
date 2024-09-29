{ ... }:

{
 programs.freetube = {
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
     mainColor               = "Red";
     defaultQuality          = "720";
     listType                = "list";
     secColor                = "Amber";
     baseTheme               = "black";
   };
 };
}
