#!/usr/bin/bash

DISK_PATH=/tmp/archiso-test.img

rm $DISK_PATH
qemu-img create -f qcow2 $DISK_PATH 10G

qemu-system-x86_64 \
    -enable-kvm \
    -m 2G \
    -cpu host \
    -cdrom images/"$(ls -1 images | sort | tail -n 1)" \
    -boot d \
    -drive file=$DISK_PATH,if=none,id=nvm \
    -device nvme,serial=deadbeef,drive=nvm
    