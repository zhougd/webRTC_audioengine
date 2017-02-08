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

LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := webrtc_utility
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
    audio_frame_operations.cc \
    coder.cc \
    file_player_impl.cc \
    file_recorder_impl.cc \
    helpers_android.cc \
    jvm_android.cc \
    process_thread_impl.cc


# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-DWEBRTC_MODULE_UTILITY_VIDEO'

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 


LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../interface \
    $(LOCAL_PATH)/../../interface \
    $(LOCAL_PATH)/../../audio_coding/main/interface \
    $(LOCAL_PATH)/../../.. \
    $(LOCAL_PATH)/../../../.. \
    $(LOCAL_PATH)/../../../../../webrtc/modules/inlude \
    $(LOCAL_PATH)/../../../../../chromium/src/third_party/opus/src/src \
    $(LOCAL_PATH)/../../../../../chromium/src/third_party/opus/src/celt \
    $(LOCAL_PATH)/../../../../../chromium/src/third_party/opus/src/include \
    $(LOCAL_PATH)/../../../common_audio/resampler/include \
    $(LOCAL_PATH)/../../../common_audio/vad/include \
    $(LOCAL_PATH)/../../../common_audio/signal_processing/include \
    external/webrtc

LOCAL_STATIC_LIBRARIES += libmedia_file
include $(BUILD_STATIC_LIBRARY)


