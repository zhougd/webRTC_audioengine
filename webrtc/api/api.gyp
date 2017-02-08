# Copyright (c) 2015 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

{
  'includes': [ '../build/common.gypi', ],
  'conditions': [
    ['OS=="ios"', {
      'targets': [
        {
          'target_name': 'rtc_api_objc',
          'type': 'static_library',
          'dependencies': [
            '<(webrtc_root)/base/base.gyp:rtc_base_objc',
          ],
          'sources': [
            'objc/RTCIceServer+Private.h',
            'objc/RTCIceServer.h',
            'objc/RTCIceServer.mm',
          ],
          'xcode_settings': {
            'CLANG_ENABLE_OBJC_ARC': 'YES',
            'CLANG_WARN_OBJC_MISSING_PROPERTY_SYNTHESIS': 'YES',
            'GCC_PREFIX_HEADER': 'objc/WebRTC-Prefix.pch',
          },
        }
      ],
    }], # OS=="ios"
  ],
}
