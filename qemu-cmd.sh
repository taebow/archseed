#!/usr/bin/bash

qemu-system-x86_64 \
    -enable-kvm \
    -m 2G \
    -cpu host \
    -cdrom images/"$(ls -1 images | sort | tail -n 1)" \
    -boot d