{ username
, ... 
}:

{
 home-manager.users."${username}".programs.firefox.profiles.default = {
   bookmarks = [
     {
      name = "GitHub";
      url  = "https://github.com";
     }
     {
      name = "AI Chat";
      url  = "https://duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat&duckai=1";
     }
     {
      name = "CodeBerg";
      url  = "https://codeberg.org";
     }
     {
      name = "Tutanota";
      url  = "https://app.tuta.com/login";
     }
     {
      name = "Coinbase";
      url  = "https://www.coinbase.com/home";
     }
     {
      name = "MetaMask";
      url  = "https://portfolio.metamask.io";
     }
     {
      name = "CoinGecko";
      url  = "https://www.coingecko.com";
     }
     {
      name = "Home Manager";
      url  = "https://home-manager-options.extranix.com/?query=&release=master";
     }
     {
      name = "NixOS Options";
      url  = "https://search.nixos.org/options?channel=unstable&";
     }
     {
      name = "NixOS Packages";
      url  = "https://search.nixos.org/packages?channel=unstable&";
     }
   ];
 };
}
