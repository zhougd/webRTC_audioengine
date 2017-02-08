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
LOCAL_MODULE := rtc_base_approved
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
	bitbuffer.cc \
	buffer.cc \
	bufferqueue.cc \
	bytebuffer.cc \
    checks.cc \
    criticalsection.cc \
    event.cc \
    event_tracer.cc \
    exp_filter.cc \
    logging.cc \
    md5.cc \
    md5digest.cc \
    platform_file.cc \
    platform_thread.cc \
    random.cc \
    ratetracker.cc \
    stringencode.cc \
    stringutils.cc \
    systeminfo.cc \
    thread_checker_impl.cc \
    timeutils.cc


# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-mfpu=neon' \
    '-mfloat-abi=softfp' \
    '-fvisibility=hidden' 

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 
    
LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/.. \
    $(LOCAL_PATH)/../.. \
    $(LOCAL_PATH)/../../.. \


LOCAL_SHARED_LIBRARIES += -lpthread

ifeq ($(TARGET_OS)-$(TARGET_SIMULATOR),linux-true)
LOCAL_LDLIBS += -ldl -lpthread
endif

ifneq ($(TARGET_SIMULATOR),true)
LOCAL_SHARED_LIBRARIES += libdl
endif

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_CFLAGS := -DHAVE_NEON=1
endif

include $(BUILD_STATIC_LIBRARY)
#$(call import-module, cxx-stl/llvm-libc++)
#$(call import-module, cxx-stl/llvm-libc++abi)
#$(call import-module, cxx-stl/system)
$(call import-module, android/support)
