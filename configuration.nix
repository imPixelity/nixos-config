{
  config,
  lib,
  pkgs,
  testSpecialArgs,
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
    ];

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
  environment.variables.TestSpecialArgs = testSpecialArgs;

  system.stateVersion = "26.05";

}
