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

KERNEL3=./scripts/make-kernel3
IMG3=./scripts/rpi3-stage1
IMAGE3=sudo ./scripts/rpi3-stage1
STG32=./scripts/rpi3-stage2

# clean
CLN=./scripts/clean
CLEAN=sudo ./scripts/clean


help:
	@echo
	@echo "Raspberry Pi Image Builder"
	@echo
	@echo "Usage: Focal Fossa"
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
	@echo
	@echo "RPi4B:"
	@echo " aacrh64"
	@echo "  make kernel              Builds linux kernel"
	@echo "  make image               Make bootable Ubuntu image"
	@echo "  make all                 Kernel > rootfs > image"
	@echo
	@echo "RPi3B/+:"
	@echo " aacrh64"
	@echo "  make rpi3-kernel         Builds linux kernel"
	@echo "  make rpi3-image          Make bootable Ubuntu image"
	@echo "  make rpi3-all            Kernel > rootfs > image"
	@echo
	@echo "Root filesystem:"
	@echo
	@echo "  make rootfs              Download Ubuntu arm64 rootfs"
	@echo
	@echo "Dialogrc:"
	@echo
	@echo "  make dialogrc            Set builder theme"
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
	# Making bootable Ubuntu image
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
	# Making bootable Ubuntu image
	@chmod +x ${IMG4}
	@chmod +x ${STG42}
	@${IMAGE4}

# Raspberry Pi 3 | aarch64
rpi3-kernel:
	# Linux | aarch64
	@chmod +x ${KERNEL3}
	@${KERNEL3}

rpi3-image:
	# Making bootable Ubuntu image
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
	# Making bootable Ubuntu image
	@chmod +x ${IMG3}
	@chmod +x ${STG32}
	@${IMAGE3}

# rootfs
rootfs:
	# ARM64 UBUNTU ROOTFS
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
##
