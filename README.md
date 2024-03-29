**armutils will no longer be maintained**

[![REUSE status](https://api.reuse.software/badge/gitlab.com/mipimipi/armutils)](https://api.reuse.software/info/gitlab.com/mipimipi/armutils)
# armutils

With [chroot](https://wiki.archlinux.org/index.php/Chroot) environments and [QEMU](https://wiki.archlinux.org/index.php/QEMU) it's possible to build Arch Linux packages for [ARM architectures](https://en.wikipedia.org/wiki/ARM_architecture) in a rather simple and convenient way. **armutils** provides the corresponding tools:

* `mkarmchroot` creates an Arch Linux chroot environment for an ARM architecture from an image file. Such image files can be downloaded from [Arch Linux ARM](https://archlinuxarm.org)
* `arm-nspawn` spawns a command in an ARM chroot environment, wrapping `systemd-nspawn`
* `makearmpkg` builds a package in an ARM chroot environment

These tools mimic the behaviour of their x86_64 counterparts `mkarchroot`, `arch-nspawn` and `makechrootpkg`. [qemu-user-static](https://archlinux.org/packages/?name=qemu-user-static) and [qemu-user-static-binfmt](https://archlinux.org/packages/?name=qemu-user-static-binfmt) are used to "translate" between the ARM chroot and the x86_64 host.

## mkarmchroot

`mkarmchroot` is an implementation of the approach described on [nerdstuff.org](https://nerdstuff.org/posts/2020/2020-003_simplest_way_to_create_an_arm_chroot/). The tool must be called with:

* either an URL of an ARM image archive or the path of an image archive on the local file system. Such an image can be obtained from [Arch Linux ARM](https://archlinuxarm.org) for different ARM architectures.
* the desired path of the root directory of the new chroot environment
* a list of packages / package groups that shall be installed.

`mkarmchroot` creates the root folder for the chroot environment, extracts the image files into it, updates the environment and installs the packages.

## arm-nspawn

`arm-nspawn` is a fork of `arch-nspawn` with major changes since `arch-nspawn` is made to be used for x86_64 chroot environments. The interfaces of both commands are almost equal - `arm-nspawn`does not provide the `-s` option.

**Using `arch-chroot` to execute commands in ARM chroots can lead to strange error messages, therefore I recommended to use `arm-nspawn`instead.**

## makearmpkg

`makearmpkg` is a fork of `makechrootpkg` with minor changes since `makechrootpkg` is made to be used for x86_64 chroot environments. The calls of `arch-nspawn` are replaced by calls of `arm-nspawn`. The interfaces and functionalities of `makearmpkg` and `makechrootpkg` are equal. It requires a chroot environment where the packages of `base-devel` are installed.

## Example

The command

    $ mkarmchroot -u http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz <YOUR-PATH>/aarch64/root base-devel

creates a chroot environment for ARMv8 / AArch64 under the folder `<YOUR-PATH>/aarch64/root` and installs the package group `base-devel`.

If the PKGBUILD file of an [AUR](https://aur.archlinux.org) package is stored in `<YOUR-PATH>/pkg`, the package can be built with:

    $ cd <YOUR-PATH>/pkg
    $ sudo makearmpkg -r ../aarch64 -- -c --syncdeps --noconfirm

The options `-c`, `--syncdeps` and `--noconfirm` are passed to `makepkg`. `makapkg` cleans the working directory after the build (`-c`), installs missing dependencies (`--syncdeps`) and suppresss user input (`--noconfirm`).
