# Patches for Zephyrus G14

## Wireplumber Audio Configuration

This configuration replaces the original `update_pcm.sh` solution, which is no longer working reliably on newer machines. The wireplumber config provides a stable base for audio management.

Place this configuration in `~/.config/wireplumber/` for it to take effect.

## Disable PSR (Panel Self Refresh)

Fixes black screen flickering (1-10s) after resuming from sleep on AMD iGPU (Radeon 880M/890M).

Add `amdgpu.dcdebugmask=0x10` to the kernel command line in `/boot/loader/entries/arch.conf`, then reboot.

## NetworkManager: Disable Auto-Activate

Prevents NetworkManager from automatically creating default connections for all interfaces.

Place in `/etc/NetworkManager/conf.d/`.
