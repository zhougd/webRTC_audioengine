#APP_STL := stlport_static
APP_STL := gnustl_static
APP_PLATFORM := android-16
APP_OPTIM  := release
APP_CPPFLAGS := -fexceptions -frtti
APP_CPPFLAGS +=-std=c++11
#STLPORT_FORCE_REBUILD := false

# Build both ARMv5TE armeabi and ARMv7-A machine code.
APP_ABI :=  armeabi-v7a
