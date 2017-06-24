#!/bin/bash

# disk name
DISK_IMAGE_NAME=
# default disk name
DEFAULT_DISK_IMAGE_NAME=disk.img
# default kernel
DEFAULT_KERNEL=./kernel/vmlinuz
# default initramfs image
DEFAULT_INITRD=./kernel/initramfs.img
# default System.map file
DEFAULT_SYSTEM_MAP=./kernel/System.map
# default mount point, will be used during build
MOUNT_POINT=./mnt
# path to 0bt's stage0
STAGE0_PATH=./src/$(arch)/boot0_$(arch).bin
# boot partition
BOOT_PARTITION=$MOUNT_POINT/prt1
# root partition
ROOT_PARTITION=$MOUNT_POINT/prt2
# path to boot directory
BOOT_DIR=$BOOT_PARTITION/boot
# path to 0bt system directory
BOOTLOADER_DIR=$BOOT_DIR/0bt
# path to default rootfs used by this script
DEFAULT_ROOTFS=rootfs/minirootfs-x86_64.tar.gz

#
# Setup correct disk name
#
if [[ "$#" -eq 0 ]];
then
    DISK_IMAGE_NAME=$DEFAULT_DISK_IMAGE_NAME
fi

#
# Set disk name if it wasn't given
#
if [[ -z $DISK_IMAGE_NAME ]];
then
    DISK_IMAGE_NAME=$DEFAULT_DISK_IMAGE_NAME
fi

#
# mount boot partition
#
function mount_part_1() {
    sudo mkdir -p $BOOT_PARTITION
    if [[ -f $BOOT_PARTITION/mount ]];
    then
	echo "$BOOT_PARTITION" already mounted
	exit 1
    else
	LOOP_DEVICE_BOOT=$(sudo losetup -f)
	sudo losetup -o1048576 --sizelimit=499M $LOOP_DEVICE_BOOT $DISK_IMAGE_NAME
	sudo mount -t vfat $LOOP_DEVICE_BOOT $BOOT_PARTITION
	sudo touch $BOOT_PARTITION/mount
	echo "$LOOP_DEVICE_BOOT" | sudo tee $BOOT_PARTITION/mount	
    fi
    exit 0
}

#
# mount root partition
#
function mount_part_2() {
    sudo mkdir -p $ROOT_PARTITION
    if [[ -f $ROOT_PARTITION/mount ]];
    then
	echo "$ROOT_PARTITION" already mounted
	exit 1
    else
	LOOP_DEVICE_ROOT=$(sudo losetup -f)
	sudo losetup -o524288000 --sizelimit=3.5G $LOOP_DEVICE_ROOT $DISK_IMAGE_NAME
	sudo mount -t ext2 $LOOP_DEVICE_ROOT $ROOT_PARTITION
	sudo touch $ROOT_PARTITION/mount
	echo "$LOOP_DEVICE_ROOT" | sudo tee --append $ROOT_PARTITION/mount
    fi
    exit 0
}

#
# print usage of this script
#
function usage() {
    echo "populate-disk.sh - populate given disk with the kernel, initrd, bootloader and rootfs."
    echo
    echo "Usage: populate-disk.sh [SHORT OPTIONS]"
    echo "   or: populate-disk.sh [LONG OPTIONS]"
    echo 
    echo "  -k,--kernel    - specify kernel"
    echo "  -i,--initramfs - specify initial ramdisk"
    echo "  -s/--symbols   - specify symbols file"
    echo "  -d/--disk      - specify device name that should be populated"
    echo "  -u/--umount    - umount partitions"
    echo "  -h/--help      - prints this message"
    echo
    echo "Without any arguments given, the script will use default values."
    exit 0;
}

#
# set of command line options accepted by the populate-disk.sh
#
CLI_OPTS=$(getopt -o ud:hi:s:k: --long symbols,umount,disk,mount-first,mount-second,help,initramfs:,kernel: -n 'parse-options' -- "$@")

#
# Exit in a case of wrong options
#
if [[ "$?" != 0 ]];
then
    exit 1
fi

#
# umount partition and unbind loop device
#
function umount_partition() {
    echo "umount: $1"
    LOOP_DEVICE=$(cat $1/mount 2>/dev/null)
    echo $LOOP_DEVICE
    if [[ ! -z $LOOP_DEVICE ]];
    then
	sudo rm -rf $1/mount
	sudo umount $1
	sudo losetup -d $LOOP_DEVICE
    fi
}

#
# parse give command line options
#
while true; do
    case "$1" in
    -d | --disk )
	DISK_IMAGE_NAME="$1"
	shift 2
	;;
    -k | --kernel )
	DEFAULT_KERNEL="$2"
	shift 2
	;;
    -i | --initramfs )
	DEFAULT_INITRD="$2"
	shift 2
	;;
    -s | --symbols )
	DEFAULT_SYSTEM_MAP="$2"
	shift 2
	;;
    --mount-first )
	mount_part_1
	exit 0
	;;
    --mount-second )
	mount_part_2
	exit 0
	;;
    -u | --umount )
	umount_partition $BOOT_PARTITION
	umount_partition $ROOT_PARTITION
	exit 0
	;;
    -h | --help )
	usage
	;;
    *)
	break
	;;
    esac
done

#
# Bind disk partition to loop devices
#
LOOP_DEVICE_BOOT=$(sudo losetup -f)
sudo losetup -o1048576 --sizelimit=499M $LOOP_DEVICE_BOOT $DISK_IMAGE_NAME
LOOP_DEVICE_ROOT=$(sudo losetup -f)
sudo losetup -o524288000 --sizelimit=3.5G $LOOP_DEVICE_ROOT $DISK_IMAGE_NAME

#
# format boot partition to fat 32
#
sudo mkfs.vfat -F 32 $LOOP_DEVICE_BOOT

#
# format second partition to ext2
#
sudo mkfs.ext2 -F $LOOP_DEVICE_ROOT

#
# create boot and / directories
#
sudo mkdir -p $BOOT_PARTITION 
sudo mkdir -p $ROOT_PARTITION

#
# mount our default partitions
#
sudo mount -t vfat $LOOP_DEVICE_BOOT $BOOT_PARTITION
sudo mount -t ext2 $LOOP_DEVICE_ROOT $ROOT_PARTITION

#
# populate first partition
#
sudo mkdir -p $BOOTLOADER_DIR
sudo cp -r $STAGE0_PATH $BOOTLOADER_DIR
sudo cp -r $DEFAULT_KERNEL $DEFAULT_SYSTEM_MAP $DEFAULT_INITRD $BOOT_DIR

#
# populate second partition
#
sudo tar -xvzf $DEFAULT_ROOTFS -C $ROOT_PARTITION

#
# umount partitions
#
sudo umount $BOOT_PARTITION
sudo umount $ROOT_PARTITION

#
# unbind loop devices
#
sudo losetup -d $LOOP_DEVICE_BOOT
sudo losetup -d $LOOP_DEVICE_ROOT

echo "DONE."

exit 0
