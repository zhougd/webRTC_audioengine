#include "MediaEngine_impl.h"


#ifdef WIN32
#define snprintf _snprintf_s
#endif // WIN32
#include <stdio.h>
#include <memory.h>
#if defined(ANDROID)
#include <unistd.h>
#endif

#include <assert.h>
#include <string.h>
#include <string>

#include <cstdlib>
#include <cstring>

#include "../../base/constructormagic.h"

#ifdef METRO_DEV
#include <pj/os_metro.h>
#endif

#ifdef ANDROID

#include <jni.h>
#include <android/log.h>
#define LOG_TAG "*MediaEngine*"

#define LOG_DEBUG(...) __android_log_print(ANDROID_LOG_DEBUG  , LOG_TAG,__VA_ARGS__)


static void* _javaVM=0;
static void* _env=0;
static void* _context=0;

#ifdef WEBRTC_DETECT_ARM_NEON
extern "C" int spl_runtime_cpu_detect_init();
#endif

#define DLL_PUBLIC __attribute__ ((visibility("default")))

extern "C" {

DLL_PUBLIC void VoE_SetAndroidObjects(void* javaVM, void *env, void* context)
{
    _javaVM = javaVM;
    _env = env;
    _context =context;
}
};
#endif // ANDROID
using namespace webrtc;

// To enable webrtc trace, define next line
//#define WEBRTC_LOG

#ifdef WEBRTC_LOG

static const int kLevelFilter = kTraceError; //kTraceError | kTraceWarning | kTraceTerseInfo | kTraceAll;

#ifdef ANDROID
// Upon constructing an instance of this class, all traces will be redirected
// to stderr. At destruction, redirection is halted.
class TraceToStderr : public TraceCallback {
public:
	TraceToStderr();
	// Set |override_time| to true to control the time printed with each trace
	// through SetTimeSeconds(). Otherwise, the trace's usual wallclock time is
	// used.
	//
	// This is useful for offline test tools, where the file time is much more
	// informative than the real time.
	explicit TraceToStderr(bool override_time);
	virtual ~TraceToStderr();

	// Every subsequent trace printout will use |time|. Has no effect if
	// |override_time| in the constructor was set to false.
	//
	// No attempt is made to ensure thread-safety between the trace writing and
	// time updating. In tests, since traces will normally be triggered by the
	// main thread doing the time updating, this should be of no concern.
	virtual void SetTimeSeconds(float time);

	// Implements TraceCallback.
	virtual void Print(TraceLevel level,
		const char* msg_array,
		int length) OVERRIDE;

private:
	bool override_time_;
	float time_seconds_;
};




TraceToStderr::TraceToStderr()
: override_time_(false),
time_seconds_(0) {
	Trace::CreateTrace();
	Trace::SetTraceCallback(this);
        Trace::set_level_filter(kLevelFilter);
}

TraceToStderr::TraceToStderr(bool override_time)
: override_time_(override_time),
time_seconds_(0) {
	Trace::CreateTrace();
	Trace::SetTraceCallback(this);
	Trace::set_level_filter(kLevelFilter);
}

TraceToStderr::~TraceToStderr() {
	Trace::SetTraceCallback(NULL);
	Trace::ReturnTrace();
}

void TraceToStderr::SetTimeSeconds(float time) { time_seconds_ = time; }

void TraceToStderr::Print(TraceLevel level, const char* msg_array, int length) {
	if (level & kLevelFilter) {
		assert(length > Trace::kBoilerplateLength);
		std::string msg = msg_array;
		std::string msg_log = msg.substr(Trace::kBoilerplateLength);
		if (override_time_) {
			//printf( "%.2fs %s\n", time_seconds_, msg_log.c_str());
			LOG_DEBUG("%.2fs %s", time_seconds_, msg_log.c_str());
		} else {
			std::string msg_time = msg.substr(Trace::kTimestampPosition,
				Trace::kTimestampLength);
			//printf( "%s %s\n", msg_time.c_str(), msg_log.c_str());
			LOG_DEBUG("%s %s", msg_time.c_str(), msg_log.c_str());
		}
		fflush(stderr);
	}
}
scoped_ptr<TraceToStderr> trace_to_stderr_;

#endif // ANDROID
#endif // WEBRTC_LOG

unsigned char key[30] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

