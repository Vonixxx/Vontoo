{ ... }:

{
 networking.firewall = {
   allowedTCPPorts = [
     80  # HTTP
     443 # HTTPS
     587 # Secure SMTP
     993 # Secure IMAP
     995 # Secure POP3
   ];
 };

 security.acme = {
   acceptTerms = true;

   defaults = {
     dnsProvider = "godaddy";
     email       = "vonixxx@tuta.io";
   };
 };

 services.nginx = {
   enable                   = true;
   recommendedTlsSettings   = true;
   recommendedGzipSettings  = true;
   recommendedOptimisation  = true;
   recommendedProxySettings = true;

   virtualHosts = {
     "vontoo.xyz" = {
       forceSSL   = true;
       enableACME = true;
       serverName = "vontoo.xyz";
       root       = "/var/www/nutrition";

       locations = {
         "/".return                  = "301 /home";
         "/home".index               = "main.html";
         "/services/nutrition".index = "main.html";
         "/about/me".index           = "main.html cooki.jpeg";
       };
     };
   };
 };

 environment.variables = {
   GODADDY_API_SECRET = "SUmt29WwGrw9YZEL3q8pna";
   GODADDY_API_KEY    = "3mM44UdBzbqpuE_TEKHABESo7ZuemuhPXsqBY";
 };

 mailserver = {
   enable                                         = true;
   certificateScheme                              = "acme-nginx";
   fqdn                                           = "mail.vontoo.xyz";
   loginAccounts."mail@vontoo.xyz".hashedPassword = "$2b$05$MK.0UE2j6V5jLqLxMFO93.i4UT2MAoaCYS3FyvLOmmZ4RhWTL8n9y";

   domains = [
     "vontoo.xyz"
   ];
 };
}
