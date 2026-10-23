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
  float acc_o[16];
  float acc_o_alt[16];
  float sum_acc[4];
  half_t K_ring0[16];
  half_t K_ring1[16];
  half_t V_ring0[16];
  half_t V_ring1[16];
  float acc_s[4];
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
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 4; ++i_2) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o_alt + (i_2 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sum_acc + 0) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
  float neg_inf = -MACART_INF_F;
  int ring_k_position0 = indices[0];
  if (((0 <= ring_k_position0) && (ring_k_position0 < 1024)) && (ring_k_position0 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_3 = 0; i_3 < 2; ++i_3) {
      *(uint4*)(K_ring0 + (i_3 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((ring_k_position0 >> 4) * 1024)) + (i_3 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_k_position1 = indices[1];
  if (((0 <= ring_k_position1) && (ring_k_position1 < 1024)) && (ring_k_position1 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_4 = 0; i_4 < 2; ++i_4) {
      *(uint4*)(K_ring1 + (i_4 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((ring_k_position1 >> 4) * 1024)) + (i_4 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_v_position0 = indices[0];
  if (((0 <= ring_v_position0) && (ring_v_position0 < 1024)) && (ring_v_position0 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_5 = 0; i_5 < 2; ++i_5) {
      *(uint4*)(V_ring0 + (i_5 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((ring_v_position0 >> 4) * 1024)) + (i_5 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_v_position1 = indices[1];
  if (((0 <= ring_v_position1) && (ring_v_position1 < 1024)) && (ring_v_position1 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_6 = 0; i_6 < 2; ++i_6) {
      *(uint4*)(V_ring1 + (i_6 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((ring_v_position1 >> 4) * 1024)) + (i_6 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_position0 = indices[0];
  if (((0 <= ring_position0) && (ring_position0 < 1024)) && (ring_position0 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (ring_position0 + 15)) {
      #pragma unroll
      for (int i_7 = 0; i_7 < 4; ++i_7) {
        float condval;
        if ((((((((int)threadIdx.x) >> 4) * 4) + ring_position0) + i_7) <= ((int)blockIdx.z))) {
          condval = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval = neg_inf;
        }
        acc_s[i_7] = condval;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
    for (int ki = 0; ki < 2; ++ki) {
      for (int kp = 0; kp < 2; ++kp) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_ring0) + ((ki * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
  }
  int ring_k_position2 = indices[2];
  if (((0 <= ring_k_position2) && (ring_k_position2 < 1024)) && (ring_k_position2 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      *(uint4*)(K_ring0 + (i_8 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((ring_k_position2 >> 4) * 1024)) + (i_8 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= ring_position0) && (ring_position0 < 1024)) && (ring_position0 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_9 = 0; i_9 < 4; ++i_9) {
      acc_s[i_9] = expf(min((acc_s[i_9] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_10 = 0; i_10 < 4; ++i_10) {
      sum_acc[i_10] = (sum_acc[i_10] + acc_s[i_10]);
    }
    #pragma unroll
    for (int cast_lane = 0; cast_lane < 4; ++cast_lane) {
      acc_s_cast[cast_lane] = ((half_t)acc_s[cast_lane]);
    }
    for (int j = 0; j < 4; ++j) {
      {
      *(((float32x4*)acc_o) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_ring0) + j),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j));
    };
    }
  }
  int ring_v_position2 = indices[2];
  if (((0 <= ring_v_position2) && (ring_v_position2 < 1024)) && (ring_v_position2 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_11 = 0; i_11 < 2; ++i_11) {
      *(uint4*)(V_ring0 + (i_11 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((ring_v_position2 >> 4) * 1024)) + (i_11 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_position1 = indices[1];
  if (((0 <= ring_position1) && (ring_position1 < 1024)) && (ring_position1 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (ring_position1 + 15)) {
      #pragma unroll
      for (int i_12 = 0; i_12 < 4; ++i_12) {
        float condval_1;
        if ((((((((int)threadIdx.x) >> 4) * 4) + ring_position1) + i_12) <= ((int)blockIdx.z))) {
          condval_1 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_1 = neg_inf;
        }
        acc_s[i_12] = condval_1;
      }
    } else {
      float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
    }
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int kp_1 = 0; kp_1 < 2; ++kp_1) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_ring1) + ((ki_1 * 2) + kp_1)),
                    *(((float16x4*)Q_reg) + ((ki_1 * 2) + kp_1)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
  }
  int ring_k_position3 = indices[3];
  if (((0 <= ring_k_position3) && (ring_k_position3 < 1024)) && (ring_k_position3 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_13 = 0; i_13 < 2; ++i_13) {
      *(uint4*)(K_ring1 + (i_13 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((ring_k_position3 >> 4) * 1024)) + (i_13 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= ring_position1) && (ring_position1 < 1024)) && (ring_position1 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_14 = 0; i_14 < 4; ++i_14) {
      acc_s[i_14] = expf(min((acc_s[i_14] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_15 = 0; i_15 < 4; ++i_15) {
      sum_acc[i_15] = (sum_acc[i_15] + acc_s[i_15]);
    }
    #pragma unroll
    for (int cast_lane_1 = 0; cast_lane_1 < 4; ++cast_lane_1) {
      acc_s_cast[cast_lane_1] = ((half_t)acc_s[cast_lane_1]);
    }
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      {
      *(((float32x4*)acc_o_alt) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_ring1) + j_1),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_alt) + j_1));
    };
    }
  }
  int ring_v_position3 = indices[3];
  if (((0 <= ring_v_position3) && (ring_v_position3 < 1024)) && (ring_v_position3 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_16 = 0; i_16 < 2; ++i_16) {
      *(uint4*)(V_ring1 + (i_16 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((ring_v_position3 >> 4) * 1024)) + (i_16 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_position2 = indices[2];
  if (((0 <= ring_position2) && (ring_position2 < 1024)) && (ring_position2 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (ring_position2 + 15)) {
      #pragma unroll
      for (int i_17 = 0; i_17 < 4; ++i_17) {
        float condval_2;
        if ((((((((int)threadIdx.x) >> 4) * 4) + ring_position2) + i_17) <= ((int)blockIdx.z))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = neg_inf;
        }
        acc_s[i_17] = condval_2;
      }
    } else {
      float broadcast_var_5 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_5, broadcast_var_5, broadcast_var_5, broadcast_var_5);
    }
    for (int ki_2 = 0; ki_2 < 2; ++ki_2) {
      for (int kp_2 = 0; kp_2 < 2; ++kp_2) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_ring0) + ((ki_2 * 2) + kp_2)),
                    *(((float16x4*)Q_reg) + ((ki_2 * 2) + kp_2)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
  }
  int ring_k_position4 = indices[4];
  if (((0 <= ring_k_position4) && (ring_k_position4 < 1024)) && (ring_k_position4 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_18 = 0; i_18 < 2; ++i_18) {
      *(uint4*)(K_ring0 + (i_18 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((ring_k_position4 >> 4) * 1024)) + (i_18 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= ring_position2) && (ring_position2 < 1024)) && (ring_position2 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_19 = 0; i_19 < 4; ++i_19) {
      acc_s[i_19] = expf(min((acc_s[i_19] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_20 = 0; i_20 < 4; ++i_20) {
      sum_acc[i_20] = (sum_acc[i_20] + acc_s[i_20]);
    }
    #pragma unroll
    for (int cast_lane_2 = 0; cast_lane_2 < 4; ++cast_lane_2) {
      acc_s_cast[cast_lane_2] = ((half_t)acc_s[cast_lane_2]);
    }
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      {
      *(((float32x4*)acc_o) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_ring0) + j_2),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_2));
    };
    }
  }
  int ring_v_position4 = indices[4];
  if (((0 <= ring_v_position4) && (ring_v_position4 < 1024)) && (ring_v_position4 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_21 = 0; i_21 < 2; ++i_21) {
      *(uint4*)(V_ring0 + (i_21 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((ring_v_position4 >> 4) * 1024)) + (i_21 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_position3 = indices[3];
  if (((0 <= ring_position3) && (ring_position3 < 1024)) && (ring_position3 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (ring_position3 + 15)) {
      #pragma unroll
      for (int i_22 = 0; i_22 < 4; ++i_22) {
        float condval_3;
        if ((((((((int)threadIdx.x) >> 4) * 4) + ring_position3) + i_22) <= ((int)blockIdx.z))) {
          condval_3 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_3 = neg_inf;
        }
        acc_s[i_22] = condval_3;
      }
    } else {
      float broadcast_var_6 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_6, broadcast_var_6, broadcast_var_6, broadcast_var_6);
    }
    for (int ki_3 = 0; ki_3 < 2; ++ki_3) {
      for (int kp_3 = 0; kp_3 < 2; ++kp_3) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_ring1) + ((ki_3 * 2) + kp_3)),
                    *(((float16x4*)Q_reg) + ((ki_3 * 2) + kp_3)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
  }
  int ring_k_position5 = indices[5];
  if (((0 <= ring_k_position5) && (ring_k_position5 < 1024)) && (ring_k_position5 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_23 = 0; i_23 < 2; ++i_23) {
      *(uint4*)(K_ring1 + (i_23 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((ring_k_position5 >> 4) * 1024)) + (i_23 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= ring_position3) && (ring_position3 < 1024)) && (ring_position3 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_24 = 0; i_24 < 4; ++i_24) {
      acc_s[i_24] = expf(min((acc_s[i_24] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_25 = 0; i_25 < 4; ++i_25) {
      sum_acc[i_25] = (sum_acc[i_25] + acc_s[i_25]);
    }
    #pragma unroll
    for (int cast_lane_3 = 0; cast_lane_3 < 4; ++cast_lane_3) {
      acc_s_cast[cast_lane_3] = ((half_t)acc_s[cast_lane_3]);
    }
    for (int j_3 = 0; j_3 < 4; ++j_3) {
      {
      *(((float32x4*)acc_o_alt) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_ring1) + j_3),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_alt) + j_3));
    };
    }
  }
  int ring_v_position5 = indices[5];
  if (((0 <= ring_v_position5) && (ring_v_position5 < 1024)) && (ring_v_position5 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_26 = 0; i_26 < 2; ++i_26) {
      *(uint4*)(V_ring1 + (i_26 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((ring_v_position5 >> 4) * 1024)) + (i_26 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_position4 = indices[4];
  if (((0 <= ring_position4) && (ring_position4 < 1024)) && (ring_position4 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (ring_position4 + 15)) {
      #pragma unroll
      for (int i_27 = 0; i_27 < 4; ++i_27) {
        float condval_4;
        if ((((((((int)threadIdx.x) >> 4) * 4) + ring_position4) + i_27) <= ((int)blockIdx.z))) {
          condval_4 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_4 = neg_inf;
        }
        acc_s[i_27] = condval_4;
      }
    } else {
      float broadcast_var_7 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_7, broadcast_var_7, broadcast_var_7, broadcast_var_7);
    }
    for (int ki_4 = 0; ki_4 < 2; ++ki_4) {
      for (int kp_4 = 0; kp_4 < 2; ++kp_4) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_ring0) + ((ki_4 * 2) + kp_4)),
                    *(((float16x4*)Q_reg) + ((ki_4 * 2) + kp_4)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
  }
  int ring_k_position6 = indices[6];
  if (((0 <= ring_k_position6) && (ring_k_position6 < 1024)) && (ring_k_position6 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_28 = 0; i_28 < 2; ++i_28) {
      *(uint4*)(K_ring0 + (i_28 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((ring_k_position6 >> 4) * 1024)) + (i_28 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= ring_position4) && (ring_position4 < 1024)) && (ring_position4 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_29 = 0; i_29 < 4; ++i_29) {
      acc_s[i_29] = expf(min((acc_s[i_29] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_30 = 0; i_30 < 4; ++i_30) {
      sum_acc[i_30] = (sum_acc[i_30] + acc_s[i_30]);
    }
    #pragma unroll
    for (int cast_lane_4 = 0; cast_lane_4 < 4; ++cast_lane_4) {
      acc_s_cast[cast_lane_4] = ((half_t)acc_s[cast_lane_4]);
    }
    for (int j_4 = 0; j_4 < 4; ++j_4) {
      {
      *(((float32x4*)acc_o) + j_4) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_ring0) + j_4),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_4));
    };
    }
  }
  int ring_v_position6 = indices[6];
  if (((0 <= ring_v_position6) && (ring_v_position6 < 1024)) && (ring_v_position6 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_31 = 0; i_31 < 2; ++i_31) {
      *(uint4*)(V_ring0 + (i_31 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((ring_v_position6 >> 4) * 1024)) + (i_31 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_position5 = indices[5];
  if (((0 <= ring_position5) && (ring_position5 < 1024)) && (ring_position5 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (ring_position5 + 15)) {
      #pragma unroll
      for (int i_32 = 0; i_32 < 4; ++i_32) {
        float condval_5;
        if ((((((((int)threadIdx.x) >> 4) * 4) + ring_position5) + i_32) <= ((int)blockIdx.z))) {
          condval_5 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_5 = neg_inf;
        }
        acc_s[i_32] = condval_5;
      }
    } else {
      float broadcast_var_8 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_8, broadcast_var_8, broadcast_var_8, broadcast_var_8);
    }
    for (int ki_5 = 0; ki_5 < 2; ++ki_5) {
      for (int kp_5 = 0; kp_5 < 2; ++kp_5) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_ring1) + ((ki_5 * 2) + kp_5)),
                    *(((float16x4*)Q_reg) + ((ki_5 * 2) + kp_5)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
  }
  int ring_k_position7 = indices[7];
  if (((0 <= ring_k_position7) && (ring_k_position7 < 1024)) && (ring_k_position7 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_33 = 0; i_33 < 2; ++i_33) {
      *(uint4*)(K_ring1 + (i_33 * 8)) = *(uint4*)(K + ((((((int)blockIdx.x) * 65536) + ((ring_k_position7 >> 4) * 1024)) + (i_33 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= ring_position5) && (ring_position5 < 1024)) && (ring_position5 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_34 = 0; i_34 < 4; ++i_34) {
      acc_s[i_34] = expf(min((acc_s[i_34] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_35 = 0; i_35 < 4; ++i_35) {
      sum_acc[i_35] = (sum_acc[i_35] + acc_s[i_35]);
    }
    #pragma unroll
    for (int cast_lane_5 = 0; cast_lane_5 < 4; ++cast_lane_5) {
      acc_s_cast[cast_lane_5] = ((half_t)acc_s[cast_lane_5]);
    }
    for (int j_5 = 0; j_5 < 4; ++j_5) {
      {
      *(((float32x4*)acc_o_alt) + j_5) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_ring1) + j_5),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_alt) + j_5));
    };
    }
  }
  int ring_v_position7 = indices[7];
  if (((0 <= ring_v_position7) && (ring_v_position7 < 1024)) && (ring_v_position7 <= ((int)blockIdx.z))) {
    #pragma unroll
    for (int i_36 = 0; i_36 < 2; ++i_36) {
      *(uint4*)(V_ring1 + (i_36 * 8)) = *(uint4*)(V + ((((((int)blockIdx.x) * 65536) + ((ring_v_position7 >> 4) * 1024)) + (i_36 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  int ring_position6 = indices[6];
  if (((0 <= ring_position6) && (ring_position6 < 1024)) && (ring_position6 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (ring_position6 + 15)) {
      #pragma unroll
      for (int i_37 = 0; i_37 < 4; ++i_37) {
        float condval_6;
        if ((((((((int)threadIdx.x) >> 4) * 4) + ring_position6) + i_37) <= ((int)blockIdx.z))) {
          condval_6 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_6 = neg_inf;
        }
        acc_s[i_37] = condval_6;
      }
    } else {
      float broadcast_var_9 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_9, broadcast_var_9, broadcast_var_9, broadcast_var_9);
    }
    for (int ki_6 = 0; ki_6 < 2; ++ki_6) {
      for (int kp_6 = 0; kp_6 < 2; ++kp_6) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_ring0) + ((ki_6 * 2) + kp_6)),
                    *(((float16x4*)Q_reg) + ((ki_6 * 2) + kp_6)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_38 = 0; i_38 < 4; ++i_38) {
      acc_s[i_38] = expf(min((acc_s[i_38] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_39 = 0; i_39 < 4; ++i_39) {
      sum_acc[i_39] = (sum_acc[i_39] + acc_s[i_39]);
    }
    #pragma unroll
    for (int cast_lane_6 = 0; cast_lane_6 < 4; ++cast_lane_6) {
      acc_s_cast[cast_lane_6] = ((half_t)acc_s[cast_lane_6]);
    }
    for (int j_6 = 0; j_6 < 4; ++j_6) {
      {
      *(((float32x4*)acc_o) + j_6) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_ring0) + j_6),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_6));
    };
    }
  }
  int ring_position7 = indices[7];
  if (((0 <= ring_position7) && (ring_position7 < 1024)) && (ring_position7 <= ((int)blockIdx.z))) {
    if (((int)blockIdx.z) < (ring_position7 + 15)) {
      #pragma unroll
      for (int i_40 = 0; i_40 < 4; ++i_40) {
        float condval_7;
        if ((((((((int)threadIdx.x) >> 4) * 4) + ring_position7) + i_40) <= ((int)blockIdx.z))) {
          condval_7 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_7 = neg_inf;
        }
        acc_s[i_40] = condval_7;
      }
    } else {
      float broadcast_var_10 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_10, broadcast_var_10, broadcast_var_10, broadcast_var_10);
    }
    for (int ki_7 = 0; ki_7 < 2; ++ki_7) {
      for (int kp_7 = 0; kp_7 < 2; ++kp_7) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_ring1) + ((ki_7 * 2) + kp_7)),
                    *(((float16x4*)Q_reg) + ((ki_7 * 2) + kp_7)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_41 = 0; i_41 < 4; ++i_41) {
      acc_s[i_41] = expf(min((acc_s[i_41] * 0x1.999999955d99cp-4f/*1.000000e-01*/), 0x1.4cb5ecf0a965p+3f/*1.039721e+01*/));
    }
    #pragma unroll
    for (int i_42 = 0; i_42 < 4; ++i_42) {
      sum_acc[i_42] = (sum_acc[i_42] + acc_s[i_42]);
    }
    #pragma unroll
    for (int cast_lane_7 = 0; cast_lane_7 < 4; ++cast_lane_7) {
      acc_s_cast[cast_lane_7] = ((half_t)acc_s[cast_lane_7]);
    }
    for (int j_7 = 0; j_7 < 4; ++j_7) {
      {
      *(((float32x4*)acc_o_alt) + j_7) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_ring1) + j_7),
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
    for (int cast_lane_8 = 0; cast_lane_8 < 4; ++cast_lane_8) {
      O_reg[((cast_chunk * 4) + cast_lane_8)] = ((half_t)acc_o[((cast_chunk * 4) + cast_lane_8)]);
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

