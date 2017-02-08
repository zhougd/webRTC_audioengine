/*
 *  Copyright (c) 2013 The WebRTC project authors. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license
 *  that can be found in the LICENSE file in the root of the source
 *  tree. An additional intellectual property rights grant can be found
 *  in the file PATENTS.  All contributing project authors may
 *  be found in the AUTHORS file in the root of the source tree.
 */

#include "webrtc/modules/audio_device/android/audio_manager.h"
#include "webrtc/modules/audio_device/android/audio_track_jni.h"

#include <android/log.h>

#include "webrtc/base/arraysize.h"
#include "webrtc/base/checks.h"
#include "webrtc/base/format_macros.h"

#define TAG "newEngineTest AudioTrackJni"
#define ALOGV(...) __android_log_print(ANDROID_LOG_VERBOSE, TAG, __VA_ARGS__)
#define ALOGD(...) __android_log_print(ANDROID_LOG_DEBUG, TAG, __VA_ARGS__)
#define ALOGE(...) __android_log_print(ANDROID_LOG_ERROR, TAG, __VA_ARGS__)
#define ALOGW(...) __android_log_print(ANDROID_LOG_WARN, TAG, __VA_ARGS__)
#define ALOGI(...) __android_log_print(ANDROID_LOG_INFO, TAG, __VA_ARGS__)

