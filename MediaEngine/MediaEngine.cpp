#include "MediaEngine.h"
#include "MediaEngine_impl.h"
#include <stdlib.h>

static int gMediaEngineActiveInstanceCounter = 0;

MediaEngine* GetMediaEngine()
{
	MediaEngineImpl* self = new MediaEngineImpl();
	if (self == NULL)
	{
		return NULL;
	}
	gMediaEngineActiveInstanceCounter++;
	MediaEngine* me = reinterpret_cast<MediaEngine*> (self);
	return me;
}

MEDIA_ENGINE_DLLEXPORT MediaEngine* CreateMediaEngine()
{
	return GetMediaEngine();
}

MEDIA_ENGINE_DLLEXPORT bool DeleteMediaEngine( MediaEngine*& mediaEngine )
{

	if (mediaEngine == NULL){
		return false;
	}

	MediaEngineImpl* meImpl = reinterpret_cast<MediaEngineImpl*> (mediaEngine);

	delete meImpl;
	meImpl =NULL;
	mediaEngine=NULL;

	gMediaEngineActiveInstanceCounter--;
	return true;
}