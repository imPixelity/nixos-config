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

  networking.hostName = "nixos";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

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

  services.openssh.enable = true;
  # services.printing.enable = true;
  # services.libinput.enable = true;

  environment.variables.EDITOR = "vim";

  system.stateVersion = "26.05";

}
