{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.grub.configurationLimit = 10;

  networking.hostName = "nixos";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "phpstorm"
      "discord"
      "corefonts"
    ];

  time.timeZone = "Asia/Jakarta";

  hardware.bluetooth.enable = true;

  users.users.photon = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.optimise = {
    automatic = true;
    dates = "weekly";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  programs.niri.enable = true;
  programs.zsh.enable = true;

  services.gvfs.enable = true;
  services.upower.enable = true;
  services.udisks2.enable = true;
  services.openssh.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = true;
  # services.printing.enable = true;
  # services.libinput.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.programs.niri.package}/bin/niri-session";
      };
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Lenovo Thinkpad F4 Microphone LED problem
  services.udev.extraRules = ''
    SUBSYSTEM=="leds", KERNEL=="platform::micmute", RUN+="${pkgs.coreutils}/bin/chmod 666 /sys/class/leds/platform::micmute/brightness"
  '';

  # OnlyOffice fonts problem
  system.userActivationScripts = {
    copy-fonts-local-share = {
      text = ''
        rm -rf ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
        cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 544 ~/.local/share/fonts
        chmod 444 ~/.local/share/fonts/*
      '';
    };
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  environment.variables.EDITOR = "vim";
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    # config.common.default = [ "gnome" "gtk" ];
  };

  system.stateVersion = "26.05";

}
