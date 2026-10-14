#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(128, 1) kernel_kernel(const half_t* __restrict__ K, half_t* __restrict__ Packed, half_t* __restrict__ PackedK, const half_t* __restrict__ V) {
  half_t ktile[8];
  half_t tile[8];
  *(uint4*)(ktile + 0) = *(uint4*)(K + ((((int)blockIdx.x) * 1024) + (((int)threadIdx.x) * 8)));
  *(uint4*)(PackedK + (((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + ((((int)blockIdx.x) * 1024) + (((int)threadIdx.x) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[(((((((((int)blockIdx.x) * 1024) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
  }
}

#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  int indices[8];
  half_t Q_reg[16];
  float acc_o[16];
  float sum_acc[4];
  float scores_sum[1];
  float inv_sum[1];
  half_t K_reg[16];
  half_t K_reg1[16];
  half_t K_reg2[16];
  half_t K_reg3[16];
  half_t K_reg4[16];
  half_t K_reg5[16];
  half_t K_reg6[16];
  half_t K_reg7[16];
  half_t V_reg[16];
  float acc_s[4];
  half_t acc_s_cast[4];
  extern __shared__ __align__(1024) float workspace[];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    indices[si] = (BlockIndices[((((int)blockIdx.x) * 8) + si)] * 16);
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sum_acc + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  float neg_inf = -MACART_INF_F;
  int i_s0 = indices[0];
  int i_s1 = indices[1];
  int i_s2 = indices[2];
  int i_s3 = indices[3];
  int i_s4 = indices[4];
  int i_s5 = indices[5];
  int i_s6 = indices[6];
  int i_s7 = indices[7];
  if (((0 <= i_s0) && (i_s0 < 256)) && (i_s0 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 2; ++i_2) {
      *(uint4*)(K_reg + (i_2 * 8)) = *(uint4*)(K + ((((i_s0 >> 4) * 1024) + (i_2 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= i_s1) && (i_s1 < 256)) && (i_s1 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_3 = 0; i_3 < 2; ++i_3) {
      *(uint4*)(K_reg1 + (i_3 * 8)) = *(uint4*)(K + ((((i_s1 >> 4) * 1024) + (i_3 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= i_s2) && (i_s2 < 256)) && (i_s2 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_4 = 0; i_4 < 2; ++i_4) {
      *(uint4*)(K_reg2 + (i_4 * 8)) = *(uint4*)(K + ((((i_s2 >> 4) * 1024) + (i_4 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= i_s3) && (i_s3 < 256)) && (i_s3 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_5 = 0; i_5 < 2; ++i_5) {
      *(uint4*)(K_reg3 + (i_5 * 8)) = *(uint4*)(K + ((((i_s3 >> 4) * 1024) + (i_5 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= i_s4) && (i_s4 < 256)) && (i_s4 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_6 = 0; i_6 < 2; ++i_6) {
      *(uint4*)(K_reg4 + (i_6 * 8)) = *(uint4*)(K + ((((i_s4 >> 4) * 1024) + (i_6 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= i_s5) && (i_s5 < 256)) && (i_s5 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_7 = 0; i_7 < 2; ++i_7) {
      *(uint4*)(K_reg5 + (i_7 * 8)) = *(uint4*)(K + ((((i_s5 >> 4) * 1024) + (i_7 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= i_s6) && (i_s6 < 256)) && (i_s6 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_8 = 0; i_8 < 2; ++i_8) {
      *(uint4*)(K_reg6 + (i_8 * 8)) = *(uint4*)(K + ((((i_s6 >> 4) * 1024) + (i_8 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= i_s7) && (i_s7 < 256)) && (i_s7 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_9 = 0; i_9 < 2; ++i_9) {
      *(uint4*)(K_reg7 + (i_9 * 8)) = *(uint4*)(K + ((((i_s7 >> 4) * 1024) + (i_9 * 512)) + (((int)threadIdx.x) * 8)));
    }
  }
  if (((0 <= i_s0) && (i_s0 < 256)) && (i_s0 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_10 = 0; i_10 < 2; ++i_10) {
      *(uint4*)(V_reg + (i_10 * 8)) = *(uint4*)(V + ((((i_s0 >> 4) * 1024) + (i_10 * 512)) + (((int)threadIdx.x) * 8)));
    }
    if (((int)blockIdx.x) < (i_s0 + 15)) {
      #pragma unroll
      for (int i_11 = 0; i_11 < 4; ++i_11) {
        float condval;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s0) + i_11) <= ((int)blockIdx.x))) {
          condval = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval = neg_inf;
        }
        acc_s[i_11] = condval;
      }
    } else {
      float broadcast_var_2 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_2, broadcast_var_2, broadcast_var_2, broadcast_var_2);
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
    for (int i_12 = 0; i_12 < 4; ++i_12) {
      acc_s[i_12] = exp2f(min((acc_s[i_12] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_13 = 0; i_13 < 4; ++i_13) {
      sum_acc[i_13] = (sum_acc[i_13] + acc_s[i_13]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + 0) = __1;
    for (int j = 0; j < 4; ++j) {
      {
      *(((float32x4*)acc_o) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j));
    };
    }
  }
  if (((0 <= i_s1) && (i_s1 < 256)) && (i_s1 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_14 = 0; i_14 < 2; ++i_14) {
      *(uint4*)(V_reg + (i_14 * 8)) = *(uint4*)(V + ((((i_s1 >> 4) * 1024) + (i_14 * 512)) + (((int)threadIdx.x) * 8)));
    }
    if (((int)blockIdx.x) < (i_s1 + 15)) {
      #pragma unroll
      for (int i_15 = 0; i_15 < 4; ++i_15) {
        float condval_1;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s1) + i_15) <= ((int)blockIdx.x))) {
          condval_1 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_1 = neg_inf;
        }
        acc_s[i_15] = condval_1;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
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
    for (int i_16 = 0; i_16 < 4; ++i_16) {
      acc_s[i_16] = exp2f(min((acc_s[i_16] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_17 = 0; i_17 < 4; ++i_17) {
      sum_acc[i_17] = (sum_acc[i_17] + acc_s[i_17]);
    }
    uint2 __2;
    float4 v__1 = *(float4*)(acc_s + 0);
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(acc_s_cast + 0) = __2;
    for (int j_1 = 0; j_1 < 4; ++j_1) {
      {
      *(((float32x4*)acc_o) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_1),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_1));
    };
    }
  }
  if (((0 <= i_s2) && (i_s2 < 256)) && (i_s2 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_18 = 0; i_18 < 2; ++i_18) {
      *(uint4*)(V_reg + (i_18 * 8)) = *(uint4*)(V + ((((i_s2 >> 4) * 1024) + (i_18 * 512)) + (((int)threadIdx.x) * 8)));
    }
    if (((int)blockIdx.x) < (i_s2 + 15)) {
      #pragma unroll
      for (int i_19 = 0; i_19 < 4; ++i_19) {
        float condval_2;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s2) + i_19) <= ((int)blockIdx.x))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = neg_inf;
        }
        acc_s[i_19] = condval_2;
      }
    } else {
      float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
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
    for (int i_20 = 0; i_20 < 4; ++i_20) {
      acc_s[i_20] = exp2f(min((acc_s[i_20] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_21 = 0; i_21 < 4; ++i_21) {
      sum_acc[i_21] = (sum_acc[i_21] + acc_s[i_21]);
    }
    uint2 __3;
    float4 v__2 = *(float4*)(acc_s + 0);
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
    *(uint2*)(acc_s_cast + 0) = __3;
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      {
      *(((float32x4*)acc_o) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_2),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_2));
    };
    }
  }
  if (((0 <= i_s3) && (i_s3 < 256)) && (i_s3 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_22 = 0; i_22 < 2; ++i_22) {
      *(uint4*)(V_reg + (i_22 * 8)) = *(uint4*)(V + ((((i_s3 >> 4) * 1024) + (i_22 * 512)) + (((int)threadIdx.x) * 8)));
    }
    if (((int)blockIdx.x) < (i_s3 + 15)) {
      #pragma unroll
      for (int i_23 = 0; i_23 < 4; ++i_23) {
        float condval_3;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s3) + i_23) <= ((int)blockIdx.x))) {
          condval_3 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_3 = neg_inf;
        }
        acc_s[i_23] = condval_3;
      }
    } else {
      float broadcast_var_5 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_5, broadcast_var_5, broadcast_var_5, broadcast_var_5);
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
    for (int i_24 = 0; i_24 < 4; ++i_24) {
      acc_s[i_24] = exp2f(min((acc_s[i_24] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_25 = 0; i_25 < 4; ++i_25) {
      sum_acc[i_25] = (sum_acc[i_25] + acc_s[i_25]);
    }
    uint2 __4;
    float4 v__3 = *(float4*)(acc_s + 0);
    ((half2*)(&__4))[0] = __float22half2_rn(((float2*)(&v__3))[0]);
    ((half2*)(&__4))[1] = __float22half2_rn(((float2*)(&v__3))[1]);
    *(uint2*)(acc_s_cast + 0) = __4;
    for (int j_3 = 0; j_3 < 4; ++j_3) {
      {
      *(((float32x4*)acc_o) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_3),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_3));
    };
    }
  }
  if (((0 <= i_s4) && (i_s4 < 256)) && (i_s4 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_26 = 0; i_26 < 2; ++i_26) {
      *(uint4*)(V_reg + (i_26 * 8)) = *(uint4*)(V + ((((i_s4 >> 4) * 1024) + (i_26 * 512)) + (((int)threadIdx.x) * 8)));
    }
    if (((int)blockIdx.x) < (i_s4 + 15)) {
      #pragma unroll
      for (int i_27 = 0; i_27 < 4; ++i_27) {
        float condval_4;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s4) + i_27) <= ((int)blockIdx.x))) {
          condval_4 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_4 = neg_inf;
        }
        acc_s[i_27] = condval_4;
      }
    } else {
      float broadcast_var_6 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_6, broadcast_var_6, broadcast_var_6, broadcast_var_6);
    }
    for (int ki_4 = 0; ki_4 < 2; ++ki_4) {
      for (int kp_4 = 0; kp_4 < 2; ++kp_4) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg4) + ((ki_4 * 2) + kp_4)),
                    *(((float16x4*)Q_reg) + ((ki_4 * 2) + kp_4)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_28 = 0; i_28 < 4; ++i_28) {
      acc_s[i_28] = exp2f(min((acc_s[i_28] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_29 = 0; i_29 < 4; ++i_29) {
      sum_acc[i_29] = (sum_acc[i_29] + acc_s[i_29]);
    }
    uint2 __5;
    float4 v__4 = *(float4*)(acc_s + 0);
    ((half2*)(&__5))[0] = __float22half2_rn(((float2*)(&v__4))[0]);
    ((half2*)(&__5))[1] = __float22half2_rn(((float2*)(&v__4))[1]);
    *(uint2*)(acc_s_cast + 0) = __5;
    for (int j_4 = 0; j_4 < 4; ++j_4) {
      {
      *(((float32x4*)acc_o) + j_4) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_4),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_4));
    };
    }
  }
  if (((0 <= i_s5) && (i_s5 < 256)) && (i_s5 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_30 = 0; i_30 < 2; ++i_30) {
      *(uint4*)(V_reg + (i_30 * 8)) = *(uint4*)(V + ((((i_s5 >> 4) * 1024) + (i_30 * 512)) + (((int)threadIdx.x) * 8)));
    }
    if (((int)blockIdx.x) < (i_s5 + 15)) {
      #pragma unroll
      for (int i_31 = 0; i_31 < 4; ++i_31) {
        float condval_5;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s5) + i_31) <= ((int)blockIdx.x))) {
          condval_5 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_5 = neg_inf;
        }
        acc_s[i_31] = condval_5;
      }
    } else {
      float broadcast_var_7 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_7, broadcast_var_7, broadcast_var_7, broadcast_var_7);
    }
    for (int ki_5 = 0; ki_5 < 2; ++ki_5) {
      for (int kp_5 = 0; kp_5 < 2; ++kp_5) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg5) + ((ki_5 * 2) + kp_5)),
                    *(((float16x4*)Q_reg) + ((ki_5 * 2) + kp_5)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_32 = 0; i_32 < 4; ++i_32) {
      acc_s[i_32] = exp2f(min((acc_s[i_32] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_33 = 0; i_33 < 4; ++i_33) {
      sum_acc[i_33] = (sum_acc[i_33] + acc_s[i_33]);
    }
    uint2 __6;
    float4 v__5 = *(float4*)(acc_s + 0);
    ((half2*)(&__6))[0] = __float22half2_rn(((float2*)(&v__5))[0]);
    ((half2*)(&__6))[1] = __float22half2_rn(((float2*)(&v__5))[1]);
    *(uint2*)(acc_s_cast + 0) = __6;
    for (int j_5 = 0; j_5 < 4; ++j_5) {
      {
      *(((float32x4*)acc_o) + j_5) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_5),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_5));
    };
    }
  }
  if (((0 <= i_s6) && (i_s6 < 256)) && (i_s6 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_34 = 0; i_34 < 2; ++i_34) {
      *(uint4*)(V_reg + (i_34 * 8)) = *(uint4*)(V + ((((i_s6 >> 4) * 1024) + (i_34 * 512)) + (((int)threadIdx.x) * 8)));
    }
    if (((int)blockIdx.x) < (i_s6 + 15)) {
      #pragma unroll
      for (int i_35 = 0; i_35 < 4; ++i_35) {
        float condval_6;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s6) + i_35) <= ((int)blockIdx.x))) {
          condval_6 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_6 = neg_inf;
        }
        acc_s[i_35] = condval_6;
      }
    } else {
      float broadcast_var_8 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_8, broadcast_var_8, broadcast_var_8, broadcast_var_8);
    }
    for (int ki_6 = 0; ki_6 < 2; ++ki_6) {
      for (int kp_6 = 0; kp_6 < 2; ++kp_6) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg6) + ((ki_6 * 2) + kp_6)),
                    *(((float16x4*)Q_reg) + ((ki_6 * 2) + kp_6)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_36 = 0; i_36 < 4; ++i_36) {
      acc_s[i_36] = exp2f(min((acc_s[i_36] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_37 = 0; i_37 < 4; ++i_37) {
      sum_acc[i_37] = (sum_acc[i_37] + acc_s[i_37]);
    }
    uint2 __7;
    float4 v__6 = *(float4*)(acc_s + 0);
    ((half2*)(&__7))[0] = __float22half2_rn(((float2*)(&v__6))[0]);
    ((half2*)(&__7))[1] = __float22half2_rn(((float2*)(&v__6))[1]);
    *(uint2*)(acc_s_cast + 0) = __7;
    for (int j_6 = 0; j_6 < 4; ++j_6) {
      {
      *(((float32x4*)acc_o) + j_6) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_6),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_6));
    };
    }
  }
  if (((0 <= i_s7) && (i_s7 < 256)) && (i_s7 <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_38 = 0; i_38 < 2; ++i_38) {
      *(uint4*)(V_reg + (i_38 * 8)) = *(uint4*)(V + ((((i_s7 >> 4) * 1024) + (i_38 * 512)) + (((int)threadIdx.x) * 8)));
    }
    if (((int)blockIdx.x) < (i_s7 + 15)) {
      #pragma unroll
      for (int i_39 = 0; i_39 < 4; ++i_39) {
        float condval_7;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s7) + i_39) <= ((int)blockIdx.x))) {
          condval_7 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_7 = neg_inf;
        }
        acc_s[i_39] = condval_7;
      }
    } else {
      float broadcast_var_9 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_9, broadcast_var_9, broadcast_var_9, broadcast_var_9);
    }
    for (int ki_7 = 0; ki_7 < 2; ++ki_7) {
      for (int kp_7 = 0; kp_7 < 2; ++kp_7) {
        {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg7) + ((ki_7 * 2) + kp_7)),
                    *(((float16x4*)Q_reg) + ((ki_7 * 2) + kp_7)),
                    *(((float32x4*)acc_s) + 0));
    };
      }
    }
    #pragma unroll
    for (int i_40 = 0; i_40 < 4; ++i_40) {
      acc_s[i_40] = exp2f(min((acc_s[i_40] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_41 = 0; i_41 < 4; ++i_41) {
      sum_acc[i_41] = (sum_acc[i_41] + acc_s[i_41]);
    }
    uint2 __8;
    float4 v__7 = *(float4*)(acc_s + 0);
    ((half2*)(&__8))[0] = __float22half2_rn(((float2*)(&v__7))[0]);
    ((half2*)(&__8))[1] = __float22half2_rn(((float2*)(&v__7))[1]);
    *(uint2*)(acc_s_cast + 0) = __8;
    for (int j_7 = 0; j_7 < 4; ++j_7) {
      {
      *(((float32x4*)acc_o) + j_7) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + j_7),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_7));
    };
    }
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + sum_acc[rv]);
  }
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(workspace[0])));
  float condval_8;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_8 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_8 = 0x0p+0f/*0.000000e+00*/;
  }
  inv_sum[0] = condval_8;
  #pragma unroll
  for (int i_42 = 0; i_42 < 16; ++i_42) {
    acc_o[i_42] = (acc_o[i_42] * inv_sum[0]);
  }
  #pragma unroll
  for (int i_43 = 0; i_43 < 4; ++i_43) {
    uint2 __9;
    float4 v__8 = *(float4*)(acc_o + (i_43 * 4));
    ((half2*)(&__9))[0] = __float22half2_rn(((float2*)(&v__8))[0]);
    ((half2*)(&__9))[1] = __float22half2_rn(((float2*)(&v__8))[1]);
    *(uint2*)(Output_local_cast + 0) = __9;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_43 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