MediaEngineImpl::MediaEngineImpl()
{
	m_bRemoteMicMute = false;
#ifdef WEBRTC_CONFIG_FILE
	m_nchannel = -1;
	m_codec_payloadtype = -1;
	m_codec_vadlevel = -1;
#endif //WEBRTC_CONFIG_FILE
}

MediaEngineImpl::~MediaEngineImpl()
{

}


#ifdef WEBRTC_LOG

#ifdef ANDROID

#else
static bool _trace_to_file=true;
static char _trace_file[] = "d:\\webrtc_trace.log";
#endif  // END ANDROID

#endif  // END WEBRTC_LOG


int MediaEngineImpl::Init()
{

#ifdef ANDROID
	// Set instance independent Java objects
	VoiceEngine::SetAndroidObjects((void*)_javaVM,_context);
#ifdef ENABLE_VIDEO
	VideoEngine::SetAndroidObjects((void*)_javaVM, _context);
#endif
#endif // ANDROID

/*	srtp_init();*/

	_vePtr = VoiceEngine::Create();

#ifdef WEBRTC_LOG
#ifdef ANDROID
	// Create TraceToStderr here so the behavior can be overridden.
	trace_to_stderr_.reset(new TraceToStderr);
#else
	VoiceEngine::SetTraceFilter(kLevelFilter);
	VoiceEngine::SetTraceFile(_trace_file);
#endif  // END ANDROID
#endif  // END WEBRTC_LOG
	if (_vePtr)
	{
		_veExternalMediaPtr = VoEExternalMedia::GetInterface(_vePtr);
		_veVolumeControlPtr = VoEVolumeControl::GetInterface(_vePtr);
//		_veEncryptionPtr = VoEEncryption::GetInterface(_vePtr);
		_veVideoSyncPtr = VoEVideoSync::GetInterface(_vePtr);
		_veNetworkPtr = VoENetwork::GetInterface(_vePtr);
		_veFilePtr = VoEFile::GetInterface(_vePtr);
		_veApmPtr = VoEAudioProcessing::GetInterface(_vePtr);

		_veBasePtr = VoEBase::GetInterface(_vePtr);
		_veCodecPtr = VoECodec::GetInterface(_vePtr);
		_veHardwarePtr = VoEHardware::GetInterface(_vePtr);
		_veRtpRtcpPtr = VoERTP_RTCP::GetInterface(_vePtr);
		_veNetEqStatsPtr = VoENetEqStats::GetInterface(_vePtr);
		_veDTMFPtr = VoEDtmf::GetInterface(_vePtr);

		//_transportPtr = new MyTransport();
		//_connectionObserverPtr = new ConnectionObserver();	
	}

	_veBasePtr->RegisterVoiceEngineObserver(*this);

	return _veBasePtr->Init();
}

bool MediaEngineImpl::IsInitialized()
{
	return (_vePtr!=NULL);
}


int MediaEngineImpl::Terminate()
{
//	if (_connectionObserverPtr) delete _connectionObserverPtr;
//	if (_transportPtr) delete _transportPtr;

//	if (_rxVadObserverPtr) delete _rxVadObserverPtr;
    
	if (_veExternalMediaPtr) _veExternalMediaPtr->Release();
//	if (_veEncryptionPtr) _veEncryptionPtr->Release();
	if (_veVideoSyncPtr) _veVideoSyncPtr->Release();
	if (_veVolumeControlPtr) _veVolumeControlPtr->Release();
	if (_veDTMFPtr) _veDTMFPtr->Release();
    
	if (_veBasePtr) _veBasePtr->Terminate();
	if (_veBasePtr) _veBasePtr->Release();
    
	if (_veCodecPtr) _veCodecPtr->Release();
	if (_veNetworkPtr) _veNetworkPtr->Release();
	if (_veFilePtr) _veFilePtr->Release();
	if (_veHardwarePtr) _veHardwarePtr->Release();
	if (_veApmPtr) _veApmPtr->Release();
	if (_veNetEqStatsPtr) _veNetEqStatsPtr->Release();
	if (_veRtpRtcpPtr) _veRtpRtcpPtr->Release();
	if (_vePtr)
	{
		bool ret = VoiceEngine::Delete(_vePtr);
		assert(ret == true);
	}
    
#ifdef ANDROID
	// Clear instance independent Java objects
	//VoiceEngine::SetAndroidObjects(NULL, NULL);
#endif

/*	srtp_shutdown();*/
    
	return 0;
}

