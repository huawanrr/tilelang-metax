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
  half_t Q_stage[16];
  int starts[2];
  float acc_o[16];
  half_t K_reg[32];
  half_t V_reg[32];
  half_t Q_reg[16];
  float acc_s[8];
  half_t kb[16];
  float lane_sum[1];
  half_t acc_s_cast[8];
  half_t vb[16];
  half_t O_reg[16];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_stage + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.z) * 131072) + (((int)blockIdx.x) * 1024)) + (i * 512)) + (((int)threadIdx.x) * 8)));
  }
  #pragma unroll
  for (int si = 0; si < 2; ++si) {
    starts[si] = (BlockIndices[(((((int)blockIdx.z) * 256) + (((int)blockIdx.x) * 2)) + si)] * 16);
  }
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  #pragma unroll
  for (int i_2 = 0; i_2 < 4; ++i_2) {
    int condval;
    if ((i_2 < 2)) {
      condval = (((i_2 * 8) + (((int)threadIdx.x) >> 3)) + starts[0]);
    } else {
      condval = ((((i_2 * 8) + (((int)threadIdx.x) >> 3)) + starts[1]) - 16);
    }
    int kpos = condval;
    half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_1;
    if (((0 <= kpos) && (kpos < 128))) {
      condval_1 = *(uint4*)(K + (((((int64_t)((int)blockIdx.z)) * (int64_t)8192) + (((int64_t)kpos) * (int64_t)64)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)7) * (int64_t)8)));
    } else {
      condval_1 = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
    *(uint4*)(K_reg + (i_2 * 8)) = condval_1;
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 4; ++i_3) {
    int condval_2;
    if ((i_3 < 2)) {
      condval_2 = (((i_3 * 8) + (((int)threadIdx.x) >> 3)) + starts[0]);
    } else {
      condval_2 = ((((i_3 * 8) + (((int)threadIdx.x) >> 3)) + starts[1]) - 16);
    }
    int vpos = condval_2;
    half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
    uint4 condval_3;
    if (((0 <= vpos) && (vpos < 128))) {
      condval_3 = *(uint4*)(V + (((((int64_t)((int)blockIdx.z)) * (int64_t)8192) + (((int64_t)vpos) * (int64_t)64)) + ((((int64_t)((int)threadIdx.x)) & (int64_t)7) * (int64_t)8)));
    } else {
      condval_3 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
    }
    *(uint4*)(V_reg + (i_3 * 8)) = condval_3;
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 2; ++i_4) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_4 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(Q_stage + (i_4 * 8));
  }
  __syncwarp();
  #pragma unroll
  for (int i_5 = 0; i_5 < 2; ++i_5) {
    *(uint4*)(Q_reg + (i_5 * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((((int)threadIdx.x) & 15) * 64) + ((((i_5 * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
  }
  __syncwarp();
  #pragma unroll
  for (int i_6 = 0; i_6 < 4; ++i_6) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_6 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(K_reg + (i_6 * 8));
  }
  #pragma unroll
  for (int i_7 = 0; i_7 < 8; ++i_7) {
    int condval_4;
    if ((i_7 < 4)) {
      condval_4 = ((((((int)threadIdx.x) >> 4) * 4) + starts[0]) + i_7);
    } else {
      condval_4 = ((((((i_7 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + starts[1]) + (i_7 & 3)) - 16);
    }
    int pos = condval_4;
    float condval_5;
    if ((((0 <= pos) && (pos < 128)) && (pos <= ((int)blockIdx.x)))) {
      condval_5 = 0x0p+0f/*0.000000e+00*/;
    } else {
      condval_5 = -MACART_INF_F;
    }
    acc_s[i_7] = condval_5;
  }
  __syncwarp();
  for (int ki = 0; ki < 2; ++ki) {
    for (int j = 0; j < 2; ++j) {
      *(uint4*)(kb + (j * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((j * 1024) + ((((int)threadIdx.x) & 15) * 64)) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
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
  __syncwarp();
  #pragma unroll
  for (int i_8 = 0; i_8 < 4; ++i_8) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + ((i_8 * 512) + (((int)threadIdx.x) * 8))) = *(uint4*)(V_reg + (i_8 * 8));
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 8; ++i_9) {
    acc_s[i_9] = exp2f(min((acc_s[i_9] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
  }
  lane_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int k = 0; k < 2; ++k) {
    #pragma unroll
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      lane_sum[0] = (lane_sum[0] + acc_s[((k * 4) + j_2)]);
    }
  }
  lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 32, 64));
  lane_sum[0] = (lane_sum[0] + __shfl_xor_sync((uint64_t)18446744073709551615, lane_sum[0], 16, 64));
  float condval_6;
  if ((0x0p+0f/*0.000000e+00*/ < lane_sum[0])) {
    condval_6 = (0x1p+0f/*1.000000e+00*/ / lane_sum[0]);
  } else {
    condval_6 = 0x0p+0f/*0.000000e+00*/;
  }
  lane_sum[0] = condval_6;
  #pragma unroll
  for (int i_10 = 0; i_10 < 8; ++i_10) {
    acc_s[i_10] = (acc_s[i_10] * lane_sum[0]);
  }
  #pragma unroll
  for (int i_11 = 0; i_11 < 2; ++i_11) {
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + (i_11 * 4));
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + (i_11 * 4)) = __1;
  }
  __syncwarp();
  for (int ki_1 = 0; ki_1 < 2; ++ki_1) {
    for (int j_3 = 0; j_3 < 4; ++j_3) {
      for (int e = 0; e < 4; ++e) {
        vb[((j_3 * 4) + e)] = ((half_t*)buf_dyn_shmem)[(((((ki_1 * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + (e * 64)) + (j_3 * 16)) + (((int)threadIdx.x) & 15))];
      }
    }
    for (int j_4 = 0; j_4 < 4; ++j_4) {
      {
      *(((float32x4*)acc_o) + j_4) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_4),
                    *(((float16x4*)acc_s_cast) + ki_1),
                    *(((float32x4*)acc_o) + j_4));
    };
    }
  }
  #pragma unroll
  for (int i_12 = 0; i_12 < 4; ++i_12) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_12 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(O_reg + (i_12 * 4)) = __2;
  }
  __syncwarp();
  #pragma unroll
  for (int i_13 = 0; i_13 < 4; ++i_13) {
    *(uint2*)(((half_t*)buf_dyn_shmem) + ((((((int)threadIdx.x) & 15) * 64) + ((((i_13 * 2) + (((int)threadIdx.x) >> 5)) ^ (((int)threadIdx.x) & 7)) * 8)) + (((((int)threadIdx.x) & 31) >> 4) * 4))) = *(uint2*)(O_reg + (i_13 * 4));
  }
  __syncwarp();
  #pragma unroll
  for (int i_14 = 0; i_14 < 2; ++i_14) {
    *(uint4*)(Output + ((((((int)blockIdx.z) * 131072) + (((int)blockIdx.x) * 1024)) + (i_14 * 512)) + (((int)threadIdx.x) * 8))) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_14 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8)));
  }
}

