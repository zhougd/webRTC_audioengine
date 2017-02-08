# Copyright (c) 2012 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

#############################
# Build the non-neon library.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

include $(LOCAL_PATH)/../../../../../../../android-webrtc.mk

LOCAL_ARM_MODE := arm
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := isac_fix
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
    arith_routines.c \
    arith_routines_hist.c \
    arith_routines_logist.c \
    audio_decoder_isacfix.cc \
    audio_encoder_isacfix.cc \
    bandwidth_estimator.c \
    decode.c \
    decode_bwe.c \
    decode_plc.c \
    encode.c \
    entropy_coding.c \
    fft.c \
    filterbank_tables.c \
    filterbanks.c \
    filters.c \
    initialize.c \
    isacfix.c \
    lattice.c \
    lpc_masking_model.c \
    lpc_tables.c \
    pitch_estimator.c \
    pitch_estimator_c.c \
    pitch_filter.c \
    pitch_gain_tables.c \
    pitch_lag_tables.c \
    spectrum_ar_model_tables.c \
    transform.c \
    transform_tables.c \
    lattice_armv7.S \
    pitch_filter_armv6.S


# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-fvisibility=hidden'

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 


LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../interface \
    $(LOCAL_PATH)/../include \
    $(LOCAL_PATH)/../../../../../.. \
    $(LOCAL_PATH)/../../../../../../.. \
    $(LOCAL_PATH)/../../../../../../common_audio/resampler/include \
    $(LOCAL_PATH)/../../../../../../common_audio/vad/include \
    $(LOCAL_PATH)/../../../../../../common_audio/signal_processing/include 

    
LOCAL_STATIC_LIBRARIES += libwebrtc_system_wrappers

include $(BUILD_STATIC_LIBRARY)

