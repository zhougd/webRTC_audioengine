
# Copyright (c) 2011 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

include $(LOCAL_PATH)/../../../android-webrtc.mk

LOCAL_ARM_MODE := arm
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := audio_device
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
    audio_device_buffer.cc \
    audio_device_generic.cc \
    dummy/audio_device_dummy.cc \
    dummy/file_audio_device.cc \
    fine_audio_buffer.cc \
    dummy/file_audio_device_factory.cc \
    android/audio_manager.cc \
    android/audio_record_jni.cc \
    android/audio_track_jni.cc \
    android/build_info.cc \
    android/opensles_common.cc \
    android/opensles_player.cc \
    audio_device_impl.cc

# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) 

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_STATIC_LIBRARIES += librtc_base_approved


LOCAL_C_INCLUDES := \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/android \
    $(LOCAL_PATH)/dummy \
    $(LOCAL_PATH)/../.. \
    $(LOCAL_PATH)/../include \
    $(LOCAL_PATH)/../../.. \
    $(LOCAL_PATH)/../../../.. \
    $(LOCAL_PATH)/../../../common_audio/resampler/include \
    $(LOCAL_PATH)/../../../common_audio/signal_processing/include \
    $(LOCAL_PATH)/../../../common_audio/vad/include \
    $(LOCAL_PATH)/../../../system_wrappers/interface

include $(BUILD_STATIC_LIBRARY)
