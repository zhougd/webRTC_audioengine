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
LOCAL_MODULE := channel_transport
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
	channel_transport.cc \
	udp_socket_manager_posix.cc \
	udp_socket_manager_wrapper.cc \
	udp_socket_posix.cc \
	udp_socket_wrapper.cc \
	udp_transport_impl.cc
	


# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-fvisibility=hidden'

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 
    
LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/.. \
    $(LOCAL_PATH)/../../.. \
    $(LOCAL_PATH)/../../../chromium/src/testing/gtest/include \
    $(LOCAL_PATH)/../.. 


LOCAL_SHARED_LIBRARIES += -lpthread

ifeq ($(TARGET_OS)-$(TARGET_SIMULATOR),linux-true)
LOCAL_LDLIBS += -ldl -lpthread
endif

ifneq ($(TARGET_SIMULATOR),true)
LOCAL_SHARED_LIBRARIES += libdl
endif


include $(BUILD_STATIC_LIBRARY)
