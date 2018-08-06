Cross compile NixOS to Aarch64
---

# Running in a VM

```bash
$ nix-build \
  -I nixpkgs=https://github.com/ElvishJerricco/nixpkgs/archive/cross-nixos-aarch64-2018-08-05.tar.gz \
  system.nix -A config.system.build.sdImage -o sdImage
$ sudo dd if=sdImage/sd-image/*.img of=/dev/YOUR_SD_CARD status=progress
```
