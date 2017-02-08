
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

include $(LOCAL_PATH)/../../../../../../../android-webrtc.mk


LOCAL_ARM_MODE := arm
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := isac_neon
LOCAL_MODULE_TAGS := optional
LOCAL_ARM_NEON  := true
LOCAL_SRC_FILES := \
    entropy_coding_neon.c \
    filterbanks_neon.c \
    filters_neon.c \
    lattice_neon.c \
    transform_neon.c
    

# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    -mfpu=neon \
    -mfloat-abi=softfp \
    -flax-vector-conversions

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 


LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/../include \
    $(LOCAL_PATH)/../../../../../.. \
    $(LOCAL_PATH)/../../../../../../.. \
    $(LOCAL_PATH)/../../../../../../common_audio/resampler/include \
    $(LOCAL_PATH)/../../../../../../common_audio/vad/include \
    $(LOCAL_PATH)/../../../../../../common_audio/signal_processing/include 

include $(BUILD_STATIC_LIBRARY)