int MediaEngineImpl::VOE_CreateChannel()
{
	int channel(0);
	channel = _veBasePtr->CreateChannel();

	if (channel >= 0)
	{
		// Always set send codec to default codec <=> index 0.
		webrtc::CodecInst codec;
		_veCodecPtr->GetCodec(0, codec);
		_veCodecPtr->SetSendCodec(channel, codec);

#ifdef WEBRTC_CONFIG_FILE

		if(-1==m_codec_vadlevel)
		{
			_veCodecPtr->SetVADStatus(channel,true,kVadAggressiveHigh);
		}
		else
		{
			_veCodecPtr->SetVADStatus(channel,true,(VadModes)m_codec_vadlevel);
		}
#endif //WEBRTC_CONFIG_FILE
	}

	m_nchannel = channel;

	return channel;
}

int MediaEngineImpl::VOE_DeleteChannel(int channel)
{

	if(channel < 0) 
		return -1;
    _veBasePtr->StopReceive(channel);
	_veBasePtr->StopPlayout(channel);
    
	_veBasePtr->StopSend(channel);

	return _veBasePtr->DeleteChannel(channel);
}
#ifdef WIN32
int MediaEngineImpl::ME_AE_GetCurChannel()
{
	if(m_nchannel < 0) 
		return -1;
	return m_nchannel;
}
#endif
int MediaEngineImpl::VOE_SetConnectInfo(int channel,
									int recv_port,
									const char *remote_ip,
									int remote_port, 
									int payload,
									bool use_external_transport)
{
	if(channel < 0) 
		return -1;
	
	int ret(0);

    webrtc::CodecInst codec;
	int num_of_codecs = _veCodecPtr->NumOfCodecs();
	int i;
	for(i=0;i<num_of_codecs;i++)
	{
		_veCodecPtr->GetCodec(i, codec);
		if(codec.pltype == payload)
		{
			_veCodecPtr->SetSendCodec(channel, codec);
			goto end;
		}
	}
end:
//	_veVideoSyncPtr->SetInitTimestamp(channel,0);
	return ret;
}

int MediaEngineImpl::VOE_Connect(int channel)
{
	if(channel < 0) 
		return -1;
	
	int ret;
    ret = _veRtpRtcpPtr->SetRTCPStatus(channel, true);
    ret = _veBasePtr->StartReceive(channel);
	ret = _veBasePtr->StartPlayout(channel);
	ret = _veBasePtr->StartSend(channel);
	return ret;
}


int MediaEngineImpl::VOE_Disconnect(int channel)
{
	if(channel < 0) 
		return -1;
	
	int ret;
    ret = _veRtpRtcpPtr->SetRTCPStatus(channel, false);
    ret = _veBasePtr->StopReceive(channel);
    ret = _veBasePtr->StopPlayout(channel);
    ret = _veBasePtr->StopSend(channel);
    
	
	return ret;
}


int MediaEngineImpl::VOE_SetAECMode(bool enabled, EcModes mode)
{
	return _veApmPtr->SetEcStatus(enabled, mode);
}

int MediaEngineImpl::VOE_SetAGCMode(bool enabled, AgcModes mode)
{
	return _veApmPtr->SetAgcStatus(enabled, mode);
}

int MediaEngineImpl::VOE_SetNSMode(bool enabled, NsModes mode)
{
	return _veApmPtr->SetNsStatus(enabled, kNsHighSuppression);
}


int MediaEngineImpl::VOE_NumOfCodecs(){
	return _veCodecPtr->NumOfCodecs();
}

int MediaEngineImpl::VOE_GetCodecOfIndex(int index, CodecInst &codec)
{
	return _veCodecPtr->GetCodec(index, codec);
}


int MediaEngineImpl::VOE_SetSpeakerVolume(int volume)
{
	return _veVolumeControlPtr->SetSpeakerVolume(volume);
}

int MediaEngineImpl::VOE_SetMicVolume(int volume)
{
	return _veVolumeControlPtr->SetMicVolume(volume);
}


unsigned int MediaEngineImpl::VOE_GetSpeakerVolume()
{
	unsigned int svol(0);
	_veVolumeControlPtr->GetSpeakerVolume(svol);
	return svol;
}

