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
LOCAL_MODULE := audio_processing
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc

LOCAL_SRC_FILES := \
	aec/aec_core.c \
	aec/aec_rdft.c \
	aec/aec_resampler.c \
	aec/echo_cancellation.c \
	aecm/aecm_core.c \
	aecm/echo_control_mobile.c \
	agc/agc.cc \
	agc/agc_manager_direct.cc \
	agc/histogram.cc \
	agc/legacy/analog_agc.c  \
	agc/legacy/digital_agc.c \
	agc/utility.cc \
	audio_buffer.cc \
	audio_processing_impl.cc \
	beamformer/array_util.cc \
	beamformer/covariance_matrix_generator.cc \
	beamformer/nonlinear_beamformer.cc \
	echo_cancellation_impl.cc \
	echo_control_mobile_impl.cc \
	gain_control_impl.cc \
	high_pass_filter_impl.cc \
	intelligibility/intelligibility_enhancer.cc \
	intelligibility/intelligibility_utils.cc \
	level_estimator_impl.cc \
	logging/aec_logging_file_handling.cc \
	noise_suppression_impl.cc \
	processing_component.cc \
	rms_level.cc \
	splitting_filter.cc \
	three_band_filter_bank.cc \
	transient/moving_moments.cc \
	transient/transient_detector.cc \
	transient/transient_suppressor.cc \
	transient/wpd_node.cc \
	transient/wpd_tree.cc \
	typing_detection.cc \
	utility/delay_estimator.c \
	utility/delay_estimator_wrapper.c \
	vad/gmm.cc \
	vad/pitch_based_vad.cc \
	vad/pitch_internal.cc \
	vad/pole_zero_filter.cc \
	vad/standalone_vad.cc \
	vad/vad_audio_proc.cc \
	vad/vad_circular_buffer.cc \
	vad/voice_activity_detector.cc \
	voice_detection_impl.cc \
	ns/noise_suppression_x.c \
	ns/nsx_core.c \
	ns/nsx_core_c.c \
	aecm/aecm_core_c.c


# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-DWEBRTC_NS_FIXED' \
    '-mfloat-abi=softfp' \
    '-fvisibility=hidden' 

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/../../.. \
    $(LOCAL_PATH)/../../../webrtc/modules/audio_coding/codecs/isac/main/include \
    $(LOCAL_PATH)/../../../webrtc/common_audio/vad/include \
    $(LOCAL_PATH)/../../../webrtc/common_audio/signal_processing/include \
    $(LOCAL_PATH)/../../../webrtc/common_audio/resampler/include \
    $(LOCAL_PATH)/../../../webrtc 


LOCAL_SHARED_LIBRARIES += -lpthread

LOCAL_STATIC_LIBRARIES += libcommon_audio
LOCAL_STATIC_LIBRARIES += libisac

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_CFLAGS := -DHAVE_NEON=1
endif

include $(BUILD_STATIC_LIBRARY)
