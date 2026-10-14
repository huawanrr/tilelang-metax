#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  half_t Q_reg[8];
  float acc_o[8];
  half_t K_reg[8];
  half_t V_reg[8];
  extern __shared__ __align__(1024) half_t V_shared[];
  float acc_s[4];
  float lane_sum[1];
  half_t acc_s_cast[4];
  half_t kb[8];
  half_t vb[8];
  half_t Output_local_cast[4];
  *(uint4*)(Q_reg + 0) = *(uint4*)(Q + (((((int)blockIdx.x) * 512) + ((((int)threadIdx.x) & 15) * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  int i_s = (BlockIndices[((int)blockIdx.x)] * 16);
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval;
    if ((((((int)threadIdx.x) >> 2) + i_s) < 1024)) {
      condval = *(uint4*)(K + ((i_s * 32) + (((int)threadIdx.x) * 8)));
    } else {
      condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
    *(uint4*)(K_reg + 0) = condval;
    half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_1;
    if ((((((int)threadIdx.x) >> 2) + i_s) < 1024)) {
      condval_1 = *(uint4*)(V + ((i_s * 32) + (((int)threadIdx.x) * 8)));
    } else {
      condval_1 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
    }
    *(uint4*)(V_reg + 0) = condval_1;
    *(uint4*)(V_shared + (((((int)threadIdx.x) >> 2) * 32) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(K_reg + 0);
    if (((int)blockIdx.x) < (i_s + 15)) {
      #pragma unroll
      for (int i_1 = 0; i_1 < 4; ++i_1) {
        float condval_2;
        if ((((((((int)threadIdx.x) >> 4) * 4) + i_s) + i_1) <= ((int)blockIdx.x))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = -MACART_INF_F;
        }
        acc_s[i_1] = condval_2;
      }
    } else {
      float broadcast_var_3 = 0x0p+0f/*0.000000e+00*/;
      *(float4*)(acc_s + 0) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    *(uint4*)(kb + 0) = *(uint4*)(V_shared + (((((int)threadIdx.x) & 15) * 32) + (((((int)threadIdx.x) >> 4) ^ ((((int)threadIdx.x) & 7) >> 1)) * 8)));
    for (int kp = 0; kp < 2; ++kp) {
      {
      *(((float32x4*)acc_s) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + kp),
                    *(((float16x4*)Q_reg) + kp),
                    *(((float32x4*)acc_s) + 0));
    };
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    *(uint4*)(V_shared + (((((int)threadIdx.x) >> 2) * 32) + (((((int)threadIdx.x) & 3) ^ ((((int)threadIdx.x) & 31) >> 3)) * 8))) = *(uint4*)(V_reg + 0);
    #pragma unroll
    for (int i_2 = 0; i_2 < 4; ++i_2) {
      acc_s[i_2] = exp2f(min((acc_s[i_2] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
    #pragma unroll
    for (int j = 0; j < 4; ++j) {
      lane_sum[0] = (lane_sum[0] + acc_s[j]);
    }
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 32, 64));
    lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 16, 64));
    float condval_3;
    if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
      condval_3 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
    } else {
      condval_3 = 0x0p+0f/*0.000000e+00*/;
    }
    lane_sum[0] = condval_3;
    #pragma unroll
    for (int i_3 = 0; i_3 < 4; ++i_3) {
      acc_s[i_3] = (acc_s[i_3] * lane_sum[0]);
    }
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + 0);
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + 0) = __1;
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    for (int j_1 = 0; j_1 < 2; ++j_1) {
      for (int local_id = 0; local_id < 4; ++local_id) {
        vb[((j_1 * 4) + local_id)] = V_shared[(((((((int)threadIdx.x) >> 4) * 128) + (local_id * 32)) + ((((j_1 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 2) + (local_id >> 1))) * 8)) + (((int)threadIdx.x) & 7))];
      }
    }
    for (int j_2 = 0; j_2 < 2; ++j_2) {
      {
      *(((float32x4*)acc_o) + j_2) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_2),
                    *(((float16x4*)acc_s_cast) + 0),
                    *(((float32x4*)acc_o) + j_2));
    };
    }
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 2; ++i_4) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_4 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 512) + ((((int)threadIdx.x) & 15) * 32)) + (i_4 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

