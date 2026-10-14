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
  *(uint4*)(ktile + 0) = *(uint4*)(K + (((((int)blockIdx.z) * 32768) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  *(uint4*)(PackedK + ((((((int)blockIdx.z) * 32768) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 7) * 128)) + ((((int)threadIdx.x) >> 3) * 8))) = *(uint4*)(ktile + 0);
  *(uint4*)(tile + 0) = *(uint4*)(V + (((((int)blockIdx.z) * 32768) + (((int)blockIdx.x) * 1024)) + (((int)threadIdx.x) * 8)));
  #pragma unroll
  for (int i = 0; i < 8; ++i) {
    Packed[((((((((((int)blockIdx.z) * 32768) + (((int)blockIdx.x) * 1024)) + (((((int)threadIdx.x) & 7) >> 2) * 512)) + ((((int)threadIdx.x) >> 5) * 128)) + ((((int)threadIdx.x) & 1) * 64)) + (i * 8)) + (((((int)threadIdx.x) & 3) >> 1) * 4)) + ((((int)threadIdx.x) & 31) >> 3))] = tile[i];
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
  half_t V_reg[16];
  float acc_s[4];
  half_t acc_s_cast[4];
  extern __shared__ __align__(1024) float workspace[];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int si = 0; si < 8; ++si) {
    indices[si] = (BlockIndices[(((((int)blockIdx.z) * 4096) + (((int)blockIdx.x) * 8)) + si)] * 16);
  }
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.z) * 524288) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(sum_acc + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  float neg_inf = -MACART_INF_F;
  #pragma unroll 2
  for (int s = 0; s < 8; ++s) {
    int i_s = indices[s];
    if (((0 <= i_s) && (i_s < 512)) && (i_s <= ((int)blockIdx.x))) {
      #pragma unroll
      for (int i_2 = 0; i_2 < 2; ++i_2) {
        *(uint4*)(K_reg + (i_2 * 8)) = *(uint4*)(K + ((((((int)blockIdx.z) * 32768) + ((i_s >> 4) * 1024)) + (i_2 * 512)) + (((int)threadIdx.x) * 8)));
      }
      #pragma unroll
      for (int i_3 = 0; i_3 < 2; ++i_3) {
        *(uint4*)(V_reg + (i_3 * 8)) = *(uint4*)(V + ((((((int)blockIdx.z) * 32768) + ((i_s >> 4) * 1024)) + (i_3 * 512)) + (((int)threadIdx.x) * 8)));
      }
      if (((int)blockIdx.x) < (i_s + 15)) {
        #pragma unroll
        for (int i_4 = 0; i_4 < 4; ++i_4) {
          float condval;
          if ((((((((int)threadIdx.x) >> 4) * 4) + i_s) + i_4) <= ((int)blockIdx.x))) {
            condval = 0x0p+0f/*0.000000e+00*/;
          } else {
            condval = neg_inf;
          }
          acc_s[i_4] = condval;
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
      for (int i_5 = 0; i_5 < 4; ++i_5) {
        acc_s[i_5] = exp2f(min((acc_s[i_5] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
      }
      #pragma unroll
      for (int i_6 = 0; i_6 < 4; ++i_6) {
        sum_acc[i_6] = (sum_acc[i_6] + acc_s[i_6]);
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
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 4; ++rv) {
    scores_sum[0] = (scores_sum[0] + sum_acc[rv]);
  }
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(workspace[0])));
  float condval_1;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_1 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_1 = 0x0p+0f/*0.000000e+00*/;
  }
  inv_sum[0] = condval_1;
  #pragma unroll
  for (int i_7 = 0; i_7 < 16; ++i_7) {
    acc_o[i_7] = (acc_o[i_7] * inv_sum[0]);
  }
  #pragma unroll
  for (int i_8 = 0; i_8 < 4; ++i_8) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_8 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.z) * 524288) + (((int)blockIdx.x) * 1024)) + ((((int)threadIdx.x) & 15) * 64)) + (i_8 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

