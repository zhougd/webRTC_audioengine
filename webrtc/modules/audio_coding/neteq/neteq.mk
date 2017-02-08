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
LOCAL_MODULE := neteq
LOCAL_CPP_EXTENSION := .cc
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
     accelerate.cc \
     audio_classifier.cc \
     audio_decoder_impl.cc \
     audio_multi_vector.cc \
     audio_vector.cc \
     background_noise.cc \
     buffer_level_filter.cc \
     comfort_noise.cc \
     decision_logic.cc \
     decision_logic_fax.cc \
     decision_logic_normal.cc \
     decoder_database.cc \
     delay_manager.cc \
     delay_peak_detector.cc \
     dsp_helper.cc \
     dtmf_buffer.cc \
     dtmf_tone_generator.cc \
     expand.cc \
     merge.cc \
     nack.cc \
     neteq_impl.cc \
     neteq.cc \
     statistics_calculator.cc \
     normal.cc \
     packet_buffer.cc \
     payload_splitter.cc \
     post_decode_vad.cc \
     preemptive_expand.cc \
     random_vector.cc \
     rtcp.cc \
     sync_buffer.cc \
     timestamp_scaler.cc \
     time_stretch.cc

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
    $(LOCAL_PATH)/../../../.. \
    $(LOCAL_PATH)/../../../../chromium/src/third_party/opus/src/celt \
    $(LOCAL_PATH)/../../../codecs/isac/fix/include \
    $(LOCAL_PATH)/../../../../chromium/src/third_party/opus/src/include \
    $(LOCAL_PATH)/../../../../chromium/src/third_party/opus/src/celt \
    $(LOCAL_PATH)/../../../../chromium/src/third_party/opus/src/src \
    $(LOCAL_PATH)/../../../common_audio/resampler/include \
    $(LOCAL_PATH)/../../../common_audio/vad/include \
    $(LOCAL_PATH)/../../../common_audio/signal_processing/include 

LOCAL_STATIC_LIBRARIES += libg711
LOCAL_STATIC_LIBRARIES += libpcm16b
LOCAL_STATIC_LIBRARIES += libwebrtc_opus
LOCAL_STATIC_LIBRARIES += libopus
LOCAL_STATIC_LIBRARIES += libg722
LOCAL_STATIC_LIBRARIES += libisac_fix
LOCAL_STATIC_LIBRARIES += libisac_common
LOCAL_STATIC_LIBRARIES += libisac_neon
LOCAL_STATIC_LIBRARIES += libilbc
LOCAL_STATIC_LIBRARIES += libred
LOCAL_STATIC_LIBRARIES += libisac
LOCAL_STATIC_LIBRARIES += libcng

include $(BUILD_STATIC_LIBRARY)
