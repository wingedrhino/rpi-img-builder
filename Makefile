# menu
MENU=./lib/rpi4
CONF=./lib/config
DIALOGRC=$(shell cp -f lib/dialogrc ~/.dialogrc)

# rootfs
RFSV8=./scripts/make-rootfsv8
ROOTFSV8=sudo ./scripts/make-rootfsv8

# aarch64
KERNEL4=./scripts/make-kernel4
IMG4=./scripts/rpi4-stage1
IMAGE4=sudo ./scripts/rpi4-stage1
STG42=./scripts/rpi4-stage2

# clean
CLN=./scripts/clean
CLEAN=sudo ./scripts/clean


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
	@echo "  make install-native-depends"
	@echo
	@echo "  make kernel            Make linux kernel"
	@echo "  make rootfs            Make ROOTFS tarball"
	@echo "  make image             Make bootable Devuan image"
	@echo "  make all               Feeling lucky?"
	@echo
	@echo "For details consult the README.md"
	@echo

# aarch64
install-depends:
	# Install all dependencies:
	sudo apt install build-essential bison bc git dialog patch \
	dosfstools zip unzip qemu debootstrap qemu-user-static rsync \
	kmod cpio flex libssl-dev libncurses5-dev parted fakeroot swig \
	crossbuild-essential-arm64

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

# rootfs
rootfs:
	# ARM64 DEVUAN ROOTFS
	@chmod +x ${RFSV8}
	@${ROOTFSV8}

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
##
