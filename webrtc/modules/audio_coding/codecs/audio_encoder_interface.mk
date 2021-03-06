# Copyright (c) 2011 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

include $(LOCAL_PATH)/../../../../android-webrtc.mk

LOCAL_ARM_MODE := arm
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := audio_encoder_interface
LOCAL_CPP_EXTENSION := .cc
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
        audio_encoder.cc





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
    $(LOCAL_PATH)/../../.. \
    $(LOCAL_PATH)/../../../..


include $(BUILD_STATIC_LIBRARY)
