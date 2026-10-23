#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  extern __shared__ __align__(1024) uchar buf_dyn_shmem[];
  int indices[8];
  half_t Q_reg[16];
  float sum_acc[4];
  half_t K_reg[16];
  half_t K_reg1[16];
  half_t K_reg2[16];
  half_t K_reg3[16];
  float acc_s[4];
  half_t phase_weights[32];
  float acc_o[16];
  float acc_o_alt[16];
  half_t V_reg[16];
  half_t acc_s_cast[4];
  float scores_sum[1];
  float inv_sum[1];
  half_t O_reg[16];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    int raw_index = BlockIndices[(((((int)blockIdx.x) * 8192) + (((int)blockIdx.z) * 8)) + si)];
    indices[si] = (min(max(raw_index, -1), 64) * 16);
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.z) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  float broadcast_var = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sum_acc + 0) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  float neg_inf = -MACART_INF_F;
  int phase_k_position0 = indices[0];
  if (((0 <= phase_k_position0) && (phase_k_position0 < 1024)) && (phase_k_position0 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_1 = 0; i_1 < 2; ++i_1) {
      *(uint4*)(K_reg + (i_1 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((phase_k_position0 >> 4) * 1024)) + (i_1 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int phase_k_position1 = indices[1];
  if (((0 <= phase_k_position1) && (phase_k_position1 < 1024)) && (phase_k_position1 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      *(uint4*)(K_reg1 + (i_2 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((phase_k_position1 >> 4) * 1024)) + (i_2 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int phase_k_position2 = indices[2];
  if (((0 <= phase_k_position2) && (phase_k_position2 < 1024)) && (phase_k_position2 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_3 = 0; i_3 < 2; ++i_3) {
      *(uint4*)(K_reg2 + (i_3 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((phase_k_position2 >> 4) * 1024)) + (i_3 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int phase_k_position3 = indices[3];
  if (((0 <= phase_k_position3) && (phase_k_position3 < 1024)) && (phase_k_position3 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_4 = 0; i_4 < 2; ++i_4) {
      *(uint4*)(K_reg3 + (i_4 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((phase_k_position3 >> 4) * 1024)) + (i_4 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= phase_k_position0) && (phase_k_position0 < 1024)) && (phase_k_position0 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (phase_k_position0 + 15)) {
      #pragma unroll
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        float condval;
        if ((((((((int)threadIdx.x) >> 4) * 4) + phase_k_position0) + i_5) <= ((int)blockIdx.z))) {
          condval = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval = neg_inf;
        }
        acc_s[i_5] = condval;
      }
    } else {
      float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
    }
    for (int ki = 0; ki < 2; ++ki) {
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg) + ((ki * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 4; ++i_6) {
      acc_s[i_6] = expf(min((acc_s[i_6] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 4; ++i_7) {
      sum_acc[i_7] = (sum_acc[i_7] + acc_s[i_7]);
    }
    #pragma unroll
    for (int phase_lane = 0; phase_lane < 4; ++phase_lane) {
      phase_weights[phase_lane] = ((half_t)acc_s[phase_lane]);
    }
  }
  if (((0 <= phase_k_position1) && (phase_k_position1 < 1024)) && (phase_k_position1 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (phase_k_position1 + 15)) {
      #pragma unroll
      for (int i_8 = 0; i_8 < 4; ++i_8) {
        float condval_1;
        if ((((((((int)threadIdx.x) >> 4) * 4) + phase_k_position1) + i_8) <= ((int)blockIdx.z))) {
          condval_1 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_1 = neg_inf;
        }
        acc_s[i_8] = condval_1;
      }
    } else {
      float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
    }
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int kp_1 = 0; kp_1 < 2; ++kp_1) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg1) + ((ki_1 * 2) + kp_1)),
                    *(((float16x4*)Q_reg) + ((ki_1 * 2) + kp_1)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_9 = 0; i_9 < 4; ++i_9) {
      acc_s[i_9] = expf(min((acc_s[i_9] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_10 = 0; i_10 < 4; ++i_10) {
      sum_acc[i_10] = (sum_acc[i_10] + acc_s[i_10]);
    }
    #pragma unroll
    for (int phase_lane_1 = 0; phase_lane_1 < 4; ++phase_lane_1) {
      phase_weights[(phase_lane_1 + 4)] = ((half_t)acc_s[phase_lane_1]);
    }
  }
  if (((0 <= phase_k_position2) && (phase_k_position2 < 1024)) && (phase_k_position2 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (phase_k_position2 + 15)) {
      #pragma unroll
      for (int i_11 = 0; i_11 < 4; ++i_11) {
        float condval_2;
        if ((((((((int)threadIdx.x) >> 4) * 4) + phase_k_position2) + i_11) <= ((int)blockIdx.z))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = neg_inf;
        }
        acc_s[i_11] = condval_2;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
    for (int ki_2 = 0; ki_2 < 2; ++ki_2) {
      for (int kp_2 = 0; kp_2 < 2; ++kp_2) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg2) + ((ki_2 * 2) + kp_2)),
                    *(((float16x4*)Q_reg) + ((ki_2 * 2) + kp_2)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_12 = 0; i_12 < 4; ++i_12) {
      acc_s[i_12] = expf(min((acc_s[i_12] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_13 = 0; i_13 < 4; ++i_13) {
      sum_acc[i_13] = (sum_acc[i_13] + acc_s[i_13]);
    }
    #pragma unroll
    for (int phase_lane_2 = 0; phase_lane_2 < 4; ++phase_lane_2) {
      phase_weights[(phase_lane_2 + 8)] = ((half_t)acc_s[phase_lane_2]);
    }
  }
  if (((0 <= phase_k_position3) && (phase_k_position3 < 1024)) && (phase_k_position3 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (phase_k_position3 + 15)) {
      #pragma unroll
      for (int i_14 = 0; i_14 < 4; ++i_14) {
        float condval_3;
        if ((((((((int)threadIdx.x) >> 4) * 4) + phase_k_position3) + i_14) <= ((int)blockIdx.z))) {
          condval_3 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_3 = neg_inf;
        }
        acc_s[i_14] = condval_3;
      }
    } else {
      float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
    }
    for (int ki_3 = 0; ki_3 < 2; ++ki_3) {
      for (int kp_3 = 0; kp_3 < 2; ++kp_3) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg3) + ((ki_3 * 2) + kp_3)),
                    *(((float16x4*)Q_reg) + ((ki_3 * 2) + kp_3)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_15 = 0; i_15 < 4; ++i_15) {
      acc_s[i_15] = expf(min((acc_s[i_15] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_16 = 0; i_16 < 4; ++i_16) {
      sum_acc[i_16] = (sum_acc[i_16] + acc_s[i_16]);
    }
    #pragma unroll
    for (int phase_lane_3 = 0; phase_lane_3 < 4; ++phase_lane_3) {
      phase_weights[(phase_lane_3 + 12)] = ((half_t)acc_s[phase_lane_3]);
    }
  }
  int phase_k_position4 = indices[4];
  if (((0 <= phase_k_position4) && (phase_k_position4 < 1024)) && (phase_k_position4 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_17 = 0; i_17 < 2; ++i_17) {
      *(uint4*)(K_reg + (i_17 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((phase_k_position4 >> 4) * 1024)) + (i_17 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int phase_k_position5 = indices[5];
  if (((0 <= phase_k_position5) && (phase_k_position5 < 1024)) && (phase_k_position5 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_18 = 0; i_18 < 2; ++i_18) {
      *(uint4*)(K_reg1 + (i_18 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((phase_k_position5 >> 4) * 1024)) + (i_18 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int phase_k_position6 = indices[6];
  if (((0 <= phase_k_position6) && (phase_k_position6 < 1024)) && (phase_k_position6 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_19 = 0; i_19 < 2; ++i_19) {
      *(uint4*)(K_reg2 + (i_19 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((phase_k_position6 >> 4) * 1024)) + (i_19 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int phase_k_position7 = indices[7];
  if (((0 <= phase_k_position7) && (phase_k_position7 < 1024)) && (phase_k_position7 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_20 = 0; i_20 < 2; ++i_20) {
      *(uint4*)(K_reg3 + (i_20 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((phase_k_position7 >> 4) * 1024)) + (i_20 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= phase_k_position4) && (phase_k_position4 < 1024)) && (phase_k_position4 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (phase_k_position4 + 15)) {
      #pragma unroll
      for (int i_21 = 0; i_21 < 4; ++i_21) {
        float condval_4;
        if ((((((((int)threadIdx.x) >> 4) * 4) + phase_k_position4) + i_21) <= ((int)blockIdx.z))) {
          condval_4 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_4 = neg_inf;
        }
        acc_s[i_21] = condval_4;
      }
    } else {
      float broadcast_var_5 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_5, broadcast_var_5, broadcast_var_5, broadcast_var_5);
    }
    for (int ki_4 = 0; ki_4 < 2; ++ki_4) {
      for (int kp_4 = 0; kp_4 < 2; ++kp_4) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg) + ((ki_4 * 2) + kp_4)),
                    *(((float16x4*)Q_reg) + ((ki_4 * 2) + kp_4)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_22 = 0; i_22 < 4; ++i_22) {
      acc_s[i_22] = expf(min((acc_s[i_22] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_23 = 0; i_23 < 4; ++i_23) {
      sum_acc[i_23] = (sum_acc[i_23] + acc_s[i_23]);
    }
    #pragma unroll
    for (int phase_lane_4 = 0; phase_lane_4 < 4; ++phase_lane_4) {
      phase_weights[(phase_lane_4 + 16)] = ((half_t)acc_s[phase_lane_4]);
    }
  }
  if (((0 <= phase_k_position5) && (phase_k_position5 < 1024)) && (phase_k_position5 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (phase_k_position5 + 15)) {
      #pragma unroll
      for (int i_24 = 0; i_24 < 4; ++i_24) {
        float condval_5;
        if ((((((((int)threadIdx.x) >> 4) * 4) + phase_k_position5) + i_24) <= ((int)blockIdx.z))) {
          condval_5 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_5 = neg_inf;
        }
        acc_s[i_24] = condval_5;
      }
    } else {
      float broadcast_var_6 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_6, broadcast_var_6, broadcast_var_6, broadcast_var_6);
    }
    for (int ki_5 = 0; ki_5 < 2; ++ki_5) {
      for (int kp_5 = 0; kp_5 < 2; ++kp_5) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg1) + ((ki_5 * 2) + kp_5)),
                    *(((float16x4*)Q_reg) + ((ki_5 * 2) + kp_5)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_25 = 0; i_25 < 4; ++i_25) {
      acc_s[i_25] = expf(min((acc_s[i_25] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_26 = 0; i_26 < 4; ++i_26) {
      sum_acc[i_26] = (sum_acc[i_26] + acc_s[i_26]);
    }
    #pragma unroll
    for (int phase_lane_5 = 0; phase_lane_5 < 4; ++phase_lane_5) {
      phase_weights[(phase_lane_5 + 20)] = ((half_t)acc_s[phase_lane_5]);
    }
  }
  if (((0 <= phase_k_position6) && (phase_k_position6 < 1024)) && (phase_k_position6 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (phase_k_position6 + 15)) {
      #pragma unroll
      for (int i_27 = 0; i_27 < 4; ++i_27) {
        float condval_6;
        if ((((((((int)threadIdx.x) >> 4) * 4) + phase_k_position6) + i_27) <= ((int)blockIdx.z))) {
          condval_6 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_6 = neg_inf;
        }
        acc_s[i_27] = condval_6;
      }
    } else {
      float broadcast_var_7 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_7, broadcast_var_7, broadcast_var_7, broadcast_var_7);
    }
    for (int ki_6 = 0; ki_6 < 2; ++ki_6) {
      for (int kp_6 = 0; kp_6 < 2; ++kp_6) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg2) + ((ki_6 * 2) + kp_6)),
                    *(((float16x4*)Q_reg) + ((ki_6 * 2) + kp_6)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_28 = 0; i_28 < 4; ++i_28) {
      acc_s[i_28] = expf(min((acc_s[i_28] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_29 = 0; i_29 < 4; ++i_29) {
      sum_acc[i_29] = (sum_acc[i_29] + acc_s[i_29]);
    }
    #pragma unroll
    for (int phase_lane_6 = 0; phase_lane_6 < 4; ++phase_lane_6) {
      phase_weights[(phase_lane_6 + 24)] = ((half_t)acc_s[phase_lane_6]);
    }
  }
  if (((0 <= phase_k_position7) && (phase_k_position7 < 1024)) && (phase_k_position7 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (phase_k_position7 + 15)) {
      #pragma unroll
      for (int i_30 = 0; i_30 < 4; ++i_30) {
        float condval_7;
        if ((((((((int)threadIdx.x) >> 4) * 4) + phase_k_position7) + i_30) <= ((int)blockIdx.z))) {
          condval_7 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_7 = neg_inf;
        }
        acc_s[i_30] = condval_7;
      }
    } else {
      float broadcast_var_8 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_8, broadcast_var_8, broadcast_var_8, broadcast_var_8);
    }
    for (int ki_7 = 0; ki_7 < 2; ++ki_7) {
      for (int kp_7 = 0; kp_7 < 2; ++kp_7) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg3) + ((ki_7 * 2) + kp_7)),
                    *(((float16x4*)Q_reg) + ((ki_7 * 2) + kp_7)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_31 = 0; i_31 < 4; ++i_31) {
      acc_s[i_31] = expf(min((acc_s[i_31] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_32 = 0; i_32 < 4; ++i_32) {
      sum_acc[i_32] = (sum_acc[i_32] + acc_s[i_32]);
    }
    #pragma unroll
    for (int phase_lane_7 = 0; phase_lane_7 < 4; ++phase_lane_7) {
      phase_weights[(phase_lane_7 + 28)] = ((half_t)acc_s[phase_lane_7]);
    }
  }
  #pragma unroll
  for (int i_33 = 0; i_33 < 4; ++i_33) {
    float broadcast_var_9 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_33 * 4)) = make_float4(broadcast_var_9, broadcast_var_9, broadcast_var_9, broadcast_var_9);
  }
  #pragma unroll
  for (int i_34 = 0; i_34 < 4; ++i_34) {
    float broadcast_var_10 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o_alt + (i_34 * 4)) = make_float4(broadcast_var_10, broadcast_var_10, broadcast_var_10, broadcast_var_10);
  }
  int phase_v_position0 = indices[0];
  if (((0 <= phase_v_position0) && (phase_v_position0 < 1024)) && (phase_v_position0 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_35 = 0; i_35 < 2; ++i_35) {
      *(uint4*)(V_reg + (i_35 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((phase_v_position0 >> 4) * 1024)) + (i_35 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int phase_lane_8 = 0; phase_lane_8 < 4; ++phase_lane_8) {
      acc_s_cast[phase_lane_8] = phase_weights[phase_lane_8];
    }
    for (int j = 0; j < 4; ++j) {
      {
      *(((float32x4*)acc_o) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j));
    };
    }
  }
  int phase_v_position1 = indices[1];
  if (((0 <= phase_v_position1) && (phase_v_position1 < 1024)) && (phase_v_position1 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_36 = 0; i_36 < 2; ++i_36) {
      *(uint4*)(V_reg + (i_36 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((phase_v_position1 >> 4) * 1024)) + (i_36 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int phase_lane_9 = 0; phase_lane_9 < 4; ++phase_lane_9) {
      acc_s_cast[phase_lane_9] = phase_weights[(phase_lane_9 + 4)];
    }
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      {
      *(((float32x4*)acc_o_alt) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_1),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_alt) + j_1));
    };
    }
  }
  int phase_v_position2 = indices[2];
  if (((0 <= phase_v_position2) && (phase_v_position2 < 1024)) && (phase_v_position2 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_37 = 0; i_37 < 2; ++i_37) {
      *(uint4*)(V_reg + (i_37 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((phase_v_position2 >> 4) * 1024)) + (i_37 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int phase_lane_10 = 0; phase_lane_10 < 4; ++phase_lane_10) {
      acc_s_cast[phase_lane_10] = phase_weights[(phase_lane_10 + 8)];
    }
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      {
      *(((float32x4*)acc_o) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_2),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_2));
    };
    }
  }
  int phase_v_position3 = indices[3];
  if (((0 <= phase_v_position3) && (phase_v_position3 < 1024)) && (phase_v_position3 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_38 = 0; i_38 < 2; ++i_38) {
      *(uint4*)(V_reg + (i_38 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((phase_v_position3 >> 4) * 1024)) + (i_38 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int phase_lane_11 = 0; phase_lane_11 < 4; ++phase_lane_11) {
      acc_s_cast[phase_lane_11] = phase_weights[(phase_lane_11 + 12)];
    }
    for (int j_3 = 0; j_3 < 4; ++j_3) {
      {
      *(((float32x4*)acc_o_alt) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_3),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_alt) + j_3));
    };
    }
  }
  int phase_v_position4 = indices[4];
  if (((0 <= phase_v_position4) && (phase_v_position4 < 1024)) && (phase_v_position4 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_39 = 0; i_39 < 2; ++i_39) {
      *(uint4*)(V_reg + (i_39 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((phase_v_position4 >> 4) * 1024)) + (i_39 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int phase_lane_12 = 0; phase_lane_12 < 4; ++phase_lane_12) {
      acc_s_cast[phase_lane_12] = phase_weights[(phase_lane_12 + 16)];
    }
    for (int j_4 = 0; j_4 < 4; ++j_4) {
      {
      *(((float32x4*)acc_o) + j_4) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_4),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_4));
    };
    }
  }
  int phase_v_position5 = indices[5];
  if (((0 <= phase_v_position5) && (phase_v_position5 < 1024)) && (phase_v_position5 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_40 = 0; i_40 < 2; ++i_40) {
      *(uint4*)(V_reg + (i_40 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((phase_v_position5 >> 4) * 1024)) + (i_40 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int phase_lane_13 = 0; phase_lane_13 < 4; ++phase_lane_13) {
      acc_s_cast[phase_lane_13] = phase_weights[(phase_lane_13 + 20)];
    }
    for (int j_5 = 0; j_5 < 4; ++j_5) {
      {
      *(((float32x4*)acc_o_alt) + j_5) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_5),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_alt) + j_5));
    };
    }
  }
  int phase_v_position6 = indices[6];
  if (((0 <= phase_v_position6) && (phase_v_position6 < 1024)) && (phase_v_position6 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_41 = 0; i_41 < 2; ++i_41) {
      *(uint4*)(V_reg + (i_41 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((phase_v_position6 >> 4) * 1024)) + (i_41 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int phase_lane_14 = 0; phase_lane_14 < 4; ++phase_lane_14) {
      acc_s_cast[phase_lane_14] = phase_weights[(phase_lane_14 + 24)];
    }
    for (int j_6 = 0; j_6 < 4; ++j_6) {
      {
      *(((float32x4*)acc_o) + j_6) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_6),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_6));
    };
    }
  }
  int phase_v_position7 = indices[7];
  if (((0 <= phase_v_position7) && (phase_v_position7 < 1024)) && (phase_v_position7 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_42 = 0; i_42 < 2; ++i_42) {
      *(uint4*)(V_reg + (i_42 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((phase_v_position7 >> 4) * 1024)) + (i_42 * 512)) + (((int)threadIdx.x) * 8)));
    }
    #pragma unroll
    for (int phase_lane_15 = 0; phase_lane_15 < 4; ++phase_lane_15) {
      acc_s_cast[phase_lane_15] = phase_weights[(phase_lane_15 + 28)];
    }
    for (int j_7 = 0; j_7 < 4; ++j_7) {
      {
      *(((float32x4*)acc_o_alt) + j_7) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_7),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_alt) + j_7));
    };
    }
  }
  #pragma unroll
  for (int i_43 = 0; i_43 < 16; ++i_43) {
    acc_o[i_43] = (acc_o[i_43] + acc_o_alt[i_43]);
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + sum_acc[rv]);
  }
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[0])));
  float condval_8;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_8 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_8 = 0x0p+0f/*0.000000e+00*/;
  }
  inv_sum[0] = condval_8;
  #pragma unroll
  for (int i_44 = 0; i_44 < 16; ++i_44) {
    acc_o[i_44] = (acc_o[i_44] * inv_sum[0]);
  }
  #pragma unroll
  for (int cast_chunk = 0; cast_chunk < 4; ++cast_chunk) {
    #pragma unroll
    for (int cast_lane = 0; cast_lane < 4; ++cast_lane) {
      O_reg[((cast_chunk * 4) + cast_lane)] = ((half_t)acc_o[((cast_chunk * 4) + cast_lane)]);
    }
  }
  #pragma unroll
  for (int i_45 = 0; i_45 < 4; ++i_45) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_45 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_45 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_46 = 0; i_46 < 2; ++i_46) {
    *(uint4*)(Output + ((((((int)blockIdx.x) * 1048576) + (((int)blockIdx.z) * 1024)) + (i_46 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_46 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

