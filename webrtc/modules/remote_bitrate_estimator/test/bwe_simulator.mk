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
LOCAL_MODULE := bwe_simulator
LOCAL_MODULE_TAGS := optional
LOCAL_ARM_MODE := arm
LOCAL_CPP_EXTENSION := .cc
LOCAL_GENERATED_SOURCES :=
LOCAL_SRC_FILES := \
        bwe.cc \
        bwe_test.cc \
        bwe_test_baselinefile.cc \
        bwe_test_fileutils.cc \
        bwe_test_framework.cc \
        bwe_test_logging.cc \
        metric_recorder.cc \
        packet_receiver.cc \
        packet_sender.cc \
        estimators/nada.cc \
        estimators/remb.cc \
        estimators/send_side.cc \
        estimators/tcp.cc


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
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/../../../../chromium/src/ \
    $(LOCAL_PATH)/../../../../chromium/src/testing/gtest/include \
    $(LOCAL_PATH)/../../../../base/.. \
    $(LOCAL_PATH)/../../modules/rtp_rtcp/interface

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libdl \
    libstlport

ifndef NDK_ROOT
include external/stlport/libstlport.mk
endif
include $(BUILD_STATIC_LIBRARY)
