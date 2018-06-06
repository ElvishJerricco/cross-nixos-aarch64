let
  system = import ./system.nix;
  pkgs = import <nixpkgs> {};
  inherit (system.config.system.build) sdImage;
in pkgs.writeShellScriptBin "run-vm" ''
  set -eu
  if [ ! -f $1 ]; then
    ${pkgs.qemu}/bin/qemu-img create -f qcow2 -F raw -b ${sdImage}/sd-image/*.img $1 ''${3:-40G}
  fi

  ${pkgs.qemu}/bin/qemu-system-aarch64 -machine virt,highmem=off \
    -cpu cortex-a57 \
    -bios ${system.pkgs.ubootQemuAarch64}/u-boot.bin \
    -drive if=none,file=$1,id=mydisk \
    -device ich9-ahci,id=ahci \
    -device ide-drive,drive=mydisk,bus=ahci.0 \
    -netdev user,id=net0,hostfwd=tcp::10000-:22,hostfwd=tcp::8000-:80 \
    -device virtio-net-pci,netdev=net0 \
    -nographic -smp 2 -m ''${2:-2G}
''
