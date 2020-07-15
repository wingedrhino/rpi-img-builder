# menu
MENU=./lib/menu
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

# help
HELPER=./scripts/help

help:
	@echo
	@echo "Raspberry Pi Desktop Image Builder"
	@echo
	@echo "Usage: "
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
	@echo
	@echo "RPi4B:"
	@echo " aarch64"
	@echo "  make kernel              Builds linux kernel"
	@echo "  make image               Make bootable Debian image"
	@echo "  make all                 Kernel > rootfs > image"
	@echo
	@echo "Root filesystem:"
	@echo
	@echo "  make rootfs		  arm64"
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
	# Making bootable Debian image
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
	# Creating ROOTFS tarball
	@chmod +x ${RFSV8}
	@${ROOTFSV8}
	# Making bootable Debian image
	@chmod +x ${IMG4}
	@chmod +x ${STG42}
	@${IMAGE4}

# rootfs
rootfs:
	# ARM64 DEBIAN ROOTFS
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
	@chmod +x ${CONF}
	@${CONF}

dialogrc:
	# Builder theme set
	@${DIALOGRC}
	
helper:
	# Helper script
	@chmod +x ${HELPER}
	@${HELPER} -h

four:
	# BCM2711
	@chmod +x ${HELPER}
	@${HELPER} -4
