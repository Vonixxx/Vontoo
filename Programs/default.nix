{ lib
, pkgs
, config
, username
, ...
}:

let
 cfg       = config;
 cfgEnable = cfg.enable;

 inherit (lib)
  mkIf
  mkMerge;
in {
 config =
 mkMerge [ 
   (mkIf cfgEnable.lsd {
     environment.shellAliases = {
       ls = "lsd";
     };
   })

   (mkIf cfgEnable.bat {
     environment.shellAliases = {
       cat  = "bat";
       man  = "batman";
       grep = "batgrep";
     };
   })

   (mkIf cfgEnable.zsh {
     programs.zsh.enable    = true;
     users.defaultUserShell = pkgs.zsh;
  
     environment = {
       shells = [
         pkgs.zsh
       ];
  
       systemPackages = with pkgs; [
         gnutar
         pigz
         p7zip
         pbzip2
         unar
         unzip
         xz
       ];
     };
   })

   (mkIf cfgEnable.printing {
     services = {
       saned.enable   = true;
       ipp-usb.enable = true;
  
       avahi = {
         enable       = true;
         nssmdns4     = true;
         openFirewall = true;
       };
  
       printing = {
         enable          = true;
         browsing        = true;
         openFirewall    = true;
         defaultShared   = true;
         startWhenNeeded = false;
  
         drivers = with pkgs; [
           hplip
           gutenprint
           gutenprintBin
         ];
       };
     };
  
     hardware.sane = {
       enable          = true;
       openFirewall    = true;
       brscan4.enable  = true;
       brscan5.enable  = true;
       dsseries.enable = true;
  
       disabledDefaultBackends = [
         "escl"
       ];
  
       extraBackends = with pkgs; [
         sane-airscan
         sane-backends
       ];
     };
   })

   (mkIf cfgEnable.virtualisation {
     programs.virt-manager.enable = true;

     security.tpm2 = {
       enable                 = true;
       abrmd.enable           = true;
       pkcs11.enable          = true;
       tctiEnvironment.enable = true;
     };
  
     virtualisation = {
       spiceUSBRedirection.enable = true;
  
       libvirtd = {
         enable = true;
  
         qemu = {
           swtpm.enable = true;
           package      = pkgs.qemu_kvm;
  
           ovmf.packages = [
             (pkgs.OVMFFull.override {
               secureBoot = true;
               tpmSupport = true;
             }).fd
           ];
         };
       };
     };
   })

   {
    home-manager.users.${username}.programs =
    mkMerge [
      (mkIf cfgEnable.foot {
        foot = {
          enable        = true;
          server.enable = true;
        };
      })

      (mkIf cfgEnable.bemenu {
        bemenu = {
          enable = true;
     
          settings = {
            list         = 5;
            prompt       = "";
            center       = true;
            width-factor = 0.15;
          };
        };
      })

      (mkIf cfgEnable.bat {
        bat = {
          enable = true;
     
          extraPackages =
          with pkgs.bat-extras; [
            batman
            batgrep
          ];
        };
      })

      (mkIf cfgEnable.git {
        git.enable                  = true;
        git-credential-oauth.enable = true;
      })
 
      (mkIf cfgEnable.lsd {
        lsd = {
          enable = true;
   
          settings = {
            indicators           = true;
            layout               = "tree";
            size                 = "short";
            sorting.dir-grouping = "first";
            color.when           = "always";
            icons.when           = "always";
   
            recursion = {
              depth   = 2;
              enabled = true;
            };
          };
        };
      })

      (mkIf (cfgEnable.zsh && cfgEnable.atuin) {
        atuin.enableZshIntegration = true;
      })

      (mkIf cfgEnable.zsh {
        zsh = {
          enable = true;
   
          initExtraFirst = ''
             if uwsm check may-start; then
               exec uwsm start hyprland-uwsm.desktop
             fi
   
             pfetch
          '';
   
          prezto = {
            enable        = true;
            caseSensitive = false;
   
            pmodules = [
              "environment"
   
              "syntax-highlighting"
              "autosuggestions"
   
              "helper"
              "editor"
              "history"
              "utility"
              "directory"
   
              "archive"
              "completion"
            ];
   
            editor = {
              keymap       = "vi";
              dotExpansion = true;
            };
          };
        };
      })

      (mkIf cfgEnable.atuin {
        atuin = {
          enable = true;
   
          settings = {
            inline_height = 10;
            update_check  = false;
            style         = "compact";
            keymap_mode   = "vim-normal";
          };
        };
      })

      (mkIf cfgEnable.helix {
        helix = {
          enable = true;
   
          settings.editor = {
            color-modes             = true;
            cursorcolumn            = true;
            soft-wrap.enable        = true;
            lsp.display-inlay-hints = true;
            line-number             = "relative";
   
            whitespace.render = {
              tab   = "all";
              nbsp  = "all";
              nnbsp = "all";
            };
   
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
   
            statusline = {
              mode = {
                insert = "INSERT";
                normal = "NORMAL";
                select = "SELECT";
              };
   
              right = [
                "diagnostics"
                "position"
                "total-line-numbers"
              ];
            };
          };
        };
      })

      (mkIf cfgEnable.freetube {
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
            listType                = "list";
            defaultQuality          = "1080";
          };
        };
      })
    ];
   }
 ];
}