unsigned int MediaEngineImpl::VOE_GetMicVolume()
{
	unsigned int mvol(0);
	_veVolumeControlPtr->GetMicVolume(mvol);
	return mvol;
}

unsigned int MediaEngineImpl::VOE_GetSpeechInputLevel()
{
	unsigned int micLevel;
	_veVolumeControlPtr->GetSpeechInputLevel(micLevel);
	return micLevel;
}

unsigned int MediaEngineImpl::VOE_GetSpeechOutputLevel(int channel)
{
	unsigned int combinedOutputLevel;
	_veVolumeControlPtr->GetSpeechOutputLevel(channel,combinedOutputLevel);
	return combinedOutputLevel;
}

int MediaEngineImpl::ME_AE_SoftEnhancement(int channel, float volume)
{
	return _veVolumeControlPtr->SetChannelOutputVolumeScaling(channel,volume);
}

int MediaEngineImpl::VOE_PostProcessingEnable(bool flag) {
	//_veApmPtr->SetPostProcessingDisableEnable(flag);
	return 	0;	
}

#ifdef WIN32
//{{delia add only for winXP 20130822
int MediaEngineImpl::ME_AE_XPVolumeControl(float scale)
{
	if (m_nchannel >= 0)
	{
		return _veVolumeControlPtr->SetChannelOutputVolumeScaling(m_nchannel,scale);
	}
	return -1;
}
//}}
#endif
int  MediaEngineImpl::VOE_SendTelephoneEvent(int channel, unsigned char eventCode,
									 bool outBand, bool play_dtmf_tone_locally)
{
	int lengthMs(160);
	int attenuationDb(10);
	attenuationDb = 10;

	if (play_dtmf_tone_locally)
	{
		// --- PlayDtmfTone
		_veDTMFPtr->PlayDtmfTone(eventCode, lengthMs, attenuationDb);
	}
	
	return _veDTMFPtr->SendTelephoneEvent(channel, eventCode, outBand, lengthMs, attenuationDb);
}

int MediaEngineImpl::VOE_SetProtectionFEC(int channel, bool yesno){
	LOG_DEBUG("SetREDStatus:%d", yesno);
    return _veRtpRtcpPtr->SetREDStatus(channel, yesno, 127);
}

int MediaEngineImpl::VOE_ReceivedRTPPacket( int channel, const char *buf,int len )
{
	LOG_DEBUG("received rtp audio data: %d", len);
	return _veNetworkPtr->ReceivedRTPPacket(channel, buf, len);
}

int MediaEngineImpl::VOE_ReceivedRTCPPacket( int channel, const char *buf,int len )
{
	LOG_DEBUG("received rtcp audio data: %d", len);
	return _veNetworkPtr->ReceivedRTCPPacket(channel, buf, len);
}

int MediaEngineImpl::VOE_RegisterExternalTransport(int channel, Transport *external_transport)
{
    _veNetworkPtr->DeRegisterExternalTransport(channel);
	return _veNetworkPtr->RegisterExternalTransport(channel,*external_transport);
}

int MediaEngineImpl::VOE_SetOnHoldStatus(int channel,bool enabled, OnHoldModes mode){
	return _veBasePtr->SetOnHoldStatus(channel, enabled, mode);
}

int MediaEngineImpl::VOE_GetOnHoldStatus(int channel, bool& enabled,
										 OnHoldModes& mode){
	 return _veBasePtr->GetOnHoldStatus(channel, enabled, mode);
}

int MediaEngineImpl::VOE_GetNumOfPlayoutDevices()
{
	int count(0);
	_veHardwarePtr->GetNumOfPlayoutDevices(count);
	return count;
}

int MediaEngineImpl::VOE_GetPlayoutDeviceName(int index, char strNameUTF8[128],
										  char strGuidUTF8[128])
{
	return  _veHardwarePtr->GetPlayoutDeviceName(index,strNameUTF8,strGuidUTF8);
}

int MediaEngineImpl::VOE_GetRecordingDeviceName(int index, char strNameUTF8[128],
											char strGuidUTF8[128])
{
	return  _veHardwarePtr->GetRecordingDeviceName(index,strNameUTF8,strGuidUTF8);
}

int MediaEngineImpl::VOE_GetNumOfRecordingDevices()
{
	int count(0);
	_veHardwarePtr->GetNumOfRecordingDevices(count);
	return count;
}

