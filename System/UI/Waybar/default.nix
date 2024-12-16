{ lib
, config
, username
, ... 
}:

let
 inherit (lib)
  mkIf;
in {
 config = mkIf config.waybar.enable {
   home-manager.users."${username}".programs = {
     waybar = {
       enable = true;
  
       settings = {
         mainBar = {
           margin-top   = 10;
           margin-left  = 10;
           margin-right = 10;
           layer        = "top";
           position     = "top";
  
           modules-left = [
             "hyprland/workspaces"
             "custom/spacer"
             "mpris"
           ];
  
           modules-center = [
             "custom/spacer"
             "clock"
             "custom/spacer"
           ];
  
           modules-right = [
             "custom/spacer"
             "network"
             "custom/spacer"
             "group/expand-1"
             "custom/spacer"
           ];
  
  
           mpris = {
             interval      = 1;
             max-length    = 30;
             format        = "{status-icons} {dynamic}";
             format-paused = "<span color='#313244'>{status_icon} {dynamic}</span>";
       
             status-icons = {
               paused  = "󰐊"; 
               playing = "󰏤"; 
             };
           };
  
           "custom/spacer" = {
             format = "|";
           };
      
           "hyprland/workspaces" = {
             format = "{icon}";
       
             format-icons = {
               active  = "󰝥";
               default = "󰝦";
             };
           };
    
           clock = {
             format         = "{:%H:%M}";
             tooltip-format = "<tt>{calendar}</tt>";
       
             actions = {
               on-click-right = "mode";
               on-scroll-up   = "shift_up";
               on-scroll-down = "shift_down";
             };
       
             calendar = {
               mode-mon-col   = 3;
               on-click-right = "mode";
       
               format = {
                 days     = "<span color='#cdd6f4'><b>{}</b></span>";
                 today    = "<span color='#f38ba8'><b>{}</b></span>";
                 months   = "<span color='#f9e2af'><b>{}</b></span>";
                 weekdays = "<span color='#fab387'><b>{}</b></span>";
               };
             };
           };
     
           "group/expand-1" = {
             orientation = "horizontal";
       
             modules = [
               "pulseaudio"
               "pulseaudio/slider"
             ];
       
             drawer = {
               transition-duration = 600;
               click-to-reveal     = true;
               transition-to-left  = true;
               children-class      = "not-power";
             };
           };
  
           network = {
             interval                    = 600;
             format-disconnected         = "󰤩";
             tooltip                     = true;
             format                      = "{icon}";
             on-click                    = "foot nmtui";
             tooltip-format-disconnected = "Disconnected";
             tooltip-format              = "Network: <b>{essid}</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>";
       
             format-icons = [
               "󰤟"
               "󰤢"
               "󰤥"
               "󰤨"
             ];
           };
  
           pulseaudio = {
             scroll-step    = 5;
             format-muted   = "󰖁";
             format         = "{icon}";
             tooltip-format = "{desc} | {volume}%";
       
             format-icons = {
               default = [
                 ""
                 ""
                 ""
               ];
             };
           };
  
           "pulseaudio/slider" = {
             min         = 0;
             scroll-step = 1;
             max         = 100;
             device      = "pulseaudio";
           };
         };
       };
     };
   };
 };
}
