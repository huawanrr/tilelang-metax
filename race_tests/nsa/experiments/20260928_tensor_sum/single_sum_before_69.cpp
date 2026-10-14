#include <tl_templates/maca/gemm.h>
#include <tl_templates/maca/copy.h>
#include <tl_templates/maca/reduce.h>
#include <tl_templates/maca/intrin.h>
#include <tl_templates/maca/atomic.h>
#include <tl_templates/maca/threadblock_swizzle.h>
#include <tl_templates/maca/debug.h>

extern "C" __global__ void kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V);
extern "C" __global__ void __launch_bounds__(64, 1) kernel_kernel(const int* __restrict__ BlockIndices, const half_t* __restrict__ K, half_t* __restrict__ Output, const half_t* __restrict__ Q, const half_t* __restrict__ V) {
  half_t Q_reg[32];
  float acc_o[32];
  float acc_den[4];
  half_t unit[4];
  half_t K_reg[64];
  half_t V_reg[64];
  extern __shared__ __align__(1024) half_t V_shared[];
  float acc_s[8];
  half_t acc_s_cast[8];
  half_t kb[16];
  half_t vb[32];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int i = 0; i < 4; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + (((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int i_s = (BlockIndices[((((int)blockIdx.z) * 1024) + ((int)blockIdx.x))] * 32);
  #pragma unroll
  for (int i_1 = 0; i_1 < 8; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  float broadcast_var_1 = 0x0p+0f/*0.000000e+00*/;
  *(float4*)(acc_den + 0) = make_float4(broadcast_var_1, broadcast_var_1, broadcast_var_1, broadcast_var_1);
  half_t broadcast_var_2 = half_t(0x1p+0f/*1.000000e+00*/);
  *(uint2*)(unit + 0) = make_uint2(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_2 = 0; i_2 < 8; ++i_2) {
      half_t broadcast_var_3 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_2) < 256)) {
        condval = *(uint4*)(K + ((((((int)blockIdx.z) * 131072) + (i_2 * 512)) + (i_s * 128)) + (((int)threadIdx.x) * 8)));
      } else {
        condval = make_uint4(__pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3), __pack_half2(broadcast_var_3, broadcast_var_3));
      }
      *(uint4*)(K_reg + (i_2 * 8)) = condval;
    }
    #pragma unroll
    for (int i_3 = 0; i_3 < 8; ++i_3) {
      half_t broadcast_var_4 = half_t(0x0p+0f/*0.000000e+00*/);
      uint4 condval_1;
      if ((((((((int)threadIdx.x) >> 4) + i_s) >> 2) + i_3) < 256)) {
        condval_1 = *(uint4*)(V + ((((((int)blockIdx.z) * 131072) + (i_3 * 512)) + (i_s * 128)) + (((int)threadIdx.x) * 8)));
      } else {
        condval_1 = make_uint4(__pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4), __pack_half2(broadcast_var_4, broadcast_var_4));
      }
      *(uint4*)(V_reg + (i_3 * 8)) = condval_1;
    }
    #pragma unroll
    for (int i_4 = 0; i_4 < 8; ++i_4) {
      *(uint4*)(V_shared + (((i_4 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_4 & 3) * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(K_reg + (i_4 * 8));
    }
    if (((int)blockIdx.x) < (i_s + 31)) {
      #pragma unroll
      for (int i_5 = 0; i_5 < 8; ++i_5) {
        float condval_2;
        if (((((((i_5 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + i_s) + (i_5 & 3)) <= ((int)blockIdx.x))) {
          condval_2 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_2 = -MACART_INF_F;
        }
        acc_s[i_5] = condval_2;
      }
    } else {
      #pragma unroll
      for (int i_6 = 0; i_6 < 2; ++i_6) {
        float broadcast_var_5 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + (i_6 * 4)) = make_float4(broadcast_var_5, broadcast_var_5, broadcast_var_5, broadcast_var_5);
      }
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    for (int ki = 0; ki < 4; ++ki) {
      for (int j = 0; j < 2; ++j) {
        *(uint4*)(kb + (j * 8)) = *(uint4*)(V_shared + (((j * 2048) + ((((int)threadIdx.x) & 15) * 128)) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 15)) * 8)));
      }
      for (int kp = 0; kp < 2; ++kp) {
        for (int j_1 = 0; j_1 < 2; ++j_1) {
          {
      *(((float32x4*)acc_s) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_1 * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + j_1));
    };
        }
      }
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    #pragma unroll
    for (int i_7 = 0; i_7 < 8; ++i_7) {
      *(uint4*)(V_shared + (((i_7 * 512) + ((((int)threadIdx.x) >> 4) * 128)) + (((((int)threadIdx.x) & 15) ^ (((i_7 & 3) * 4) + (((int)threadIdx.x) >> 4))) * 8))) = *(uint4*)(V_reg + (i_7 * 8));
    }
    #pragma unroll
    for (int i_8 = 0; i_8 < 8; ++i_8) {
      acc_s[i_8] = exp2f(min((acc_s[i_8] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
    }
    #pragma unroll
    for (int i_9 = 0; i_9 < 2; ++i_9) {
      uint2 __1;
      float4 v_ = *(float4*)(acc_s + (i_9 * 4));
      ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
      ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
      *(uint2*)(acc_s_cast + (i_9 * 4)) = __1;
    }
  }
  __syncthreads();
  if (((0 <= i_s) && (i_s < 1024)) && (i_s <= ((int)blockIdx.x))) {
    for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
      for (int j_2 = 0; j_2 < 8; ++j_2) {
        for (int local_id = 0; local_id < 4; ++local_id) {
          vb[((j_2 * 4) + local_id)] = V_shared[(((((ki_1 * 2048) + ((((int)threadIdx.x) >> 4) * 512)) + (local_id * 128)) + ((((j_2 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ (((((int)threadIdx.x) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7))];
        }
      }
      {
      *(((float32x4*)acc_den) + 0) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)unit) + 0),
                    *(((float16x4*)acc_s_cast) + ki_1),
                    *(((float32x4*)acc_den) + 0));
    };
      for (int j_3 = 0; j_3 < 8; ++j_3) {
        {
      *(((float32x4*)acc_o) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_3),
                    *(((float16x4*)acc_s_cast) + ki_1),
                    *(((float32x4*)acc_o) + j_3));
    };
      }
    }
    #pragma unroll
    for (int i_10 = 0; i_10 < 32; ++i_10) {
      float value = acc_den[0];
      float condval_3;
      if ((0x0p+0f/*0.000000e+00*/ < value)) {
        condval_3 = (0x1p+0f/*1.000000e+00*/ / value);
      } else {
        condval_3 = 0x0p+0f/*0.000000e+00*/;
      }
      acc_o[i_10] = (acc_o[i_10] * condval_3);
    }
  }
  #pragma unroll
  for (int i_11 = 0; i_11 < 8; ++i_11) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_11 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + (((((((int)blockIdx.z) * 2097152) + (((int)blockIdx.x) * 2048)) + ((((int)threadIdx.x) & 15) * 128)) + (i_11 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