int MediaEngineImpl::VOE_GetPlayoutDeviceStatus(bool& isAvailable )
{
	return  _veHardwarePtr->GetPlayoutDeviceStatus(isAvailable);
}

int MediaEngineImpl::VOE_GetRecordingDeviceStatus(bool& isAvailable )
{
	return  _veHardwarePtr->GetRecordingDeviceStatus(isAvailable);
}

int MediaEngineImpl::VOE_SetPlayoutDevice(int index)
{
	return  _veHardwarePtr->SetPlayoutDevice(index);
}

int MediaEngineImpl::VOE_SetRecordingDevice(int index)
{
	return  _veHardwarePtr->SetRecordingDevice(index);
}

int MediaEngineImpl::VOE_MuteMic(int channel, bool yesno )
{
	return _veVolumeControlPtr->SetInputMute(channel, yesno);
}

int MediaEngineImpl::VOE_MuteSpk(int channel, bool yesno )
{
	static float vol_old(5.0);
	if(yesno){
		_veVolumeControlPtr->GetChannelOutputVolumeScaling(channel,vol_old);
	}
	return _veVolumeControlPtr->SetChannelOutputVolumeScaling(channel,(float)(yesno? 0.0 : 1.0));
}
#ifdef WIN32
//add by delia for remote micmute 20130521
int MediaEngineImpl::ME_AE_GetRemoteMicMute(int channel, bool yesno )
{
	if (channel != -1)
	{
		m_bRemoteMicMute = yesno;
		return 0;
	}
	return -1;
}
//add by delia for remote micmute 20130521
bool MediaEngineImpl::ME_AE_RemoteMicStatus(int channel)
{
	if (channel != -1)
	{
		return m_bRemoteMicMute;
	}
	return 0;
}
#endif
int MediaEngineImpl::VOE_StopRecordingCall( int channel )
{
	int ret1 = _veFilePtr->StopRecordingMicrophone();
	int ret2 = _veFilePtr->StopRecordingPlayout(channel);
	return ret2;
}

 int MediaEngineImpl::VOE_ConvertRecordFile( const char *fileName){
 		return 0;
}

int MediaEngineImpl::VOE_DeRegisterExternalTransport( int channel )
{
	return _veNetworkPtr->DeRegisterExternalTransport(channel);
}

int MediaEngineImpl::VOE_StartRecordingCall( int channel, const char *fileName )
{
	char buf[2048];

	memset(buf,0,sizeof(buf));
	snprintf(buf,sizeof(buf),"%s_in",fileName);
	_veFilePtr->StartRecordingMicrophone(buf);

	memset(buf,0,sizeof(buf));
	snprintf(buf,sizeof(buf),"%s_out",fileName);
	return _veFilePtr->StartRecordingPlayout(channel,buf);
}

int MediaEngineImpl::VOE_GetCallStatistics(int channel, CallStatistics &stats )
{
	return _veRtpRtcpPtr->GetRTCPStatistics(channel, stats);
}


int MediaEngineImpl::VOE_SetLoudspeakerStatus( bool yesno )
{
	return 0;
}

void MediaEngineImpl::CallbackOnError(const int channel, const int errCode)
{
    
}

void MediaEngineImpl::OnIncomingCSRCChanged(
                                            const int channel, const unsigned int CSRC, const bool added)
{
    
}

void MediaEngineImpl::OnIncomingSSRCChanged(
                                            const int channel, const unsigned int SSRC)
{
    
}


int MediaEngineImpl::VOE_EnableSRTP( int channel, int suite_type, const char *send_key, const char *recv_key )
{
 	return 0;
}

int MediaEngineImpl::VOE_SetChannelSendCodec( int channel,int codec_payload )
{
	/*ñ*/
	webrtc::CodecInst codec;
	int num_of_codecs = _veCodecPtr->NumOfCodecs();
	int i;
	for(i=0;i<num_of_codecs;i++)
	{
		_veCodecPtr->GetCodec(i, codec);
		if(codec.pltype == codec_payload)
		{
			_veCodecPtr->SetSendCodec(channel, codec);
			LOG_DEBUG("xxxxxxxxxxxxzzzzz:current codec pltype is %d, plname is %s, plfreq is %d, rate is %d ", codec.pltype, codec.plname, codec.plfreq, codec.rate );
			goto end;
		}
	}
	return -1;

end:
	return 0;
}
