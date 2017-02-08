# Copyright (c) 2011 The WebRTC project authors. All Rights Reserved.
#
# Use of this source code is governed by a BSD-style license
# that can be found in the LICENSE file in the root of the source
# tree. An additional intellectual property rights grant can be found
# in the file PATENTS.  All contributing project authors may
# be found in the AUTHORS file in the root of the source tree.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

include $(LOCAL_PATH)/../../../../android-webrtc.mk

LOCAL_ARM_MODE := arm
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := opus
LOCAL_CPP_EXTENSION := .cc
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := \
        src/celt/bands.c \
        src/celt/celt.c \
        src/celt/celt_decoder.c \
        src/celt/celt_encoder.c \
        src/celt/celt_lpc.c \
        src/celt/cwrs.c \
        src/celt/entcode.c \
        src/celt/entdec.c \
        src/celt/entenc.c \
        src/celt/kiss_fft.c \
        src/celt/laplace.c \
        src/celt/mathops.c \
        src/celt/mdct.c \
        src/celt/modes.c \
        src/celt/pitch.c \
        src/celt/quant_bands.c \
        src/celt/rate.c \
        src/celt/vq.c \
        src/silk/A2NLSF.c \
        src/silk/ana_filt_bank_1.c \
        src/silk/biquad_alt.c \
        src/silk/bwexpander.c \
        src/silk/bwexpander_32.c \
        src/silk/check_control_input.c \
        src/silk/CNG.c \
        src/silk/code_signs.c \
        src/silk/control_audio_bandwidth.c \
        src/silk/control_codec.c \
        src/silk/control_SNR.c \
        src/silk/debug.c \
        src/silk/dec_API.c \
        src/silk/decode_core.c \
        src/silk/decode_frame.c \
        src/silk/decode_indices.c \
        src/silk/decode_parameters.c \
        src/silk/decode_pitch.c \
        src/silk/decode_pulses.c \
        src/silk/decoder_set_fs.c \
        src/silk/enc_API.c \
        src/silk/encode_indices.c \
        src/silk/encode_pulses.c \
        src/silk/gain_quant.c \
        src/silk/HP_variable_cutoff.c \
        src/silk/init_decoder.c \
        src/silk/init_encoder.c \
        src/silk/inner_prod_aligned.c \
        src/silk/interpolate.c \
        src/silk/lin2log.c \
        src/silk/log2lin.c \
        src/silk/LP_variable_cutoff.c \
        src/silk/LPC_analysis_filter.c \
        src/silk/LPC_inv_pred_gain.c \
        src/silk/NLSF2A.c \
        src/silk/NLSF_decode.c \
        src/silk/NLSF_del_dec_quant.c \
        src/silk/NLSF_encode.c \
        src/silk/NLSF_stabilize.c \
        src/silk/NLSF_unpack.c \
        src/silk/NLSF_VQ.c \
        src/silk/NLSF_VQ_weights_laroia.c \
        src/silk/NSQ.c \
        src/silk/NSQ_del_dec.c \
        src/silk/pitch_est_tables.c \
        src/silk/PLC.c \
        src/silk/process_NLSFs.c \
        src/silk/quant_LTP_gains.c \
        src/silk/resampler.c \
        src/silk/resampler_down2.c \
        src/silk/resampler_down2_3.c \
        src/silk/resampler_private_AR2.c \
        src/silk/resampler_private_down_FIR.c \
        src/silk/resampler_private_IIR_FIR.c \
        src/silk/resampler_private_up2_HQ.c \
        src/silk/resampler_rom.c \
        src/silk/shell_coder.c \
        src/silk/sigm_Q15.c \
        src/silk/sort.c \
        src/silk/stereo_decode_pred.c \
        src/silk/stereo_encode_pred.c \
        src/silk/stereo_find_predictor.c \
        src/silk/stereo_LR_to_MS.c \
        src/silk/stereo_MS_to_LR.c \
        src/silk/stereo_quant_pred.c \
        src/silk/sum_sqr_shift.c \
        src/silk/table_LSF_cos.c \
        src/silk/tables_gain.c \
        src/silk/tables_LTP.c \
        src/silk/tables_NLSF_CB_NB_MB.c \
        src/silk/tables_NLSF_CB_WB.c \
        src/silk/tables_other.c \
        src/silk/tables_pitch_lag.c \
        src/silk/tables_pulses_per_block.c \
        src/silk/VAD.c \
        src/silk/VQ_WMat_EC.c \
        src/src/analysis.c \
        src/src/mlp.c \
        src/src/mlp_data.c \
        src/src/opus.c \
        src/src/opus_decoder.c \
        src/src/opus_encoder.c \
        src/src/opus_multistream.c \
        src/src/opus_multistream_decoder.c \
        src/src/opus_multistream_encoder.c \
        src/src/repacketizer.c \
        src/silk/fixed/apply_sine_window_FIX.c \
        src/silk/fixed/autocorr_FIX.c \
        src/silk/fixed/burg_modified_FIX.c \
        src/silk/fixed/corrMatrix_FIX.c \
        src/silk/fixed/encode_frame_FIX.c \
        src/silk/fixed/find_LPC_FIX.c \
        src/silk/fixed/find_LTP_FIX.c \
        src/silk/fixed/find_pitch_lags_FIX.c \
        src/silk/fixed/find_pred_coefs_FIX.c \
        src/silk/fixed/k2a_FIX.c \
        src/silk/fixed/k2a_Q16_FIX.c \
        src/silk/fixed/LTP_analysis_filter_FIX.c \
        src/silk/fixed/LTP_scale_ctrl_FIX.c \
        src/silk/fixed/noise_shape_analysis_FIX.c \
        src/silk/fixed/pitch_analysis_core_FIX.c \
        src/silk/fixed/prefilter_FIX.c \
        src/silk/fixed/process_gains_FIX.c \
        src/silk/fixed/regularize_correlations_FIX.c \
        src/silk/fixed/residual_energy16_FIX.c \
        src/silk/fixed/residual_energy_FIX.c \
        src/silk/fixed/schur64_FIX.c \
        src/silk/fixed/schur_FIX.c \
        src/silk/fixed/solve_LS_FIX.c \
        src/silk/fixed/vector_ops_FIX.c \
        src/silk/fixed/warped_autocorrelation_FIX.c \
        src/celt/arm/arm_celt_map.c \
        src/celt/arm/armcpu.c \
        src/celt_pitch_xcorr_arm_gnu.S




