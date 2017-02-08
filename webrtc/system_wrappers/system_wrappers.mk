# Copyright (c) 2011 The WebRTC project authors. All Rights Reserved.
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
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := system_wrappers
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
	source/aligned_malloc.cc \
	source/atomic32_posix.cc \
	source/clock.cc \
	source/condition_variable.cc \
	source/condition_variable_posix.cc \
	source/cpu_info.cc \
	source/cpu_features.cc \
	source/critical_section.cc \
	source/critical_section_posix.cc \
	source/data_log_c.cc \
	source/data_log_no_op.cc \
	source/event.cc \
	source/event_timer_posix.cc \
	source/file_impl.cc \
	source/logcat_trace_context.cc \
	source/logging.cc \
	source/rtp_to_ntp.cc \
	source/rw_lock.cc \
	source/rw_lock_generic.cc \
	source/rw_lock_posix.cc \
	source/sleep.cc \
	source/sort.cc \
	source/tick_util.cc \
	source/timestamp_extrapolator.cc \
	source/trace_impl.cc \
	source/trace_posix.cc


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
    $(LOCAL_PATH)/../.. 


LOCAL_SHARED_LIBRARIES += -lpthread

ifeq ($(TARGET_OS)-$(TARGET_SIMULATOR),linux-true)
LOCAL_LDLIBS += -ldl -lpthread
endif

ifneq ($(TARGET_SIMULATOR),true)
LOCAL_SHARED_LIBRARIES += libdl
endif


include $(BUILD_STATIC_LIBRARY)
