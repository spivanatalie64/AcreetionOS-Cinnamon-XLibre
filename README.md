# AcreetionOS Cinnamon — XLibre Edition

Welcome to the **XLibre edition** of AcreetionOS Linux with the Cinnamon desktop environment. This build replaces the X.Org Server with **XLibre**, an actively maintained fork of `xorg-server`.

Download ISOs: <https://acreetionos.org>

## About AcreetionOS

AcreetionOS Linux is a community-driven, lightweight, and versatile distribution. It is currently **based on Arch Linux**, with the long-term goal of becoming a parallel\* distribution with its own base. The focus is simplicity, ease of use, stability, and up-to-date packages.

Unlike vanilla Arch, AcreetionOS does not consume the upstream Arch repositories at runtime. Instead it ships **self-managed repositories** hosted at `iso.acreetionos.org:8448` (`[acreetionOSREPO-main]`, `[personal]`). Curating the package set ourselves is how we offer end users a more stable, predictable experience on top of an Arch-style rolling base.

## About this edition (XLibre)

This edition uses **XLibre** — a 2025 fork of `xorg-server` started by Enrico Weigelt, who was xorg-server's most active contributor through 2024 before his merge requests stopped being accepted upstream and his Freedesktop GitLab account was blocked. XLibre positions itself as the continuation of active X11 development, as a deliberate alternative to Wayland, and ships features such as the `Xnamespace` extension for isolating X11 clients between security domains (e.g. containers).

The package swap from the standard X.Org edition:

| Standard (X11) | XLibre edition |
| --- | --- |
| `xorg-server` | `xlibre-xserver` |
| `xorg-server-common` | `xlibre-xserver-common` |
| `xf86-video-amdgpu` / `intel` / `nouveau` | `xlibre-video-amdgpu` / `intel` / `nouveau` |
| `xf86-input-libinput` | `xlibre-input-libinput` |

The ISO is labeled `AcreetionOS_XL` to distinguish it from the standard build.

Why pick this edition:

- You want a still-actively-developed X11 server with new features and ongoing patches.
- You're interested in `Xnamespace` and other XLibre-specific capabilities.
- You want to support the XLibre project.

Pick a different edition if:

- You need the most broadly-tested X11 stack — go with the **[X11 edition](../X11/)**.
- You want the modern, secure, per-frame-perfect display protocol — the **[Wayland edition](../Wayland/)** is reserved for that (not yet released).

## Features

- Lightweight Arch-based system with the Cinnamon desktop
- XLibre display server in place of X.Org
- Curated package set from AcreetionOS's own repositories
- Calamares graphical installer
- Both BIOS (SYSLINUX) and UEFI ia32/x64 (GRUB) boot support
- x86_64

## Getting Started (End Users)

1. Download the XLibre ISO (`AcreetionOS_XL_*.iso`) from <https://acreetionos.org>.
2. Write it to a USB drive with [Etcher](https://etcher.balena.io/#download-etcher), [Rufus](https://rufus.ie/en/), or [Ventoy](https://ventoy.net/en/index.html).
3. Boot from USB and follow the on-screen installation steps.

> **Ventoy users:** you must use **GRUB Mode 2**. Plain GRUB will not boot the ISO correctly.

## Building the ISO yourself

This repository **is** an `archiso` profile. Build it on an Arch (or AcreetionOS) host with `archiso` installed:

```bash
./build.sh           # refreshes work/, runs mkarchiso, cleans up
# or, step by step:
./refresh.sh         # rm -rf work/ out/
./mkarchiso.sh       # runs mkarchiso with the AcreetionOS_XL label
./umount.sh          # if a previous build left bind mounts in work/
```

The resulting ISO is written to `../ISO/`. Builds require sudo (loop devices for squashfs). The `xlibre-*` packages are pulled from the AcreetionOS repositories — they are not in upstream Arch.

For deeper architectural notes (profile layout, `airootfs/`, file-permission gotchas, etc.) see [`CLAUDE.md`](./CLAUDE.md) in this directory, or [`../CLAUDE.md`](../CLAUDE.md) for the workspace-level overview.

## Contributing

Contributions are welcome. See the [Contributor Guide](https://github.com/AcreetionOS/AcreetionOSDocumentationPlan/blob/main/documentation/contributor-guide.md). For bug reports and feature requests, [open an issue](https://github.com/cobra3282000/acreetionos/issues).

To learn more about XLibre upstream, see <https://x11libre.net/>.

## Roadmap

The current goal is a stable AcreetionOS release by the end of 2026. Track progress on the [project roadmap](https://github.com/cobra3282000/acreetionos/projects).

## Project Information

- **Status:** In active development
- **License:** GPL-3.0
- **Maintainers:** Darren Clift (@cobra3282000), Natalie Spiva (@spivanatalie64)

---

\* *Parallel distribution: a distribution similar to, but with a different goal set than, its upstream.*
---

## 🤖 Pullfrog AI Review

This repository uses **Pullfrog AI** to automatically review pull requests.

Pullfrog is an AI-powered code review agent that analyzes every PR for code quality,
security issues, performance problems, and best practice violations. Reviews appear
as inline PR comments and checks. Trigger manually by commenting `@pullfrog` on any PR.

Powered by OpenRouter.