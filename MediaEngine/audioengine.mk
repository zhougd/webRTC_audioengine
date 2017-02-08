
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
include $(LOCAL_PATH)/../android-webrtc.mk

LOCAL_MODULE:= audioengine
LOCAL_ARM_MODE := arm
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cpp

LOCAL_SRC_FILES := \
		MediaEngine_impl.cpp \
		MediaEngine.cpp 

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/. \
    $(LOCAL_PATH)/.. \
	$(LOCAL_PATH)/../webrtc \
	$(LOCAL_PATH)/../webrtc/voice_engine/include \
	$(LOCAL_PATH)/../webrtc/system_wrappers/include/

LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    -O3 \
    '-fvisibility=hidden'

LOCAL_STATIC_LIBRARIES := libvoice_engine
LOCAL_STATIC_LIBRARIES += libwebrtc_common
LOCAL_STATIC_LIBRARIES += libcommon_audio
LOCAL_STATIC_LIBRARIES += libpaced_sender
LOCAL_STATIC_LIBRARIES += libaudio_device
LOCAL_STATIC_LIBRARIES += libaudio_processing
LOCAL_STATIC_LIBRARIES += libaudio_coding_module
LOCAL_STATIC_LIBRARIES += libaudio_conference_mixer
LOCAL_STATIC_LIBRARIES += libmedia_file
LOCAL_STATIC_LIBRARIES += librtp_rtcp
LOCAL_STATIC_LIBRARIES += libwebrtc_utility
LOCAL_STATIC_LIBRARIES += libsystem_wrappers
LOCAL_STATIC_LIBRARIES += rtc_event_log
LOCAL_STATIC_LIBRARIES += librtc_base_approved
LOCAL_STATIC_LIBRARIES += libcpu_features_android
LOCAL_STATIC_LIBRARIES += libcpufeatures
LOCAL_STATIC_LIBRARIES += libaudio_encoder_interface
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
LOCAL_STATIC_LIBRARIES += librtc_event_log
LOCAL_STATIC_LIBRARIES += libprotobuf_lite
LOCAL_STATIC_LIBRARIES += libneteq
LOCAL_STATIC_LIBRARIES += libaudio_decoder_interface
LOCAL_STATIC_LIBRARIES += audio_encoder_interface
LOCAL_STATIC_LIBRARIES += librent_a_codec
LOCAL_STATIC_LIBRARIES += libisac
LOCAL_STATIC_LIBRARIES += libaudio_processing_neon
LOCAL_STATIC_LIBRARIES += libbitrate_controller
LOCAL_STATIC_LIBRARIES += libpaced_sender
LOCAL_STATIC_LIBRARIES += libremote_bitrate_estimator
LOCAL_STATIC_LIBRARIES += libhistogram


LOCAL_LDFLAGS :=-llog -landroid -lOpenSLES

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 


include $(BUILD_SHARED_LIBRARY)
