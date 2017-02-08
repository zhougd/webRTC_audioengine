#ifndef MEDIA_ENGINE_COMMON_TYPES_H
#define MEDIA_ENGINE_COMMON_TYPES_H

#ifdef MEDIA_ENGINE_EXPORT
#define MEDIA_ENGINE_DLLEXPORT _declspec(dllexport)
#elif MEDIA_ENGINE_DLL
#define MEDIA_ENGINE_DLLEXPORT _declspec(dllimport)
#elif defined(ANDROID) || defined(MAC_IPHONE)
#define MEDIA_ENGINE_DLLEXPORT __attribute__ ((visibility("default")))
#else
#define MEDIA_ENGINE_DLLEXPORT extern
#endif

#include "webrtc/typedefs.h"
#include "webrtc/transport.h"
#include "webrtc/common_types.h"

#endif // MEDIA_ENGINE_COMMON_TYPES_H