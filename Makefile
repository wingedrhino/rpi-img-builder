# menu
MENU=./lib/menu
CONF=./lib/config
DIALOGRC=$(shell cp -f lib/dialogrc ~/.dialogrc)

# rootfs
RFSV8=./scripts/make-rootfsv8
ROOTFSV8=sudo ./scripts/make-rootfsv8
RFSV7=./scripts/make-rootfsv7
ROOTFSV7=sudo ./scripts/make-rootfsv7
RFSV6=./scripts/make-rootfsv6
ROOTFSV6=sudo ./scripts/make-rootfsv6

# aarch64
KERNEL4=./scripts/make-kernel4
IMG4=./scripts/rpi4-stage1
IMAGE4=sudo ./scripts/rpi4-stage1
STG42=./scripts/rpi4-stage2

KERNEL3=./scripts/make-kernel3
IMG3=./scripts/rpi3-stage1
IMAGE3=sudo ./scripts/rpi3-stage1
STG32=./scripts/rpi3-stage2

# armv6l
KERNEL0=./scripts/make-kernel0
IMG0=./scripts/rpi0-stage1
IMAGE0=sudo ./scripts/rpi0-stage1
STG02=./scripts/rpi0-stage2

# clean
CLN=./scripts/clean
CLEAN=sudo ./scripts/clean

# help
HELPER=./scripts/help

help:
	@echo
	@echo "Raspberry Pi Image Builder"
	@echo
	@echo "Usage: Beowulf"
	@echo
	@echo "  make install-depends   Install all dependencies"
	@echo "  make config            Create user data file"
	@echo "  make menu              User menu interface"
	@echo "  make cleanup           Clean up image errors"
	@echo "  make purge             Remove tmp directory"
	@echo "  make commands          List legacy commands"
	@echo
	@echo "For details consult the README.md"
	@echo

commands:
	@echo
	@echo "Install only native dependencies"
	@echo
	@echo "  make install-native-depends"
	@echo
	@echo "Boards:"
	@echo
	@echo "  rpi4                     Raspberry Pi 4B"
	@echo "  rpi3                     Raspberry Pi 3B/+"
	@echo "  rpi                      Raspberry Pi 0/0W/B/+"
	@echo
	@echo "RPi4B:"
	@echo " aarch64"
	@echo "  make kernel              Builds linux kernel"
	@echo "  make image               Make bootable Devuan image"
	@echo "  make all                 Kernel > rootfs > image"
	@echo
	@echo "RPi3B/+:"
	@echo " aarch64"
	@echo "  make rpi3-kernel         Builds linux kernel"
	@echo "  make rpi3-image          Make bootable Devuan image"
	@echo "  make rpi3-all            Kernel > rootfs > image"
	@echo
	@echo "RPi:"
	@echo " armv6l"	
	@echo "  make rpi-kernel         Builds linux kernel"
	@echo "  make rpi-image          Make bootable Devuan image"
	@echo "  make rpi-all            Kernel > rootfs > image"
	@echo
	@echo "Root filesystem:"
	@echo
	@echo "  make rootfs		  arm64"
	@echo "  make rootfsv6		  armel"
	@echo
	@echo "Dialogrc:"
	@echo
	@echo "  make dialogrc		  Set builder theme"
	@echo

# aarch64
install-depends:
	# Install all dependencies:
	sudo apt install build-essential bison bc git dialog patch \
	dosfstools zip unzip qemu debootstrap qemu-user-static rsync \
	kmod cpio flex libssl-dev libncurses5-dev parted fakeroot swig \
	crossbuild-essential-arm64 crossbuild-essential-armel

install-native-depends:
	# Install all dependencies:
	sudo apt install build-essential bison bc git dialog patch \
	dosfstools zip unzip qemu debootstrap qemu-user-static rsync \
	kmod cpio flex libssl-dev libncurses5-dev parted fakeroot swig

# Raspberry Pi 4 | aarch64
kernel:
	# Linux | aarch64
	@chmod +x ${KERNEL4}
	@${KERNEL4}

image:
	# Making bootable Devuan image
	@chmod +x ${IMG4}
	@chmod +x ${STG42}
	@${IMAGE4}

all:
	# RPi4B | AARCH64
	# - - - - - - - -
	#
	# Building linux
	@chmod +x ${KERNEL4}
	@${KERNEL4}
	# Downloading ROOTFS tarball
	@chmod +x ${RFSV8}
	@${ROOTFSV8}
	# Making bootable Devuan image
	@chmod +x ${IMG4}
	@chmod +x ${STG42}
	@${IMAGE4}

# Raspberry Pi 3 | aarch64
rpi3-kernel:
	# Linux | aarch64
	@chmod +x ${KERNEL3}
	@${KERNEL3}

rpi3-image:
	# Making bootable Devuan image
	@chmod +x ${IMG3}
	@chmod +x ${STG32}
	@${IMAGE3}

rpi3-all:
	# RPi3B/+ | AARCH64
	# - - - - - - - -
	#
	# Building linux
	@chmod +x ${KERNEL3}
	@${KERNEL3}
	# Downloading ROOTFS tarball
	@chmod +x ${RFSV8}
	@${ROOTFSV8}
	# Making bootable Devuan image
	@chmod +x ${IMG3}
	@chmod +x ${STG32}
	@${IMAGE3}

# Raspberry Pi | armv6l
rpi-kernel:
	# Linux | armv6l
	@chmod +x ${KERNEL0}
	@${KERNEL0}

rpi-image:
	# Make bootable Devuan image
	@chmod +x ${IMG0}
	@chmod +x ${STG02}
	@${IMAGE0}

rpi-all:
	# RPi | ARMV6L
	# - - - - - - - -
	#
	# Building linux
	@chmod +x ${KERNEL0}
	@${KERNEL0}
	# Downloading ROOTFS tarball
	@chmod +x ${RFSV6}
	@${ROOTFSV6}
	# Making bootable Devuan img
	@chmod +x ${IMG0}
	@chmod +x ${STG02}
	@${IMAGE0}

# rootfs
rootfs:
	# ARM64 DEVUAN ROOTFS
	@chmod +x ${RFSV8}
	@${ROOTFSV8}

rootfsv6:
	# ARMEL DEVUAN ROOTFS
	@chmod +x ${RFSV6}
	@${ROOTFSV6}

# clean and purge
cleanup:
	# Cleaning up
	@chmod +x ${CLN}
	@${CLEAN}

purge:
	# Removing tmp directory
	sudo rm -fdr rpi*

# menu
menu:
	# User menu interface
	@chmod +x ${MENU}
	@${MENU}

config:
	# User config menu
	@chmod go=rx files/scripts/*
	@chmod go=r files/misc/*
	@chmod go=r files/rules/*
	@chmod go=r files/users/*
	@chmod +x ${CONF}
	@${CONF}

dialogrc:
	# Builder theme set
	@${DIALOGRC}
	
helper:
	# Helper script
	@chmod +x ${HELPER}
	@${HELPER} -h

zero:
	# BCM2708
	@chmod +x ${HELPER}
	@${HELPER} -1

three:
	# BCM2710
	@chmod +x ${HELPER}
	@${HELPER} -3

four:
	# BCM2711
	@chmod +x ${HELPER}
	@${HELPER} -4
