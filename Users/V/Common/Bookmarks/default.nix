{ username
, ... 
}:

{
 home-manager.users."${username}".programs.firefox.profiles.default.bookmarks = [
   {
    name = "GitHub";
    url  = "https://github.com";
   }
   {
    name = "ChatGPT";
    url  = "https://chat.openai.com";
   }
   {
    name = "Roadmap";
    url  = "https://roadmap.sh/devops";
   }
   {
    name = "CoinGecko";
    url  = "https://www.coingecko.com/";
   }
   {
    name = "Tutanota";
    url  = "https://app.tuta.com/login";
   }
   {
    name = "Hoogle";
    url  = "https://hoogle.haskell.org/";
   }
   {
    name = "Coinbase";
    url  = "https://www.coinbase.com/home";
   }
   {
    name = "MetaMask";
    url  = "https://portfolio.metamask.io/";
   }
   {
    name = "Home-Manager";
    url  = "https://home-manager-options.extranix.com/?";
   }
   {
    name = "Certificates";
    url  = "https://devopscube.com/best-devops-certifications";
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
}
