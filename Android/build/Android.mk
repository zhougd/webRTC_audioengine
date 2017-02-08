
#LOCAL_PATH := $(call my-dir)
#include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm
MY_SIP_ENGINE_BUILD_ROOT_PATH := $(call my-dir)

MY_WEBRTC_SRC_PATH :=../../webrtc

MY_CHROMIUM_SRC_PATH :=../../chromium

include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/common_audio/common_audio.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/common_audio/common_audio_neon.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/system_wrappers/cpu_features_android.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/system_wrappers/field_trial_default.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/system_wrappers/metrics_default.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/system_wrappers/system_wrappers.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/base/rtc_base_approved.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_processing/audio_processing.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_processing/audio_processing_neon.mk

include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/neteq/neteq.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/acm2/audio_coding_module.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/acm2/rent_a_codec.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_conference_mixer/audio_conference_mixer.mk
#include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/neteq/tools/rtpcat.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/audio_decoder_interface.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/audio_encoder_interface.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/cng/cng.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/g711/g711.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/red/red.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/g722/g722.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/pcm16b/pcm16b.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/ilbc/ilbc.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/opus/webrtc_opus.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/isac/fix/source/isac_fix.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/isac/isac_common.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/isac/main/source/isac.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_coding/codecs/isac/fix/source/isac_neon.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/webrtc_common.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/rtc_event_log.mk

#include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/test/channel_transport/channel_transport.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/test/histogram.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/remote_bitrate_estimator/remote_bitrate_estimator.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/remote_bitrate_estimator/tools/rtp_to_text.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/remote_bitrate_estimator/tools/bwe_tools_util.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/remote_bitrate_estimator/test/bwe_simulator.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/rtp_rtcp/source/rtp_rtcp.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/utility/source/webrtc_utility.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/bitrate_controller/bitrate_controller.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/media_file/media_file.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/pacing/paced_sender.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/modules/audio_device/audio_device.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/voice_engine/voice_engine.mk
#include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/base/rtc_base.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_CHROMIUM_SRC_PATH)/src/third_party/openmax_dl/dl/openmax_dl.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_CHROMIUM_SRC_PATH)/src/third_party/openmax_dl/dl/openmax_dl_armv7.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_CHROMIUM_SRC_PATH)/src/third_party/openmax_dl/dl/openmax_dl_neon.mk
include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_CHROMIUM_SRC_PATH)/src/third_party/opus/opus.mk

include $(MY_SIP_ENGINE_BUILD_ROOT_PATH)/$(MY_WEBRTC_SRC_PATH)/../MediaEngine/audioengine.mk



