#ifndef MEDIA_ENGINE_IMPL_H
#define MEDIA_ENGINE_IMPL_H

#include "MediaEngine.h"

#include "voe_base.h"
#include "voe_rtp_rtcp.h"
#include "voe_codec.h"
#include "voe_dtmf.h"
#include "voe_external_media.h"
#include "voe_file.h"
#include "voe_hardware.h"
#include "voe_network.h"
#include "voe_video_sync.h"
#include "voe_volume_control.h"
#include "voe_neteq_stats.h"
#include "voe_audio_processing.h"
#include "voe_rtp_rtcp.h"
#include "voe_errors.h"

#include <map>


//自定义类
class ConnectionObserver;
class MyEncryption;
class RxCallback;
class MyTransport;
class MyExternalRenderer;




class MediaEngineImpl :
	public MediaEngine,
	public VoiceEngineObserver,
	public VoERTPObserver
{
public:
	MediaEngineImpl();    // standard constructor
	virtual ~MediaEngineImpl();
    
protected:  // VoiceEngineObserver
	virtual void CallbackOnError(const int channel, const int errCode);
    
protected:    // VoERTPObserver
	virtual void OnIncomingCSRCChanged(const int channel, const unsigned int CSRC, const bool added);
	virtual void OnIncomingSSRCChanged(const int channel, const unsigned int SSRC);

public:
	virtual int Init();
	virtual bool IsInitialized();
	virtual int Terminate(void);
    
	virtual int VOE_CreateChannel();
	virtual int VOE_DeleteChannel(int channel);
#ifdef WIN32
	virtual int ME_AE_GetCurChannel();
#endif
	virtual int VOE_SetConnectInfo(int channel,int recv_port,const char *remote_ip, int remote_port,int payload,bool use_external_transport);
	virtual int VOE_SetChannelSendCodec(int channel,int codec_payload);
	virtual int VOE_Connect(int channel);
    virtual int VOE_Disconnect(int channel);
    virtual int VOE_EnableSRTP(int channel, int suite_type, const char *send_key, const char *recv_key);
	virtual int VOE_SetAECMode(bool enabled,EcModes mode);
	virtual int VOE_SetAGCMode(bool enabled,AgcModes mode);
	virtual int VOE_SetNSMode(bool enabled,NsModes mode);
	virtual int VOE_NumOfCodecs();
	virtual int VOE_GetCodecOfIndex(int index, CodecInst &codec);
	virtual int VOE_SetSpeakerVolume(int volume);
	virtual int VOE_SetMicVolume(int volume);
	virtual unsigned int VOE_GetSpeakerVolume();
	virtual unsigned int VOE_GetMicVolume();
	virtual unsigned int VOE_GetSpeechInputLevel();
	virtual unsigned int VOE_GetSpeechOutputLevel(int channel);
	virtual int  VOE_SendTelephoneEvent(int channel, unsigned char eventCode,bool outBand, bool play_dtmf_tone_locally);
	virtual int VOE_RegisterExternalTransport(int channel, Transport *external_transport);
	virtual int VOE_DeRegisterExternalTransport(int channel);
	virtual int VOE_SetOnHoldStatus(int channel,bool enabled, OnHoldModes mode);
	virtual int VOE_GetOnHoldStatus(int channel, bool& enabled,OnHoldModes& mode);
	virtual int VOE_StartRecordingCall(int channel, const char *path);
	virtual int VOE_StopRecordingCall(int channel);
	virtual int VOE_ConvertRecordFile(const char *filename);
    virtual int VOE_GetNumOfPlayoutDevices();
	virtual int VOE_GetNumOfRecordingDevices();
	virtual int VOE_GetRecordingDeviceName(int index, char strNameUTF8[128], char strGuidUTF8[128]);
	virtual int VOE_GetPlayoutDeviceName(int index, char strNameUTF8[128], char strGuidUTF8[128]);
	virtual int VOE_GetPlayoutDeviceStatus(bool& isAvailable );
	virtual int VOE_GetRecordingDeviceStatus(bool& isAvailable );
	virtual int VOE_SetPlayoutDevice(int index);
	virtual int VOE_SetRecordingDevice(int index);
	virtual int VOE_MuteMic(int channel,bool yesno);
	virtual int VOE_MuteSpk(int channel, bool yesno);
#ifdef WIN32
	virtual int ME_AE_GetRemoteMicMute(int channel,bool yesno);  //add by delia for remote micmute 20130521
	virtual bool ME_AE_RemoteMicStatus(int channel);  //add by delia for remote micmute 20130521
#endif
	virtual int VOE_ReceivedRTPPacket(int channel, const char *buf,int len);
	virtual int VOE_ReceivedRTCPPacket(int channel, const char *buf,int len);
    virtual int VOE_SetProtectionFEC(int channel, bool yesno);
	virtual int VOE_GetCallStatistics(int channel,CallStatistics &stats);
    virtual int VOE_SetLoudspeakerStatus(bool yesno);
	virtual int ME_AE_SoftEnhancement(int channel, float scale);
#ifdef WIN32
	//delia add only for win XP 20130823
	virtual int ME_AE_XPVolumeControl(float scale);
#endif
	virtual int VOE_PostProcessingEnable(bool flag);
private:
	/* Voice Engine*/
	VoiceEngine*			_vePtr;
	VoECodec*               _veCodecPtr;
	VoEExternalMedia*       _veExternalMediaPtr;
	VoEVolumeControl*       _veVolumeControlPtr;
	VoEHardware*            _veHardwarePtr;
	VoEVideoSync*           _veVideoSyncPtr;
	VoENetwork*             _veNetworkPtr;
	VoEFile*                _veFilePtr;
	VoEAudioProcessing*     _veApmPtr;
	VoEBase*                _veBasePtr;
	VoERTP_RTCP*            _veRtpRtcpPtr;
	VoEDtmf*                _veDTMFPtr;
	VoENetEqStats*			_veNetEqStatsPtr;

	bool                    m_bRemoteMicMute;
	int						m_nchannel;
};
#endif //MEDIA_ENGINE_IMPL_H
