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

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  # services.printing.enable = true;

  # services.libinput.enable = true;

  users.users.photon = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.niri.enable = true;
  programs.zsh.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "26.05";

}
