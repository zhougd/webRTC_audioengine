# Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

include $(LOCAL_PATH)/../../android-webrtc.mk

LOCAL_ARM_MODE := arm
LOCAL_MODULE := voice_engine
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
    channel.cc \
    channel_manager.cc \
    channel_proxy.cc \
    dtmf_inband.cc \
    dtmf_inband_queue.cc \
    level_indicator.cc \
    monitor_module.cc \
    network_predictor.cc \
    output_mixer.cc \
    shared_data.cc \
    statistics.cc \
    transmit_mixer.cc \
    utility.cc \
    voe_audio_processing_impl.cc \
    voe_base_impl.cc \
    voe_codec_impl.cc \
    voe_dtmf_impl.cc \
    voe_external_media_impl.cc \
    voe_file_impl.cc \
    voe_hardware_impl.cc \
    voe_neteq_stats_impl.cc \
    voe_network_impl.cc \
    voe_rtp_rtcp_impl.cc \
    voe_video_sync_impl.cc \
    voe_volume_control_impl.cc \
    voice_engine_impl.cc

# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-DOPUS_FIXED_POINT'

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/.. \
    $(LOCAL_PATH)/../.. \
    $(LOCAL_PATH)/../../webrtc \
    $(LOCAL_PATH)/../../chromium/third_party/opus/src/src \
    $(LOCAL_PATH)/../../chromium/third_party/opus/src/include \
    $(LOCAL_PATH)/../../chromium/third_party/opus/src/celt \
    $(LOCAL_PATH)/../common_audio/resampler/include \
    $(LOCAL_PATH)/../common_audio/signal_processing/include \
    $(LOCAL_PATH)/../common_audio/vad/include \
    $(LOCAL_PATH)/../modules/include \
    $(LOCAL_PATH)/../modules/audio_coding/include \
    $(LOCAL_PATH)/../modules/audio_device/include \
    $(LOCAL_PATH)/../modules/audio_processing/include

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libdl \
    libstlport

ifeq ($(TARGET_OS)-$(TARGET_SIMULATOR),linux-true)
LOCAL_LDLIBS += -ldl -lpthread
endif

ifneq ($(TARGET_SIMULATOR),true)
LOCAL_SHARED_LIBRARIES += libdl
endif

ifndef NDK_ROOT
include external/stlport/libstlport.mk
endif
include $(BUILD_STATIC_LIBRARY)
