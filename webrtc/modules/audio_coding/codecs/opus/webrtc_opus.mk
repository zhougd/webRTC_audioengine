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

LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := webrtc_opus
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
    audio_decoder_opus.cc \
    audio_encoder_opus.cc \
    opus_interface.c


# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-fvisibility=hidden'


LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 


LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/interface \
    $(LOCAL_PATH)/../../../../.. \
    $(LOCAL_PATH)/../../../../../chromium/src/third_party/opus/src/include

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libdl \
    libstlport

ifndef NDK_ROOT
include external/stlport/libstlport.mk
endif
include $(BUILD_STATIC_LIBRARY)
