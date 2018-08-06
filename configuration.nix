{ config, pkgs, lib, ... }:
{
  security.polkit.enable = false;
  services.udisks2.enable = false;

  programs.command-not-found.enable = false;

  system.boot.loader.kernelFile = lib.mkForce "Image";

  # installation-device.nix forces this on. But it currently won't
  # cross build due to w3m
  services.nixosManual.enable = lib.mkOverride 0 false;

  # installation-device.nix turns this off.
  systemd.services.sshd.wantedBy = lib.mkOverride 0 ["multi-user.target"];

  nixpkgs.crossSystem = lib.systems.examples.aarch64-multiplatform;

  nix.checkConfig = false;
  networking.wireless.enable = lib.mkForce false;

  imports = [./sd-image-aarch64.nix];

  system.stateVersion = "18.03";
}
