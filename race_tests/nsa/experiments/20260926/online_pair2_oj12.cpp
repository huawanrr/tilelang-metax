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
  float sum_acc[8];
  float scores_sum[1];
  float inv_sum[1];
  half_t K_reg[32];
  half_t V_reg[32];
  float acc_s[8];
  half_t acc_s_cast[8];
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
  for (int i_2 = 0; i_2 < 2; ++i_2) {
    float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(sum_acc + (i_2 * 4)) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  }
  float neg_inf = -MACART_INF_F;
  #pragma unroll 2
  for (int s = 0; s < 4; ++s) {
    int first = indices[(s * 2)];
    int second = indices[((s * 2) + 1)];
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      int condval;
      if (((i_3 & 1) < 1)) {
        condval = first;
      } else {
        condval = second;
      }
      int condval_1;
      if (((i_3 & 1) < 1)) {
        condval_1 = first;
      } else {
        condval_1 = second;
      }
      int condval_2;
      if (((i_3 & 1) < 1)) {
        condval_2 = first;
      } else {
        condval_2 = second;
      }
      bool ok = (((0 <= condval) && (condval_1 < 1024)) && (condval_2 <= ((int)blockIdx.x)));
      half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_3;
      if (ok) {
        int condval_4;
        if (((i_3 & 1) < 1)) {
          condval_4 = first;
        } else {
          condval_4 = second;
        }
        int condval_5;
        if (((i_3 & 1) < 1)) {
          condval_5 = first;
        } else {
          condval_5 = second;
        }
        condval_3 = *(uint4*)(K + ((((((int)blockIdx.z) * 65536) + (max(0, min((condval_5 >> 4), 63)) * 1024)) + ((i_3 >> 1) * 512)) + (((int)threadIdx.x) * 8)));
      } else {
        condval_3 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
      }
      *(uint4*)(K_reg + (i_3 * 8)) = condval_3;
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 4; ++i_4) {
      int condval_6;
      if ((i_4 < 2)) {
        condval_6 = first;
      } else {
        condval_6 = second;
      }
      int condval_7;
      if ((i_4 < 2)) {
        condval_7 = first;
      } else {
        condval_7 = second;
      }
      int condval_8;
      if ((i_4 < 2)) {
        condval_8 = first;
      } else {
        condval_8 = second;
      }
      bool ok_1 = (((0 <= condval_6) && (condval_7 < 1024)) && (condval_8 <= ((int)blockIdx.x)));
      half_t broadcast_var_3 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_9;
      if (ok_1) {
        int condval_10;
        if ((i_4 < 2)) {
          condval_10 = first;
        } else {
          condval_10 = second;
        }
        int condval_11;
        if ((i_4 < 2)) {
          condval_11 = first;
        } else {
          condval_11 = second;
        }
        condval_9 = *(uint4*)(V + ((((((int)blockIdx.z) * 65536) + (max(0, min((condval_11 >> 4), 63)) * 1024)) + ((i_4 & 1) * 512)) + (((int)threadIdx.x) * 8)));
      } else {
        condval_9 = make_uint4(__pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3));
      }
      *(uint4*)(V_reg + (i_4 * 8)) = condval_9;
    }
    #pragma unroll
    for (int i_5 = 0; i_5 < 8; ++i_5) {
      int condval_13;
      if ((i_5 < 4)) {
        condval_13 = first;
      } else {
        condval_13 = second;
      }
      int condval_14;
      if ((i_5 < 4)) {
        condval_14 = first;
      } else {
        condval_14 = second;
      }
      int condval_15;
      if ((i_5 < 4)) {
        condval_15 = first;
      } else {
        condval_15 = second;
      }
      float condval_12;
      if ((((0 <= ((((((int)threadIdx.x) >> 4) * 4) + condval_13) + (i_5 & 3))) && (((((int)threadIdx.x) >> 4) + ((condval_14 + (i_5 & 3)) >> 2)) < 256)) && (((((((int)threadIdx.x) >> 4) * 4) + condval_15) + (i_5 & 3)) <= ((int)blockIdx.x)))) {
        condval_12 = 0x0p+0f/*0.000000e+00*/;
      } else {
        condval_12 = neg_inf;
      }
      acc_s[i_5] = condval_12;
    }
    for (int ki = 0; ki < 2; ++ki) {
      for (int kp = 0; kp < 2; ++kp) {
        for (int j = 0; j < 2; ++j) {
          {
      *(((float32x4*)acc_s) + j) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)K_reg) + (((ki * 4) + (j * 2)) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + j));
    };
        }
      }
    }
    #pragma unroll
    for (int i_6 = 0; i_6 < 8; ++i_6) {
      acc_s[i_6] = exp2f(min((acc_s[i_6] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      sum_acc[i_6] = (sum_acc[i_6] + acc_s[i_6]);
    }
    #pragma unroll
    for (int i_7 = 0; i_7 < 2; ++i_7) {
      uint2 __1;
      float4 v_ = *(float4*)(acc_s + (i_7 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(acc_s_cast + (i_7 * 4)) = __1;
    }
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        {
      *(((float32x4*)acc_o) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)V_reg) + ((ki_1 * 4) + j_1)),
                    *(((float16x4*)acc_s_cast) + ki_1),
                    *(((float32x4*)acc_o) + j_1));
    };
      }
    }
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 8; ++rv) {
    scores_sum[0] = (scores_sum[0] + sum_acc[(((rv & 1) * 4) + (rv >> 1))]);
  }
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(workspace[0])));
  float condval_16;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_16 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_16 = 0x0p+0f/*0.000000e+00*/;
  }
  inv_sum[0] = condval_16;
  #pragma unroll
  for (int i_8 = 0; i_8 < 16; ++i_8) {
    acc_o[i_8] = (acc_o[i_8] * inv_sum[0]);
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 4; ++i_9) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_9 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.z) * 1048576) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i_9 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