namespace webrtc {

// AudioTrackJni::JavaAudioTrack implementation.
AudioTrackJni::JavaAudioTrack::JavaAudioTrack(
    NativeRegistration* native_reg, rtc::scoped_ptr<GlobalRef> audio_track)
    : audio_track_(audio_track.Pass()),
      native_reg_(native_reg),
      init_playout_(native_reg->GetMethodId("initPlayout", "(II)V")),
      start_playout_(native_reg->GetMethodId("startPlayout", "()Z")),
      stop_playout_(native_reg->GetMethodId("stopPlayout", "()Z")),
      set_stream_volume_(native_reg->GetMethodId("setStreamVolume", "(I)Z")),
      get_stream_max_volume_(native_reg->GetMethodId(
          "getStreamMaxVolume", "()I")),
      get_stream_volume_(native_reg->GetMethodId("getStreamVolume", "()I")) {
    ALOGD("JavaAudioTrack init_playout_ id:%d", init_playout_);
    ALOGD("JavaAudioTrack start_playout_ id:%d", start_playout_);   
    ALOGD("JavaAudioTrack stop_playout_ id:%d", stop_playout_);       
    ALOGD("JavaAudioTrack set_stream_volume_ id:%d", set_stream_volume_);   
    ALOGD("JavaAudioTrack get_stream_max_volume_ id:%d", get_stream_max_volume_);   
}

AudioTrackJni::JavaAudioTrack::~JavaAudioTrack() {}

void AudioTrackJni::JavaAudioTrack::InitPlayout(int sample_rate, int channels) {
  
  //if(test.attached_) {
    //native_reg_->jni_ = test.jni_current;
  //  native_reg_->setCurrentJNI(test.jni_current);
  //  audio_track_->jni_ = test.jni_current;
 //   init_playout_ = native_reg_->GetMethodId("initPlayout", "(II)V");
 //}
  ALOGD("CallVoidMethod AudioTrackJni::JavaAudioTrack::InitPlayout id:%d", init_playout_);
  audio_track_->CallVoidMethod(init_playout_, sample_rate, channels);
}

bool AudioTrackJni::JavaAudioTrack::StartPlayout() {
  return audio_track_->CallBooleanMethod(start_playout_);
}

bool AudioTrackJni::JavaAudioTrack::StopPlayout() {
  return audio_track_->CallBooleanMethod(stop_playout_);
}

bool AudioTrackJni::JavaAudioTrack::SetStreamVolume(int volume) {
  return audio_track_->CallBooleanMethod(set_stream_volume_, volume);
}

int AudioTrackJni::JavaAudioTrack::GetStreamMaxVolume() {
  return audio_track_->CallIntMethod(get_stream_max_volume_);
}

int AudioTrackJni::JavaAudioTrack::GetStreamVolume() {
  return audio_track_->CallIntMethod(get_stream_volume_);
}

bool AudioTrackJniRunFunction(void* obj) {
  //ALOGD("AudioTrackJniRunFunction:%s", GetThreadInfo().c_str());
  AudioTrackJni *track = (AudioTrackJni*)obj;
  track->DoOperacation();
  return true;
}
// TODO(henrika): possible extend usage of AudioManager and add it as member.
AudioTrackJni::AudioTrackJni(AudioManager* audio_manager)
    : /*j_environment_(JVM::GetInstance()->environment()),*/
      audio_parameters_(audio_manager->GetPlayoutAudioParameters()),
      direct_buffer_address_(nullptr),
      direct_buffer_capacity_in_bytes_(0),
      frames_per_buffer_(0),
      initialized_(false),
      playing_(false),
      audio_device_buffer_(nullptr),
      track_thread_(AudioTrackJniRunFunction, this, "AudioTrackJni trhead"),
      operation_event_(false, false),
      result_event_(false, false){
  ALOGD("ctor%s", GetThreadInfo().c_str());
  RTC_DCHECK(audio_parameters_.is_valid());
  //RTC_CHECK(j_environment_);
  
  //InitJavaEnvironment();
  _currentOperation = 0;

  track_thread_.Start();
  // Detach from this thread since we want to use the checker to verify calls
  // from the Java based audio thread.
  thread_checker_java_.DetachFromThread();
}

AudioTrackJni::~AudioTrackJni() {
  ALOGD("~dtor%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  Terminate();

  operation_event_.Set();
  track_thread_.Stop();
}

void AudioTrackJni::InitJavaEnvironment() {
  j_environment_ = JVM::GetInstance()->environment();
  JNINativeMethod native_methods[] = {
      {"nativeCacheDirectBufferAddress", "(Ljava/nio/ByteBuffer;J)V",
      reinterpret_cast<void*>(
          &webrtc::AudioTrackJni::CacheDirectBufferAddress)},
      {"nativeGetPlayoutData", "(IJ)V",
      reinterpret_cast<void*>(&webrtc::AudioTrackJni::GetPlayoutData)}};
  j_native_registration_ = j_environment_->RegisterNatives(
  "org/webrtc/voiceengine/WebRtcAudioTrack",
  native_methods, arraysize(native_methods));
  j_audio_track_.reset(new JavaAudioTrack(
  j_native_registration_.get(),
  j_native_registration_->NewObject(
      "<init>", "(Landroid/content/Context;J)V",
      JVM::GetInstance()->context(), PointerTojlong(this))));
  
}

void AudioTrackJni::UnInitJavaEnvironment() {
    //j_native_registration_ = nullptr;
}

static const int kAudioTrackJniIntervalMs = 10000;

void AudioTrackJni::DoOperacation() {
  AttachCurrentThreadIfNeeded test;
  ALOGD("AudioTrackJni::AudioTrackJniRunFunction need attach:%d", test.attached_);
  if(test.attached_) {
    InitJavaEnvironment();
  }
  while (true) {
    bool shutting_down = operation_event_.Wait(kAudioTrackJniIntervalMs);
    if(_currentOperation == 1) {
      InitPlayoutEX();
      result_event_.Set();
    }

    if(_currentOperation == 2) {
      StartPlayoutEX();
      result_event_.Set();
    }

    if(_currentOperation == 3) {
      StopPlayoutEX();
      result_event_.Set();
    }

    _currentOperation = 0;
    if (shutting_down)
        break;
  }
}
int32_t AudioTrackJni::Init() {
  ALOGD("Init%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  return 0;
}

int32_t AudioTrackJni::Terminate() {
  ALOGD("Terminate%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  StopPlayout();
  return 0;
}

int32_t AudioTrackJni::InitPlayout() {
   ALOGD(" Call InitPlayout:%s", GetThreadInfo().c_str());

  _currentOperation = 1;

  operation_event_.Set();

  while(true) {
    bool shutting_down = result_event_.Wait(kAudioTrackJniIntervalMs);
    if (shutting_down)
        break;
  }

  ALOGD(" Call InitPlayout:%s finish", GetThreadInfo().c_str());
  return 0;
}
int32_t AudioTrackJni::InitPlayoutEX() {
  ALOGD("InitPlayout%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  RTC_DCHECK(!initialized_);
  RTC_DCHECK(!playing_);

  //AttachCurrentThreadIfNeeded test;
  //ALOGD("AudioTrackJni::InitPlayout need attach:%d", test.attached_);
  //if(test.attached_ || j_native_registration_ == nullptr) {
  //  InitJavaEnvironment();
  //}

  j_audio_track_->InitPlayout(
      audio_parameters_.sample_rate(), audio_parameters_.channels());

  initialized_ = true;
  ALOGD("AudioTrackJni::InitPlayout initialized_:%d", initialized_);
  return 0;
}

int32_t AudioTrackJni::StartPlayout() {
   ALOGD(" Call StartPlayout:%s", GetThreadInfo().c_str());

  _currentOperation = 2;

  operation_event_.Set();

  while(true) {
    bool shutting_down = result_event_.Wait(kAudioTrackJniIntervalMs);
    if (shutting_down)
        break;
  }

  ALOGD(" Call StartPlayout:%s finish", GetThreadInfo().c_str());
  return 0;
}

int32_t AudioTrackJni::StartPlayoutEX() {
  ALOGD("StartPlayout%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  RTC_DCHECK(initialized_);
  RTC_DCHECK(!playing_);

  //AttachCurrentThreadIfNeeded test;
  //ALOGD("AudioTrackJni::StartPlayout need attach:%d", test.attached_);
  //if(test.attached_ || j_native_registration_ == nullptr) {
  //  InitJavaEnvironment();
  //}

  if (!j_audio_track_->StartPlayout()) {
    ALOGE("StartPlayout failed!");
    return -1;
  }

  playing_ = true;
  return 0;
}

int32_t AudioTrackJni::StopPlayout() {
   ALOGD(" Call StopPlayout:%s", GetThreadInfo().c_str());

  _currentOperation = 3;

  operation_event_.Set();

  while(true) {
    bool shutting_down = result_event_.Wait(kAudioTrackJniIntervalMs);
    if (shutting_down)
        break;
  }

  ALOGD(" Call StopPlayout:%s finish", GetThreadInfo().c_str());
  return 0;
}
int32_t AudioTrackJni::StopPlayoutEX() {
  ALOGD("StopPlayout%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  if (!initialized_ || !playing_) {
    return 0;
  }

  //AttachCurrentThreadIfNeeded test;
  //ALOGD("AudioTrackJni::StopPlayout need attach:%d", test.attached_);
  //if(test.attached_ || j_native_registration_ == nullptr) {
  //  InitJavaEnvironment();
  //}

  if (!j_audio_track_->StopPlayout()) {
    ALOGE("StopPlayout failed!");
    return -1;
  }

  // If we don't detach here, we will hit a RTC_DCHECK in OnDataIsRecorded()
  // next time StartRecording() is called since it will create a new Java
  // thread.
  thread_checker_java_.DetachFromThread();
  initialized_ = false;
  playing_ = false;
  direct_buffer_address_ = nullptr;
  return 0;
}

int AudioTrackJni::SpeakerVolumeIsAvailable(bool& available) {
  available = true;
  return 0;
}

int AudioTrackJni::SetSpeakerVolume(uint32_t volume) {
  ALOGD("SetSpeakerVolume(%d)%s", volume, GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());

  //AttachCurrentThreadIfNeeded test;
  //ALOGD("AudioTrackJni::SetSpeakerVolume need attach:%d", test.attached_);
  //if(test.attached_ || j_native_registration_ == nullptr) {
  //  InitJavaEnvironment();
  //}

  int flag = 0; //j_audio_track_->SetStreamVolume(volume) ? 0 : -1;

  return flag;
}

int AudioTrackJni::MaxSpeakerVolume(uint32_t& max_volume) {
  ALOGD("MaxSpeakerVolume%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());

  //AttachCurrentThreadIfNeeded test;
  //ALOGD("AudioTrackJni::MaxSpeakerVolume need attach:%d", test.attached_);
  //if(test.attached_ || j_native_registration_ == nullptr) {
  //  InitJavaEnvironment();
  //}

  //max_volume = j_audio_track_->GetStreamMaxVolume();

  return 0;
}

int AudioTrackJni::MinSpeakerVolume(uint32_t& min_volume) const {
  ALOGD("MaxSpeakerVolume%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  min_volume = 0;
  return 0;
}

int AudioTrackJni::SpeakerVolume(uint32_t& volume) {
  ALOGD("SpeakerVolume%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());

  //AttachCurrentThreadIfNeeded test;
  //ALOGD("AudioTrackJni::SpeakerVolume need attach:%d", test.attached_);
  //if(test.attached_ || j_native_registration_ == nullptr) {
  //  InitJavaEnvironment();
  //}

  //volume = j_audio_track_->GetStreamVolume();

  return 0;
}

// TODO(henrika): possibly add stereo support.
void AudioTrackJni::AttachAudioBuffer(AudioDeviceBuffer* audioBuffer) {
  ALOGD("AttachAudioBuffer%s", GetThreadInfo().c_str());
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  audio_device_buffer_ = audioBuffer;
  const int sample_rate_hz = audio_parameters_.sample_rate();
  ALOGD("SetPlayoutSampleRate(%d)", sample_rate_hz);
  audio_device_buffer_->SetPlayoutSampleRate(sample_rate_hz);
  const int channels = audio_parameters_.channels();
  ALOGD("SetPlayoutChannels(%d)", channels);
  audio_device_buffer_->SetPlayoutChannels(channels);
}

void JNICALL AudioTrackJni::CacheDirectBufferAddress(
    JNIEnv* env, jobject obj, jobject byte_buffer, jlong nativeAudioTrack) {
  webrtc::AudioTrackJni* this_object =
      reinterpret_cast<webrtc::AudioTrackJni*> (nativeAudioTrack);
  this_object->OnCacheDirectBufferAddress(env, byte_buffer);
}

void AudioTrackJni::OnCacheDirectBufferAddress(
    JNIEnv* env, jobject byte_buffer) {
  ALOGD("OnCacheDirectBufferAddress");
  RTC_DCHECK(thread_checker_.CalledOnValidThread());
  RTC_DCHECK(!direct_buffer_address_);
  direct_buffer_address_ =
      env->GetDirectBufferAddress(byte_buffer);
  jlong capacity = env->GetDirectBufferCapacity(byte_buffer);
  ALOGD("direct buffer capacity: %lld", capacity);
  direct_buffer_capacity_in_bytes_ = static_cast<size_t>(capacity);
  frames_per_buffer_ = direct_buffer_capacity_in_bytes_ / kBytesPerFrame;
  ALOGD("frames_per_buffer: %" PRIuS, frames_per_buffer_);
}

void JNICALL AudioTrackJni::GetPlayoutData(
  JNIEnv* env, jobject obj, jint length, jlong nativeAudioTrack) {
  webrtc::AudioTrackJni* this_object =
      reinterpret_cast<webrtc::AudioTrackJni*> (nativeAudioTrack);
  this_object->OnGetPlayoutData(static_cast<size_t>(length));
}

// This method is called on a high-priority thread from Java. The name of
// the thread is 'AudioRecordTrack'.
void AudioTrackJni::OnGetPlayoutData(size_t length) {
  RTC_DCHECK(thread_checker_java_.CalledOnValidThread());
  RTC_DCHECK_EQ(frames_per_buffer_, length / kBytesPerFrame);
  if (!audio_device_buffer_) {
    ALOGE("AttachAudioBuffer has not been called!");
    return;
  }
  // Pull decoded data (in 16-bit PCM format) from jitter buffer.
  int samples = audio_device_buffer_->RequestPlayoutData(frames_per_buffer_);
  if (samples <= 0) {
    ALOGE("AudioDeviceBuffer::RequestPlayoutData failed!");
    return;
  }
  RTC_DCHECK_EQ(static_cast<size_t>(samples), frames_per_buffer_);
  // Copy decoded data into common byte buffer to ensure that it can be
  // written to the Java based audio track.
  samples = audio_device_buffer_->GetPlayoutData(direct_buffer_address_);
  RTC_DCHECK_EQ(length, kBytesPerFrame * samples);
}

}  // namespace webrtc
