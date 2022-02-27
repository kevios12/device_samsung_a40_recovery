#
# Copyright (C) 2019 The Android Open Source Project
# Copyright (C) 2019 The TWRP Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FDEVICE="a40"
FOX_BUILD_LOG_FILE="$(pwd)/log.txt"

#Get target device for orangefox build
fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep $FDEVICE)
   if [ -n "$chkdev" ]; then
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

    export FOX_VERSION=R11.1
    export OF_MAINTAINER="Karou"
    export FOX_BUILD_TYPE="Better_than_official"

    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1

    # a40 specific flags
    export TARGET_DEVICE_ALT="a40"
    export FOX_RECOVERY_INSTALL_PARTITION="/dev/block/platform/13500000.dwmmc0/by-name/recovery"
    export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/platform/13500000.dwmmc0/by-name/system"
    export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/platform/13500000.dwmmc0/by-name/vendor"
    export OF_AB_DEVICE=0
    export OF_DISABLE_MIUI_SPECIFIC_FEATURES="1"
    export OF_FLASHLIGHT_ENABLE="1"
    export OF_SCREEN_H=2340
    export OF_STATUS_H=80
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_TWRP_COMPATIBILITY_MODE="1"
    export OF_CLOCK_POS=1

    # Orange_fox R11 flags
    export FOX_R11="1"
    export FOX_BUILD_TYPE="Stable"
    export FOX_VERSION="R11.1"
    export FOX_ADVANCED_SECURITY="1"
    export OF_USE_TWRP_SAR_DETECT="1"
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT="1"
    export OF_QUICK_BACKUP_LIST="/boot;/data;/system_image;/vendor_image;"
    export OF_RUN_POST_FORMAT_PROCESS=1
    export FOX_USE_LZMA_COMPRESSION=1
    export FOX_USE_NANO_EDITOR=1
    export FOX_USE_BASH_SHELL="1"
    export FOX_DELETE_AROMAFM=1
    export FOX_ASH_IS_BASH="1"
    export FOX_USE_TAR_BINARY="1"
    export FOX_USE_ZIP_BINARY="1"
    export FOX_REPLACE_BUSYBOX_PS="1"
    export OF_USE_NEW_MAGISKBOOT="1"
    export OF_SKIP_MULTIUSER_FOLDERS_BACKUP="1"

    # Common flags
    export TARGET_ARCH=arm64
    export ALLOW_MISSING_DEPENDENCIES=true
    export LC_ALL="C"
    export PLATFORM_VERSION="16.1.0"
    export PLATFORM_SECURITY_PATCH="2099-12-31"
    export TW_DEFAULT_LANGUAGE="en"
    export OF_KEEP_FORCED_ENCRYPTION="1"
    export OF_PATCH_AVB20="1"
    export OF_USE_MAGISKBOOT="1"
    export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES="1"
    export OF_DONT_PATCH_ENCRYPTED_DEVICE="1"
    export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER="1"
    export OF_NO_TREBLE_COMPATIBILITY_CHECK="1"
    export FOX_USE_LZMA_COMPRESSION="1"
    export LZMA_RAMDISK_TARGETS="recovery"
    export OF_FL_PATH1="/sbin/flashlight"
    export OF_FL_PATH2=""

    # use system (ROM) fingerprint where available
    export OF_USE_SYSTEM_FINGERPRINT="1"

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi

  	for var in eng user userdebug; do
  		add_lunch_combo omni_"$FDEVICE"-$var
  	done
fi
