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
LOCAL_MODULE := openmax_dl
LOCAL_CPP_EXTENSION := .cc
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
        sp/src/armSP_FFT_F32TwiddleTable.c \
        sp/src/arm/armSP_FFT_S32TwiddleTable.c \
        sp/src/arm/omxSP_FFTGetBufSize_C_FC32.c \
        sp/src/arm/omxSP_FFTGetBufSize_C_SC32.c \
        sp/src/arm/omxSP_FFTGetBufSize_R_F32.c \
        sp/src/arm/omxSP_FFTGetBufSize_R_S32.c \
        sp/src/arm/omxSP_FFTInit_C_FC32.c \
        sp/src/arm/omxSP_FFTInit_R_F32.c \
        sp/src/arm/omxSP_FFTGetBufSize_C_SC16.c \
        sp/src/arm/omxSP_FFTGetBufSize_R_S16.c \
        sp/src/arm/omxSP_FFTGetBufSize_R_S16S32.c \
        sp/src/arm/omxSP_FFTInit_C_SC16.c \
        sp/src/arm/omxSP_FFTInit_C_SC32.c \
        sp/src/arm/omxSP_FFTInit_R_S16.c \
        sp/src/arm/omxSP_FFTInit_R_S16S32.c \
        sp/src/arm/omxSP_FFTInit_R_S32.c





# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-DNETEQ_VOICEENGINE_CODECS' \
    '-fvisibility=hidden'

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
