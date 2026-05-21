# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

This is the **XLibre edition** of AcreetionOS Cinnamon — one of three sibling display-server variants in the wider `AcreetionOS-Cinnamon` workspace (the others are `X11/` and `Wayland/`). See [`../CLAUDE.md`](../CLAUDE.md) for the workspace-level overview, including the rationale for the self-managed AcreetionOS repositories and how the three variants relate.

AcreetionOS is an **Arch Linux–based** distribution that pulls from its own curated repositories at `iso.acreetionos.org:8448` instead of upstream Arch — this is the deliberate stability mechanism. Do **not** re-add upstream Arch repos: per `Changes.md` it breaks the AcreetionOS keyring.

This repo is an `archiso` profile. Its build output is a bootable live ISO labeled `AcreetionOS_XL` (year-month).

## What XLibre is

XLibre is a 2025 fork of `xorg-server` started by Enrico Weigelt, who was xorg-server's most active contributor through 2024 before his merge requests stopped being accepted upstream. XLibre positions itself as the continuation of active X11 development as an alternative to Wayland, and ships features like the `Xnamespace` extension for isolating X11 clients between security domains (e.g. containers). Upstream: <https://x11libre.net/>.

## What makes this variant different from X11 / Wayland

The package swap from the standard X11 edition:

| Standard (X11) | XLibre (this variant) |
| --- | --- |
| `xorg-server` | `xlibre-xserver` |
| `xorg-server-common` | `xlibre-xserver-common` |
| `xf86-video-amdgpu` / `intel` / `nouveau` | `xlibre-video-amdgpu` / `intel` / `nouveau` |
| `xf86-input-libinput` | `xlibre-input-libinput` |

Other differences:

- ISO label is `AcreetionOS_XL` (vs `AcreetionOS`).
- `pacman.conf` enables `[acreetionOSREPO-main]` (→ `repo-main/$arch`); the X11 variant uses `[acreetionOSREPO]` instead.
- This repo does **not** carry the X11 variant's website assets, `chatbot-ui/`, `peertube/`, `installer/`, `Issues/`, or `.gitlab-ci.yml` — there is no CI for this variant.
- The `xlibre-*` packages are only available from the AcreetionOS repositories, not upstream Arch.

## Build Commands

- **Full build:** `./build.sh` — runs `./refresh.sh -j && ./mkarchiso.sh`, then `sudo rm -rf ./work`
- **mkarchiso only:** `./mkarchiso.sh` — invokes `mkarchiso` with the `AcreetionOS_XL` label and writes the ISO to `../ISO/`
- **Clean build artifacts:** `./refresh.sh` — `rm -rf work/ out/`
- **Recover after a failed build:** `./umount.sh` — lazy-unmounts virtual filesystems under `work/x86_64/airootfs/` before removing `work/`
- **Stamp build info:** `./generate-build-info.sh` — writes commit/date/user into `airootfs/etc/acreetion-build`
- **Apply Cinnamon overlay patches:** `./patch-cinnamon.sh` — copies `airootfs/cinnamon-configs/cinnamon-stuff/{usr,bin}/*` over `airootfs/usr/`
- **Build the colorized mkarchiso C wrapper** (optional): `make` (binary `mkarchiso_wrapper`); `sudo make install` to `/usr/local/bin/`

Builds require sudo (archiso needs loop-device access for squashfs). `work/` and `out/` are gitignored.

## Architecture (this profile)

- **`profiledef.sh`** — ISO metadata, boot modes (BIOS syslinux + UEFI ia32/x64 GRUB, ESP and El Torito), squashfs+xz+BCJ compression, and the explicit `file_permissions` map. **Any new executable script added to `airootfs/usr/bin/` or `airootfs/usr/local/bin/` must be listed here with `0:0:755`**, or archiso will not set it executable in the ISO.
- **`packages.x86_64`** — Package list installed into the live system. Primary divergence point from X11 (xlibre-* instead of xorg-server* / xf86-*).
- **`pacman.conf`** — Build-time repo configuration. Active: `[acreetionOSREPO-main]`, `[personal]`. Both at `iso.acreetionos.org:8448`. Sets `IgnorePkg = v4l2loopback-dkms`, `OverwriteFiles = *`, `ParallelDownloads = 25`.
- **`bootstrap_packages.x86_64`** — Minimal package set for the bootstrap tarball.
- **`airootfs/`** — Overlay copied verbatim onto the live root. Custom install/post-install scripts live in `airootfs/usr/bin/` and `airootfs/usr/local/bin/` (`calamares.sh`, `postinstall.sh`, `preinstall`, `stormos-final`, `setup-displays.sh`, `wifi-connection`, `fixkeys.sh`, `dd.sh`). Cinnamon customizations stage in `airootfs/cinnamon-configs/` and are merged into `airootfs/usr/` via `patch-cinnamon.sh`.
- **`grub/`**, **`syslinux/`**, **`efiboot/`** — Bootloader configurations.

## Installer

The live ISO ships **Calamares** (`calamares-git` + `calamares-config` from the custom repo) as the graphical installer, launched via `airootfs/usr/bin/calamares.sh`.

## Notes when editing

- This is one of three parallel variants. A change here is **not** automatically reflected in `../X11/` or `../Wayland/`; mirror manually if intended for those.
- The XLibre driver packages must be available in `[acreetionOSREPO-main]` before they can be installed into the live system at build time.
- `mkarchiso` (the binary at the root) is a vendored copy of the archiso script; the C source `mkarchiso.c` + `Makefile` produce a separate *colorized wrapper*, not a replacement for the script.
