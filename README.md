# armutils

With [chroot](https://wiki.archlinux.org/index.php/Chroot) environments and [QEMU](https://wiki.archlinux.org/index.php/QEMU) it's possible to build Arch Linux packages for [ARM architectures](https://en.wikipedia.org/wiki/ARM_architecture) in a rather simple and convenient way. **armutils** provides the corresponding tools:

* `mkarmroot` creates an Arch Linux chroot environment for an ARM architecture from an image file. Such image files are provided by [Arch Linux ARM](https://archlinuxarm.org)
* `makearmpkg` builds a package in an ARM chroot environment

Both tools mimic the behaviour of `mkarchroot` and `makechrootpkg`.
