# Copyright (c) 2011 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

# These defines will apply to all source files
# Think again before changing it
MY_WEBRTC_COMMON_DEFS := \
    '-DWEBRTC_LINUX' \
    '-DWEBRTC_CLOCK_TYPE_REALTIME' \
    '-DWEBRTC_ANDROID' \
    '-DWEBRTC_POSIX' \
    '-DENABLE_WEBRTC=1' \
    '-DANDROID' \
    '-DWEBRTC_ARCH_ARM' \
    '-DWEBRTC_ARCH_ARM_V7' \
    '-DWEBRTC_DETECT_NEON' \
    '-DNDEBUG' \
    '-D__UCLIBC__' \
    '-DWEBRTC_INCLUDE_INTERNAL_AUDIO_DEVICE' \
    '-DRTC_USE_OPENMAX_DL' \
    '-DDL_ARM_NEON_OPTIONAL' \
    '-DUSE_LIBPCI=1' \
    '-funwind-tables' \
    '-fvisibility=hidden' \
    '-fPIC' \
    '-pipe' \
    '-ffunction-sections' \
    '-fdata-sections' \
    '-fno-ident' \
    '-fomit-frame-pointer' \
    '-g' \
    '-fstack-protector' \
    '-fno-short-enums' \
    '-finline-limit=64' \
    '-DUSE_OPENSSL=1' \
    '-DUSE_OPENSSL=1' \
    '-DWEBRTC_CODEC_ILBC' \
    '-DWEBRTC_CODEC_G722' \
    '-DWEBRTC_CODEC_OPUS' \
    '-DWEBRTC_CODEC_RED' \
    '-DWEBRTC_CODEC_ISACFX' 

