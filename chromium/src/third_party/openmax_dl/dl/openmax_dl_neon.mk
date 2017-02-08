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
LOCAL_MODULE := openmax_dl_neon
LOCAL_CPP_EXTENSION := .cc
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
        sp/src/arm/neon/armSP_FFT_CToC_SC32_Radix2_fs_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC32_Radix2_ls_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC32_Radix4_fs_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC32_Radix4_ls_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC32_Radix2_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC32_Radix4_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC32_Radix8_fs_unsafe_s.S \
        sp/src/arm/neon/omxSP_FFTInv_CToC_SC32_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTFwd_CToC_SC32_Sfs_s.S \
        sp/src/arm/neon/armSP_FFTInv_CCSToR_S32_preTwiddleRadix2_unsafe_s.S \
        sp/src/arm/neon/omxSP_FFTFwd_RToCCS_S32_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTInv_CCSToR_S32_Sfs_s.S \
        sp/src/arm/neon/armSP_FFTInv_CCSToR_S16_preTwiddleRadix2_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC16_Radix2_fs_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC16_Radix2_ls_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC16_Radix2_ps_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC16_Radix2_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC16_Radix4_fs_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC16_Radix4_ls_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC16_Radix4_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_SC16_Radix8_fs_unsafe_s.S \
        sp/src/arm/neon/omxSP_FFTFwd_CToC_SC16_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTInv_CToC_SC16_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTFwd_RToCCS_S16_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTInv_CCSToR_S16_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTFwd_RToCCS_S16S32_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTInv_CCSToR_S32S16_Sfs_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_FC32_Radix2_fs_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_FC32_Radix2_ls_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_FC32_Radix4_fs_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_FC32_Radix4_ls_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_FC32_Radix2_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_FC32_Radix4_unsafe_s.S \
        sp/src/arm/neon/armSP_FFT_CToC_FC32_Radix8_fs_unsafe_s.S \
        sp/src/arm/neon/omxSP_FFTInv_CToC_FC32_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTFwd_CToC_FC32_Sfs_s.S \
        sp/src/arm/neon/armSP_FFTInv_CCSToR_F32_preTwiddleRadix2_unsafe_s.S \
        sp/src/arm/neon/omxSP_FFTFwd_RToCCS_F32_Sfs_s.S \
        sp/src/arm/neon/omxSP_FFTInv_CCSToR_F32_Sfs_s.S




# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-fvisibility=hidden' \
    '-mfpu=neon' \
    '-DDL_ARM_NEON_OPTIONAL'

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 


LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/ \
    $(LOCAL_PATH)/.. \
    $(LOCAL_PATH)/../../.. \
    $(LOCAL_PATH)/../../../..


LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libdl \
    libstlport

ifndef NDK_ROOT
include external/stlport/libstlport.mk
endif
include $(BUILD_STATIC_LIBRARY)
