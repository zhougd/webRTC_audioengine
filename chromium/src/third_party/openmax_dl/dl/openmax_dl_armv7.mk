# Copyright (c) 2011 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

include $(LOCAL_PATH)/../../../../../android-webrtc.mk

LOCAL_ARM_MODE := arm
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := openmax_dl_armv7
LOCAL_CPP_EXTENSION := .cc
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
        sp/src/arm/armv7/armSP_FFT_CToC_FC32_Radix2_fs_unsafe_s.S \
        sp/src/arm/armv7/armSP_FFT_CToC_FC32_Radix4_fs_unsafe_s.S \
        sp/src/arm/armv7/armSP_FFT_CToC_FC32_Radix4_unsafe_s.S \
        sp/src/arm/armv7/armSP_FFT_CToC_FC32_Radix8_fs_unsafe_s.S \
        sp/src/arm/armv7/omxSP_FFTInv_CToC_FC32_Sfs_s.S \
        sp/src/arm/armv7/omxSP_FFTFwd_CToC_FC32_Sfs_s.S \
        sp/src/arm/armv7/armSP_FFTInv_CCSToR_F32_preTwiddleRadix2_unsafe_s.S \
        sp/src/arm/armv7/omxSP_FFTFwd_RToCCS_F32_Sfs_s.S \
        sp/src/arm/armv7/omxSP_FFTInv_CCSToR_F32_Sfs_s.S \
        sp/src/arm/detect.c

# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-fvisibility=hidden'  \
    '-DDL_ARM_NEON_OPTIONAL'

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 


LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/ \
    $(LOCAL_PATH)/.. \
    $(LOCAL_PATH)/../../.. \
    $(LOCAL_PATH)/../../../.. \
    $NDK_ROOT/source/cpufeatures


LOCAL_STATIC_LIBRARIES := cpufeatures

include $(BUILD_STATIC_LIBRARY)

$(call import-module, android/cpufeatures)
