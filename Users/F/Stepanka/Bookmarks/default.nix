{ username
, ...
}:

{
 home-manager.users."${username}" = {
   programs.firefox = {
     policies = {
       ManagedBookmarks = [
         {
          toplevel_name = "Bookmarks";
         }
         {
          name = "AI Chat";
          url  = "https://duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat&duckai=1";
         }
         {
          name = "Tutanota";
          url  = "https://app.tuta.com/login";
         }
       ];
     };
   };
 };
}
