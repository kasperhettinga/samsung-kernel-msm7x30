#!/bin/bash
#

# Build Mackay kernel for p4wifi

# Set basic parameters
DATE_START=$(date +"%s")

MACKAY_VER="Mackay_1.3"

export ARCH=arm
export LOCALVERSION="-"`echo $MACKAY_VER`
# export CROSS_COMPILE=/home/kasper/android/cm101/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-
export CROSS_COMPILE=/home/kasper/android/toolchains/arm-cortex_a8-linux-gnueabi-linaro_4.7.3-2013.02/bin/arm-cortex_a8-linux-gnueabi-

BASE_DIR=/home/kasper/android/cm101/kernel/samsung
SOURCE_DIR=`echo $BASE_DIR`/msm7x30
OUTPUT_DIR=`echo $BASE_DIR`/output/ariesve
KERNEL_DIR=`echo $OUTPUT_DIR`/kernel
MODULES_DIR=`echo $OUTPUT_DIR`/modules

# Clean
rm $KERNEL_DIR/zImage
rm $MODULES_DIR/*

# Build
cd $SOURCE_DIR
make mackay_ariesve_defconfig
make -j4

# Move modules and kernel to output folder
# rm `echo $MODULES_DIR"/*"`

find $SOURCE_DIR -name '*.ko' -exec cp -v {} $MODULES_DIR \;
chmod 644 `echo $MODULES_DIR"/*"`

cp arch/arm/boot/zImage $KERNEL_DIR

DATE_END=$(date +"%s")
echo
DIFF=$(($DATE_END - $DATE_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
