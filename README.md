# archseed - My Opinionated Arch Linux ISO

## A Note from the Author

I created this because `archinstall` annoyed me. It's too polished, too user-friendly. I wanted an installer that does exactly what I want, no questions asked. This is that installer.

**Warning:** This tool is tailor-made for my specific setup. It's probably broken for anyone else. It's not well-tested, not secure, and not particularly clever. It's a glorified bash script that works on my machine™.

If you're not me, you should probably use `archinstall` or the official Arch install guide. But if you are me, welcome home.

## What it does

The generated ISO includes my `/assets/install` script which:
- Installs a pre-configured GNOME desktop environment
- Sets up my essential tools and preferences
- Uses full disk encryption (LUKS2 + BTRFS)
- Can be tested in QEMU before real installation

**Default credentials (for testing):**
- User: `t`
- Password: `test`

## Prerequisites

- Arch Linux (or Arch-based distro)
- Required packages: `archiso`, `qemu-desktop`, `sgdisk`, `cryptsetup`, `just`
- Run as root or with sudo

## Usage

### Build the ISO
```bash
just build
```
Output: `images/archlinux-*.iso`

### Test in QEMU
```bash
just test
```
This builds the ISO (if needed), boots it in QEMU with automated install, then reboots into the installed system.

### Install on real hardware

1. Build the ISO and write it to USB
2. Boot the ISO and let the installer run
3. The installer will **not** partition automatically - you must partition manually first
4. Run `/assets/install` with your partition arguments

**⚠️ WARNING:** This will destroy all data on the target disk if you choose to automate partitioning!

## Manual Partitioning

If installing on real hardware, partition your disk first using `cgdisk`:

1. Create EFI partition (type `ef00`, size 512M)
2. Create XBOOTLDR partition (type `ea00`, size 1G) - optional but recommended
3. Create LUKS partition (type `8309`, uses remaining space)

Example with cgdisk:
```bash
cgdisk /dev/nvme0n1
# Partition 1: type ef00, size +512M
# Partition 2: type ea00, size +1G  (optional)
# Partition 3: type 8309, default (rest of disk)
```

## Install Script Arguments

The `/assets/install` script accepts these arguments:

```bash
./install --efi <EFI_PARTITION> --root <ROOT_PARTITION> [options]
```

**Required:**
- `--efi <partition>` - EFI system partition (e.g., /dev/nvme0n1p1)
- `--root <partition>` - Root partition for LUKS (e.g., /dev/nvme0n1p2)

**Optional:**
- `--xbootldr <partition>` - Additional boot partition (for separate /boot)
- `--test` - Skip confirmation prompts (used by automated testing)

**Example:**
```bash
./install --efi /dev/nvme0n1p1 --root /dev/nvme0n1p2
```

## Customization

Edit `/assets/install` to change:
- Hostname, timezone, locale
- Package selection
- User credentials
- Disk layout

Edit `/assets/autorun.sh` to modify the automated install behavior. Note: `autorun.sh` is only used for testing and automatically runs the installer in test mode.

## Notes

- Designed for UEFI systems with NVMe drives
- Uses systemd-boot as bootloader
- Full disk encryption with LUKS2
- BTRFS filesystem with swapfile
- Test mode uses a 10GB QEMU image
- **Partitioning automation is only for testing** - on real hardware you should partition manually first
- The installation is **semi-automated**: after manual partitioning, the `/assets/install` script handles everything else