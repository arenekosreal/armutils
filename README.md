![REUSE status](https://api.reuse.software/badge/gitlab.com/mipimipi/armutils)](https://api.reuse.software/info/gitlab.com/mipimipi/armutils)
# armutils

With [chroot](https://wiki.archlinux.org/index.php/Chroot) environments and [QEMU](https://wiki.archlinux.org/index.php/QEMU) it's possible to build Arch Linux packages for [ARM architectures](https://en.wikipedia.org/wiki/ARM_architecture) in a rather simple and convenient way. **armutils** provides the corresponding tools:

* `mkarmroot` creates an Arch Linux chroot environment for an ARM architecture from an image file. Such image files are provided by [Arch Linux ARM](https://archlinuxarm.org)
* `makearmpkg` builds a package in an ARM chroot environment

Both tools mimic the behaviour of their x86_64 counterparts `mkarchroot` and `makechrootpkg`.

## mkarchroot

`mkarchroot` is an implementation of the approach described on [nerdstuff.org](https://nerdstuff.org/posts/2020/2020-003_simplest_way_to_create_an_arm_chroot/). The tool must be executed as root and called with:

* either an URL of an ARM image archive or the path of an image archive on the local file system. Such an image can be obtained from [Arch Linux ARM](https://archlinuxarm.org) for different ARM architectures.
* the desired path of the root directory of the new chroot environment
* a list of packages / package groups that shall be installed.

`mkarchroot` creates the root folder for the chroot environment, extracts the image files into it, updates the environment and installs the packages.

**Example:** The command

    mkarmroot -u http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz ./aarch64/root base-devel

creates a chroot environment for ARMv8 / AArch64 under the folder `./aarch64/root` and installs the package group `base-devel`.

## makearmpkg

`makearmpkg` is a fork of `makechrootpkg` with minor changes since `makechrootpkg` is tailored to run on x86_64 Arch Linux. Essentially, the calls of `arch-nspawn` are replaced by calls to `systemd-nspawn`. The interfaces and functionalities of `makearmpkg` and `makechrootpkg` are equal.

Also `makearmpkg` must be executed as root. It requires a chroot environment where the packages of `base-devel` are installed.
