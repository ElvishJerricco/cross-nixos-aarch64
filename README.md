Cross compile NixOS to Aarch64
---

# Running in a VM

```bash
$ nix-build -I nixpkgs=https://github.com/ElvishJerricco/nixpkgs/archive/cross-nixos-aarch64.tar.gz run-vm.nix
$ result/bin/run-vm my-image-file.qcow2
```
