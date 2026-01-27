#!/usr/bin/bash

DISK_PATH=/tmp/archiso-test.img
EFI_VARS=/tmp/archiso-test-efi-vars.fd

rm $DISK_PATH
qemu-img create -f qcow2 $DISK_PATH 10G

cp /usr/share/ovmf/x64/OVMF_VARS.4m.fd $EFI_VARS

qemu-system-x86_64 \
    -enable-kvm \
    -m 2G \
    -cpu host,kvm=on \
    -smp 4 \
    -drive if=pflash,format=raw,readonly=on,file=/usr/share/ovmf/x64/OVMF_CODE.4m.fd \
    -drive if=pflash,format=raw,file=$EFI_VARS \
    -drive file=$DISK_PATH,if=none,id=nvm,cache=none,aio=native \
    -cdrom images/"$(ls -1 images | sort | tail -n 1)" \
    -device nvme,serial=deadbeef,drive=nvm \
    -nic user,model=virtio-net-pci \
    -vga virtio \
    -display sdl,gl=on \
    -boot menu=on
