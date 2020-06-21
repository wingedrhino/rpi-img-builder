
# rpi-img-builder

Debian Image Builder for the Raspberry Pi 

The boards that are currently supported are;
* Raspberry Pi 4B (bcm2711)
* Raspberry Pi 3B/3B+ (bcm2709, bcm2837, bcm2837b0)
* Raspberry Pi 0/0W/1/+ (bcm2708, bcm2835)

### Downloadable Image

A bootable Debian image which has been compiled against Raspberry Pi's modified `Linux 5.4.40` (`aarch64 armv6l`) kernel can be found here;

* [`rpi-4-b-debian-buster`](https://github.com/pyavitz/rpi-img-builder/releases/download/5.4.40/rpi-4-b-debian-buster-2020-05-12-v8.7z)
* [`rpi-3-b-debian-buster`](https://github.com/pyavitz/rpi-img-builder/releases/download/5.4.40/rpi-3-b-debian-buster-2020-05-12-v8.7z)
* [`rpi-debian-buster`](https://github.com/pyavitz/rpi-img-builder/releases/download/5.4.40/rpi-debian-buster-2020-05-12.7z)

## Dependencies

In order to install the required dependencies, run the following command:

```
sudo apt install build-essential bison bc git dialog patch dosfstools zip unzip qemu debootstrap \
                 qemu-user-static rsync kmod cpio flex libssl-dev libncurses5-dev parted fakeroot \
                 swig crossbuild-essential-arm64 crossbuild-essential-armhf crossbuild-essential-armel
```

This has been tested on an AMD64/x86_64 system running on [Debian Buster](https://www.debian.org/releases/buster/debian-installer/).

Alternatively, you can run the command `make install-depends` in this directory.

## Instructions

* Make sure to adjust `config.txt` & `kernel.txt` with your own configurations before proceeding.

* Install all dependencies

```sh
make install-depends        # (cross compile)
make install-native-depends # (native compile)
```

* Compile the kernel

```sh
make kernel
```

* Prepare the rootfs

```sh
make rootfs
```

* Create a bootable Debian image

```sh
make image
```

* Clean up image errors

```sh
make cleanup
```

* Remove all tmp directories

```sh
make purge
```

## Command list (current)

#### Raspberry Pi 4B (default)

```sh
# AARCH64
make kernel
make image
make all

# ARMv7l
make kernelv7
make imagev7
make allv7
```

#### Raspberry Pi 3B/+

```sh
# AARCH64
make rpi3-kernel
make rpi3-image
make rpi3-all

# ARMv7l
make rpi3-kernelv7
make rpi3-imagev7
make rpi3-allv7
```

#### Raspberry Pi 0/0W/B/+

```sh
# ARMv6l
make rpi-kernel
make rpi-image
make rpi-all
```

#### Root Filesystems

```sh
make rootfs   # (arm64)
make rootfsv7 # (armhf)
make rootfsv6 # (armel)
```

#### Miscellaneous

```sh
make cleanup
make purge
make commands
```

## Usage

### Building the kernel

#### Modifying the selected kernel branch

```sh
kernel="linux-rpi" # See: https://github.com/raspberrypi/linux
version="5.4.y"    # Supported: 4.19.y | 5.4.y 
```

#### Flicking the switches

```sh
# 1 = active
# 0 = inactive

# --- default
crosscompile=1                    # cross compiling
menuconfig=0                      # open menuconfig
custom_defconfig=0                # your custom defconfig
MYCONFIG="nameofyour_defconfig"   # place in defconfig directory
```

#### Updating eeprom
```sh
nano ~/.eeprom
# EEPROM CONFIG
## https://archive.raspberrypi.org/debian/pool/main/r/rpi-eeprom/
EEPROM_VERSION="6.0" # change version number
```
Execute: `deb-eeprom-update`

---

### Support

Should you come across any issues, feel free to either open an issue on GitHub or talk with us directly by joining our channel on Freenode; [`#debianarm-port`](irc://irc.freenode.net/#debianarm-port)
