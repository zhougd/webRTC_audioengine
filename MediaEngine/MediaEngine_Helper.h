#ifndef MEDIA_ENGINE_API_H
#define MEDIA_ENGINE_API_H

#include "MediaEngine.h"

#ifdef WIN32
#pragma comment(lib, "MediaEngine.lib")
#endif


/*说明:
* 该文件不属于MediaEngine 内部文件，用于第三方程序引用MediaEngine时的
* 快速调用文件，第三方程序只需要在其代码中增加以下代码:

 #include "MediaEngine_Helper.h"

 MediaEngine_Helper the_media_engine_instance_;

 MediaEngine *media_engine = MediaEngine_Helper::Instance().getMediaEngine();

 media_engine->Init();
 //使用语音引擎
 .... 
*
*/


class MediaEngine_Helper;
/*在调用的app 中定义该实例*/
//extern	MediaEngine_Helper the_media_engine_instance_;


class MediaEngine_Helper{

public:
	bool enable_fec;
	static MediaEngine_Helper* Instance()
	{ 
		static MediaEngine_Helper*	s_Instance = NULL;
		if (NULL == s_Instance)
		{
			s_Instance = new MediaEngine_Helper();
		}
		
		return s_Instance;
		/*if ( !the_media_engine_instance_.media_engine_ )
		{
			return new MediaEngine_Helper;
		}
		else
		{
			return &the_media_engine_instance_;
		}*/
		//return &the_media_engine_instance_; 
	};

public:
	  MediaEngine_Helper()
	  //media_engine_(CreateMediaEngine()),
	  {
		  media_engine_ = NULL;
		  
	      enable_fec = true;
		  //media_engine_->Init();

		  ///*开启默认设置*/
		  //media_engine_->VOE_SetAECMode(1,kEcDefault);
		  //media_engine_->VOE_SetAGCMode(1,kAgcDefault);
		  //media_engine_->VOE_SetNSMode(1,kNsHighSuppression);
	  };
 
	  void Initialize()
	  {
		  int nCurVolume = 0;
		  media_engine_ = CreateMediaEngine();
		  media_engine_->Init();

		  /*开启默认设置*/
		  media_engine_->VOE_SetAECMode(1,kEcDefault);
		  media_engine_->VOE_SetAGCMode(1,kAgcDefault);
		  media_engine_->VOE_SetNSMode(1,kNsHighSuppression);
#ifdef WIN32
		  nCurVolume = media_engine_->VOE_GetSpeakerVolume();
		  if ( nCurVolume> 255*0.9)
		  {
			  media_engine_->VOE_SetSpeakerVolume(255*0.8);
		  }
#endif
	  }

	  ~MediaEngine_Helper()
	  {
		  if(media_engine_->IsInitialized())
				  media_engine_->Terminate();

		  DeleteMediaEngine(media_engine_);
	  };

	  MediaEngine *getMediaEngine(){ 
		  return media_engine_ ;
	  };
private:
	MediaEngine *media_engine_;
};

#endif