# Flags passed to both C and C++ files.
LOCAL_CFLAGS := \
    $(MY_WEBRTC_COMMON_DEFS) \
    '-DNETEQ_VOICEENGINE_CODECS' \
    '-fvisibility=hidden' \
    '-DNONTHREADSAFE_PSEUDOSTACK' \
    '-DUSE_ALLOCA' \
    '-DVAR_ARRAYS' \
    '-DOPUS_BUILD' \
    '-DOPUS_EXPORT=' \
    '-DFIXED_POINT' \
    '-DOPUS_ARM_ASM' \
    '-DOPUS_ARM_INLINE_ASM' \
    '-DOPUS_ARM_INLINE_EDSP' \
    '-DOPUS_ARM_MAY_HAVE_EDSP' \
    '-DOPUS_ARM_MAY_HAVE_MEDIA' \
    '-DOPUS_ARM_MAY_HAVE_NEON' \
    '-DOPUS_HAVE_RTCD'

LOCAL_CXXFLAGS := \
    $(LOCAL_CFLAGS) 

LOCAL_CPPFLAGS := \
    $(LOCAL_CFLAGS) 


LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/ \
    $(LOCAL_PATH)/../opus/src/include \
    $(LOCAL_PATH)/../opus/src/silk \
    $(LOCAL_PATH)/../opus/src/silk/fixed \
    $(LOCAL_PATH)/../opus/src/celt \
    $(LOCAL_PATH)/../../.. \
    $(LOCAL_PATH)/../../../..



include $(BUILD_STATIC_LIBRARY)
