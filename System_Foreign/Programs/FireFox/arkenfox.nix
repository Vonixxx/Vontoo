{ ... }:

{
 programs.firefox = {
   arkenfox = {
     enable  = true;
     version = "126.1";
   };

   profiles.default = {
     arkenfox = {
       enable        = true;
       "0000".enable = true;
       "0100".enable = true;
       "0200".enable = true;
       "0300".enable = true;
       "0400".enable = true;
       "0600".enable = true;
       "0700".enable = true;
       "0800".enable = true;
       "0900".enable = true;
       "1000".enable = true;
       "1200".enable = true;
       "1600".enable = true;
       "1700".enable = true;
       "2000".enable = true;
       "2400".enable = true;
       "2600".enable = true;
       "2700".enable = true;
       "2800".enable = true;
       "4500".enable = true;
       "6000".enable = true;
       "9000".enable = true;
       "5000".enable = false;
       "5500".enable = false;
       "7000".enable = false;
       "8000".enable = false;

       "0100" = {
         "0102"."browser.startup.page".value       = 3;
         "0103"."browser.startup.homepage".value   = "https://duckduckgo.com/";
         "0104"."browser.newtabpage.enabled".value = true;
       };

       "1000" = {
         "1001"."browser.cache.disk.enable".value = true;
       };

       "2800" = {
         "2811" = {
           "privacy.clearOnShutdown.formdata".value                       = true;
           "privacy.clearOnShutdown_v2.cache".value                       = false;
           "privacy.clearOnShutdown_v2.historyFormDataAndDownloads".value = false;
         };

         "2815"."privacy.clearOnShutdown_v2.cookiesAndStorage".value = false;
       };

       "4500" = {
         "4501" = {
           "privacy.resistFingerprinting".value        = false;
           "privacy.resistFingerprinting.pbmode".value = false;
         };

         "4504"."privacy.resistFingerprinting.letterboxing".value = false;
         "4520"."webgl.disabled".value                            = false;
       };
     };
   };
 };
}
