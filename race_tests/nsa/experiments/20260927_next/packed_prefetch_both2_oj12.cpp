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
  *(uint4*)(ktile + 0) = *(uint4*)(K + (((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  *(uint4*)(PackedK + ((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + (((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[((((((((((int)blockIdx.z) * 65536) + (((int)blockIdx.x) * 1024)) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
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
  float acc_o_alt[16];
  float sum_acc[4];
  float scores_sum[1];
  float inv_sum[1];
  half_t K_reg[16];
  half_t V_reg[16];
  half_t K_reg1[16];
  half_t V_reg1[16];
  float acc_s[4];
  half_t acc_s_cast[4];
  extern __shared__ __align__(1024) float workspace[];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    indices[si] = (BlockIndices[(((((int)blockIdx.z) * 8192) + (((int)blockIdx.x) * 8)) + si)] * 16);
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.z) * 1048576) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
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
  for (int group = 0; group < 4; ++group) {
    int i_s0 = indices[(group * 2)];
    int i_s1 = indices[((group * 2) + 1)];
    if (((0 <= i_s0) && (i_s0 < 1024)) && (i_s0 <= ((int)blockIdx.x))) {
      #pragma unroll
      for (int i_3 = 0; i_3 < 2; ++i_3) {
        *(uint4*)(K_reg + (i_3 * 8)) = *(uint4*)(K + ((((((int)blockIdx.z) * 65536) + ((i_s0 >> 4) * 1024)) + (i_3 * 512)) + (((int)threadIdx.x) * 8)));
      }
      #pragma unroll
      for (int i_4 = 0; i_4 < 2; ++i_4) {
        *(uint4*)(V_reg + (i_4 * 8)) = *(uint4*)(V + ((((((int)blockIdx.z) * 65536) + ((i_s0 >> 4) * 1024)) + (i_4 * 512)) + (((int)threadIdx.x) * 8)));
      }
    }
    if (((0 <= i_s1) && (i_s1 < 1024)) && (i_s1 <= ((int)blockIdx.x))) {
      #pragma unroll
      for (int i_5 = 0; i_5 < 2; ++i_5) {
        *(uint4*)(K_reg1 + (i_5 * 8)) = *(uint4*)(K + ((((((int)blockIdx.z) * 65536) + ((i_s1 >> 4) * 1024)) + (i_5 * 512)) + (((int)threadIdx.x) * 8)));
      }
      #pragma unroll
      for (int i_6 = 0; i_6 < 2; ++i_6) {
        *(uint4*)(V_reg1 + (i_6 * 8)) = *(uint4*)(V + ((((((int)blockIdx.z) * 65536) + ((i_s1 >> 4) * 1024)) + (i_6 * 512)) + (((int)threadIdx.x) * 8)));
      }
    }
    if (((0 <= i_s0) && (i_s0 < 1024)) && (i_s0 <= ((int)blockIdx.x))) {
      if (((int)blockIdx.x) < (i_s0 + 15)) {
        #pragma unroll
        for (int i_7 = 0; i_7 < 4; ++i_7) {
          float condval;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s0) + i_7) <= ((int)blockIdx.x))) {
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
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg) + ((ki * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + 0));
    };
        }
      }
      #pragma unroll
      for (int i_8 = 0; i_8 < 4; ++i_8) {
        acc_s[i_8] = exp2f(min((acc_s[i_8] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_9 = 0; i_9 < 4; ++i_9) {
        sum_acc[i_9] = (sum_acc[i_9] + acc_s[i_9]);
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
    if (((0 <= i_s1) && (i_s1 < 1024)) && (i_s1 <= ((int)blockIdx.x))) {
      if (((int)blockIdx.x) < (i_s1 + 15)) {
        #pragma unroll
        for (int i_10 = 0; i_10 < 4; ++i_10) {
          float condval_1;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s1) + i_10) <= ((int)blockIdx.x))) {
            condval_1 = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval_1 = neg_inf;
          }
          acc_s[i_10] = condval_1;
        }
      } else {
        float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + 0) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
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
      for (int i_11 = 0; i_11 < 4; ++i_11) {
        acc_s[i_11] = exp2f(min((acc_s[i_11] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_12 = 0; i_12 < 4; ++i_12) {
        sum_acc[i_12] = (sum_acc[i_12] + acc_s[i_12]);
      }
      uint2 __2;
      float4 v__1 = *(float4*)(acc_s + 0);
      ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
      ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
      *(uint2*)(acc_s_cast + 0) = __2;
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        {
      *(((float32x4*)acc_o_alt) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg1) + j_1),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o_alt) + j_1));
    };
      }
    }
  }
  #pragma unroll
  for (int i_13 = 0; i_13 < 16; ++i_13) {
    acc_o[i_13] = (acc_o[i_13] + acc_o_alt[i_13]);
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + sum_acc[rv]);
  }
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(workspace[0])));
  float condval_2;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_2 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_2 = 0x0p+0f/*0.000000e+00*/;
  }
  inv_sum[0] = condval_2;
  #pragma unroll
  for (int i_14 = 0; i_14 < 16; ++i_14) {
    acc_o[i_14] = (acc_o[i_14] * inv_sum[0]);
  }
  #pragma unroll
  for (int i_15 = 0; i_15 < 4; ++i_15) {
    uint2 __3;
    float4 v__2 = *(float4*)(acc_o + (i_15 * 4));
    ((half2*)(&__3))[0] = __float22half2_rn(((float2*)(&v__2))[0]);
    ((half2*)(&__3))[1] = __float22half2_rn(((float2*)(&v__2))[1]);
    *(uint2*)(Output_local_cast + 0) = __3;
    *(uint2*)(Output + (((((((int)blockIdx.z) * 1048576) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i_15 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

