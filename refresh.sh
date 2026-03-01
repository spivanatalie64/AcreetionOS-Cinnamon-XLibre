#!/bin/bash
# Robust cleanup for AcreetionOS-XLibre build environment

WORK_DIR="work/x86_64/airootfs"

echo "[*] Cleaning up build environment..."

# Unmount virtual filesystems if they are mounted
if [ -d "$WORK_DIR" ]; then
    sudo umount -l "$WORK_DIR/proc" 2>/dev/null
    sudo umount -l "$WORK_DIR/sys" 2>/dev/null
    sudo umount -l "$WORK_DIR/dev/pts" 2>/dev/null
    sudo umount -l "$WORK_DIR/dev" 2>/dev/null
    sudo umount -l "$WORK_DIR/run" 2>/dev/null
fi

# Recursive unmount for anything else in work/
if [ -d "work" ]; then
    sudo umount -R work/ 2>/dev/null
fi

# Remove work and out directories
sudo rm -rf work/ out/

echo "[✓] Environment refreshed."
