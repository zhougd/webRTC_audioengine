# Copyright (c) 2011 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

include $(LOCAL_PATH)/../../android-webrtc.mk

LOCAL_ARM_MODE := arm
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := rtc_base
LOCAL_MODULE_TAGS := optional
LOCAL_CPP_EXTENSION := .cc
LOCAL_SRC_FILES := \
	asyncfile.cc \
	asyncinvoker.cc \
	asyncpacketsocket.cc \
	asyncresolverinterface.cc \
	asyncsocket.cc \
	asynctcpsocket.cc \
	asyncudpsocket.cc \
	autodetectproxy.cc \
	bandwidthsmoother.cc \
	base64.cc \
	common.cc \
	crc32.cc \
	cryptstring.cc \
	diskcache.cc \
	filerotatingstream.cc \
	fileutils.cc \
	firewallsocketserver.cc \
	flags.cc \
	helpers.cc \
	httpbase.cc \
	httpclient.cc \
	httpcommon.cc \
	httprequest.cc \
	httpserver.cc \
	ifaddrs-android.cc \
	ipaddress.cc \
	latebindingsymboltable.cc \
	linux.cc \
	logsinks.cc \
	messagedigest.cc \
	messagehandler.cc \
	messagequeue.cc \
	multipart.cc \
	natserver.cc \
	natsocketfactory.cc \
	nattypes.cc \
	nethelpers.cc \
	network.cc \
	networkmonitor.cc \
	openssladapter.cc \
	openssldigest.cc \
	opensslidentity.cc \
	opensslstreamadapter.cc \
	optionsfile.cc \
	pathutils.cc \
	physicalsocketserver.cc \
	posix.cc \
	profiler.cc \
	proxydetect.cc \
	proxyinfo.cc \
	proxyserver.cc \
	ratelimiter.cc \
	rtccertificate.cc \
	sha1.cc \
	sha1digest.cc \
	sharedexclusivelock.cc \
	signalthread.cc \
	sigslot.cc \
	socketadapters.cc \
	socketaddress.cc \
	socketaddresspair.cc \
	socketpool.cc \
	socketstream.cc \
	ssladapter.cc \
	sslfingerprint.cc \
	sslidentity.cc \
	sslsocketfactory.cc \
	sslstreamadapter.cc \
	sslstreamadapterhelper.cc \
	stream.cc \
	task.cc \
	taskparent.cc \
	taskrunner.cc \
	testclient.cc \
	thread.cc \
	timing.cc \
	transformadapter.cc \
	unixfilesystem.cc \
	urlencode.cc \
	versionparsing.cc \
	virtualsocketserver.cc \
	worker.cc

	


# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-DRTC_USE_OPENMAX_DL' \
    '-DDL_ARM_NEON_OPTIONAL' \
    '-fvisibility=hidden'

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 
    
LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/include \
    $(LOCAL_PATH)/.. \
    $(LOCAL_PATH)/../.. \
    $(LOCAL_PATH)/resampler/include \
    $(LOCAL_PATH)/signal_processing/include \
    $(LOCAL_PATH)/../../chromium/src/third_party/openmax_dl

LOCAL_SHARED_LIBRARIES += -lpthread

ifeq ($(TARGET_OS)-$(TARGET_SIMULATOR),linux-true)
LOCAL_LDLIBS += -ldl -lpthread
endif

ifneq ($(TARGET_SIMULATOR),true)
LOCAL_SHARED_LIBRARIES += libdl
endif


include $(BUILD_STATIC_LIBRARY)
