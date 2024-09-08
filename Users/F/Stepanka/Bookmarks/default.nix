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
     	    name = "ChatGPT";
     	    url  = "https://chat.openai.com";
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
