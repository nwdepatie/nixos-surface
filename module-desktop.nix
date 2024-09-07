{ config, pkgs, ... }: {


  # https://github.com/fthx/no-overview/tree/main
  # is also helpful to ensure we end up on a desktop instead of the launcher.
  # Forked to https://github.com/iwanders/gnome-no-overview-extension
  # Currently installed through the gnome extension system.

  imports = [ ./gnome-osk.nix ];

  options = { };

  config = {
    # Surface related stuff.
    services.iptsd.enable = true;

    sound.enable = true;
    hardware.pulseaudio.enable = true;

    # https://github.com/NixOS/nixpkgs/blob/4ecab3273592f27479a583fb6d975d4aba3486fe/nixos/modules/services/x11/desktop-managers/gnome.nix#L459

    # Configure keymap in X11
    # services.xserver.xkbOptions = "eurosign:e,caps:escape";
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.displayManager.gdm.autoSuspend = false;

    # This block is here to ensure we get GDM with the custom on screen keyboard extension
    # in the settings I want.
    programs.dconf.profiles.gdm.databases = [
      {
        #lockAll = false;
        settings."org/gnome/shell/extensions/enhancedosk" = {
          show-statusbar-icon = true;
          locked = true;
        };
      }

      {
        #lockAll = false;
        settings."org/gnome/shell" = {
          enabled-extensions = [ "iwanders-gnome-enhanced-osk-extension" ];
        };
      }

      {
        #lockAll = false;
        settings."org/gnome/desktop/a11y/applications" = {
          screen-keyboard-enabled = true;
        };
      }
    ];

    services.xserver.desktopManager.gnome.enable = true;

    services.gnome.core-utilities.enable = false;
  };
}
