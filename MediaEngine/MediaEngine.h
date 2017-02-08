#ifndef MEDIA_ENGINE_H
#define MEDIA_ENGINE_H

#include "audiocommon.h"

using namespace webrtc;

class MediaEngine
{
public:
	virtual int Init() = 0;
	virtual bool IsInitialized() = 0;
	virtual int Terminate() = 0;

	/*ÓïÒôÍ¨µÀµ÷ÓÃ½Ó¿Ú*/
	virtual int VOE_CreateChannel() = 0;
	virtual int VOE_SetConnectInfo(int channel,int recv_port,const char *remote_ip, int remote_port,int payload,bool use_external_transport) = 0;
	virtual int VOE_SetChannelSendCodec(int channel,int codec_payload) = 0;
	virtual int VOE_Connect(int channel) = 0;
	virtual int VOE_Disconnect(int channel) = 0;
	virtual int VOE_DeleteChannel(int channel) = 0;
#ifdef WIN32
	virtual int ME_AE_GetCurChannel() = 0;
#endif
	/*ÆôÓÃ SRTP ´«Êä±£»¤, Íâ²¿´«Êä½Ó¿ÚÊ±ÎÞÐ§*/
	virtual int VOE_EnableSRTP(int channel, int suite_type, const char *send_key, const char *recv_key) = 0;
    
	/*ÒôÐ§: »ØÉùÏû³ý/×Ô¶¯ÔöÒæ¿ØÖÆ/½µÔë*/
	virtual int VOE_SetAECMode(bool enabled,EcModes mode) = 0;
	virtual int VOE_SetAGCMode(bool enabled,AgcModes mode) = 0;
	virtual int VOE_SetNSMode(bool enabled,NsModes mode) = 0;

	/*Í¨»°±£³Ö*/
	virtual int VOE_SetOnHoldStatus(int channel,bool enabled, OnHoldModes mode) = 0;
	virtual int VOE_GetOnHoldStatus(int channel, bool& enabled,OnHoldModes& mode) = 0;

	/*ÒôÆµ±à½âÂëÐÅÏ¢*/
	virtual int VOE_NumOfCodecs() = 0;
	virtual int VOE_GetCodecOfIndex(int index, CodecInst &codec) = 0;
	
	/*ÉèÖÃmicºÍspkÒôÁ¿*/
	virtual int VOE_SetSpeakerVolume(int volume) = 0;
	virtual int VOE_SetMicVolume(int volume) = 0;

	/*Éù¿¨²Ù×÷½Ó¿Ú*/
	virtual int VOE_GetNumOfPlayoutDevices() = 0;
	virtual int VOE_GetNumOfRecordingDevices() = 0;
	virtual int VOE_GetRecordingDeviceName(int index, char strNameUTF8[128], char strGuidUTF8[128]) = 0;
	virtual int VOE_GetPlayoutDeviceName(int index, char strNameUTF8[128], char strGuidUTF8[128]) = 0;
	virtual int VOE_GetPlayoutDeviceStatus(bool& isAvailable ) = 0;
	virtual int VOE_GetRecordingDeviceStatus(bool& isAvailable ) = 0;
	virtual int VOE_SetPlayoutDevice(int index) = 0;
	virtual int VOE_SetRecordingDevice(int index) = 0;

	/*¾²Òô*/
	virtual int VOE_MuteMic(int channel,bool yesno) = 0;
	virtual int VOE_MuteSpk(int channel, bool yesno) = 0;
#ifdef WIN32
	//add by delia for remote micmute 20130521
	virtual int ME_AE_GetRemoteMicMute(int channel,bool yesno)=0;
	virtual bool ME_AE_RemoteMicStatus(int channel)=0;
#endif
	/*Í¨»°Â¼Òô*/
	virtual int VOE_StartRecordingCall(int channel, const char *path) = 0;
	virtual int VOE_StopRecordingCall(int channel) = 0;
	virtual int VOE_ConvertRecordFile(const char *filename) = 0;

	/*ÊÕµ½rtp/rtcpÊý¾Ý·¢ËÍ¸øVoE£¬½öÏÞÍâ²¿´«Êä½Ó¿ÚÄ£Ê½*/
	virtual int VOE_ReceivedRTPPacket(int channel, const char *buf,int len) = 0;
	virtual int VOE_ReceivedRTCPPacket(int channel, const char *buf,int len) = 0;
	/*¿ªÆô´«Êä±£»¤*/
    virtual int VOE_SetProtectionFEC(int channel, bool yesno) = 0;
	/*»ñÈ¡ºô½ÐÍøÂçÍ³¼ÆÐÅÏ¢*/
	virtual int VOE_GetCallStatistics(int channel,CallStatistics &stats) = 0;

	/*»ñÈ¡mic/spkÏµÍ³ÒôÁ¿*/
	virtual unsigned int VOE_GetSpeakerVolume() = 0;
	virtual unsigned int VOE_GetMicVolume() = 0;
	
	/*»ñÈ¡ÊµÊ±ÒôÁ¿*/
	virtual unsigned int VOE_GetSpeechInputLevel() = 0;
	virtual unsigned int VOE_GetSpeechOutputLevel(int channel) = 0;

	/*·¢ËÍ´øÍâ/´øÄÚ dtmfÐÅºÅ*/
	virtual int VOE_SendTelephoneEvent(int channel, unsigned char eventCode,bool outBand, bool play_dtmf_tone_locally) = 0;
	
	/*×¢²áÍâ²¿´«Êä½Ó¿Ú*/
	virtual int VOE_RegisterExternalTransport(int channel, Transport *external_transport) = 0;
	virtual int VOE_DeRegisterExternalTransport(int channel) = 0;

	/*ÊÖ»úÑïÉùÆ÷ for mobile version*/
	virtual int VOE_SetLoudspeakerStatus(bool yesno) = 0;

	/* Sets a volume |scaling| applied to the outgoing signal of a specific channel. 
	Valid scale range is [0.0, 10.0].*/
	virtual int ME_AE_SoftEnhancement(int channel, float scale) = 0;
#ifdef WIN32
	//Delia add only for win XP 20130823
	//**Valid scale range is [0.0, 2.0].
	virtual int ME_AE_XPVolumeControl(float scale) = 0;
#endif
	virtual int VOE_PostProcessingEnable(bool flag) = 0;
protected:
	MediaEngine(){};
	virtual ~MediaEngine(){};

};

#ifdef __cplusplus
extern "C" {
#endif

#ifdef ANDROID
	/*ÉèÖÃ Jave VM »·¾³*/
	MEDIA_ENGINE_DLLEXPORT void VoE_SetAndroidObjects(void* javaVM, void *env, void* context);
#endif // ANDROID

	//´´½¨/Ïú»ÙÒýÇæ
	MEDIA_ENGINE_DLLEXPORT MediaEngine* CreateMediaEngine();
	MEDIA_ENGINE_DLLEXPORT bool DeleteMediaEngine(MediaEngine*& mediaEngine);
#ifdef __cplusplus
};
#endif

#endif //MEDIA_ENGINE_H
