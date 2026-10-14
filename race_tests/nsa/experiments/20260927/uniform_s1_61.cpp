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
  half_t Q_reg[16];
  float acc_o[16];
  float scores_sum[1];
  half_t K_reg[64];
  half_t V_reg[64];
  float acc_s[16];
  float scores_inv_sum[1];
  half_t acc_s_cast[16];
  half_t kb[32];
  half_t vb[16];
  half_t Output_local_cast[4];
  #pragma unroll
  for (int i = 0; i < 2; ++i) {
    *(uint4*)(Q_reg + (i * 8)) = *(uint4*)(Q + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i * 32)) + ((((int)threadIdx.x) >> 4) * 8)));
  }
  int raw_start = (BlockIndices[((int)blockIdx.x)] * 64);
  bool row_valid = (((0 <= raw_start) && (raw_start < 256)) && (raw_start <= ((int)blockIdx.x)));
  #pragma unroll
  for (int i_1 = 0; i_1 < 4; ++i_1) {
    float broadcast_var = 0x0p+0f/*0.000000e+00*/;
    *(float4*)(acc_o + (i_1 * 4)) = make_float4(broadcast_var, broadcast_var, broadcast_var, broadcast_var);
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int i_2 = 0; i_2 < 8; ++i_2) {
    half_t broadcast_var_1 = half_t(0x0p+0f/*0.000000e+00*/);
    int condval_1;
    if (row_valid) {
      condval_1 = raw_start;
    } else {
      condval_1 = 0;
    }
    int condval_2;
    if (row_valid) {
      condval_2 = raw_start;
    } else {
      condval_2 = 0;
    }
    int condval_3;
    if ((((0 <= raw_start) && (raw_start < 256)) && (raw_start <= ((int)blockIdx.x)))) {
      condval_3 = raw_start;
    } else {
      condval_3 = 0;
    }
    int condval_4;
    if ((((0 <= raw_start) && (raw_start < 256)) && (raw_start <= ((int)blockIdx.x)))) {
      condval_4 = raw_start;
    } else {
      condval_4 = 0;
    }
    uint4 condval;
    if (((((((((((int)threadIdx.x) >> 3) + condval_1) >> 3) + i_2) < 32) && (0 <= (((i_2 * 8) + (((int)threadIdx.x) >> 3)) + condval_2))) && (0 <= (((i_2 * 8) + (((int)threadIdx.x) >> 3)) + condval_3))) && (((((((int)threadIdx.x) >> 3) + condval_4) >> 3) + i_2) < 32))) {
      int64_t condval_5;
      if (((((int64_t)0 <= ((int64_t)raw_start)) && (((int64_t)raw_start) < (int64_t)256)) && (((int64_t)raw_start) <= ((int64_t)((int)blockIdx.x))))) {
        condval_5 = ((int64_t)raw_start);
      } else {
        condval_5 = (int64_t)0;
      }
      int64_t condval_6;
      if (((((int64_t)0 <= ((int64_t)raw_start)) && (((int64_t)raw_start) < (int64_t)256)) && (((int64_t)raw_start) <= ((int64_t)((int)blockIdx.x))))) {
        condval_6 = ((int64_t)raw_start);
      } else {
        condval_6 = (int64_t)0;
      }
      condval = *(uint4*)(K + (((((int64_t)i_2) * (int64_t)512) + (condval_6 * (int64_t)64)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval = make_uint4(__pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1), __pack_half2(broadcast_var_1, broadcast_var_1));
    }
    *(uint4*)(K_reg + (i_2 * 8)) = condval;
  }
  #pragma unroll
  for (int i_3 = 0; i_3 < 8; ++i_3) {
    half_t broadcast_var_2 = half_t(0x0p+0f/*0.000000e+00*/);
    int condval_8;
    if (row_valid) {
      condval_8 = raw_start;
    } else {
      condval_8 = 0;
    }
    int condval_9;
    if (row_valid) {
      condval_9 = raw_start;
    } else {
      condval_9 = 0;
    }
    int condval_10;
    if ((((0 <= raw_start) && (raw_start < 256)) && (raw_start <= ((int)blockIdx.x)))) {
      condval_10 = raw_start;
    } else {
      condval_10 = 0;
    }
    int condval_11;
    if ((((0 <= raw_start) && (raw_start < 256)) && (raw_start <= ((int)blockIdx.x)))) {
      condval_11 = raw_start;
    } else {
      condval_11 = 0;
    }
    uint4 condval_7;
    if (((((((((((int)threadIdx.x) >> 3) + condval_8) >> 3) + i_3) < 32) && (0 <= (((i_3 * 8) + (((int)threadIdx.x) >> 3)) + condval_9))) && (0 <= (((i_3 * 8) + (((int)threadIdx.x) >> 3)) + condval_10))) && (((((((int)threadIdx.x) >> 3) + condval_11) >> 3) + i_3) < 32))) {
      int64_t condval_12;
      if (((((int64_t)0 <= ((int64_t)raw_start)) && (((int64_t)raw_start) < (int64_t)256)) && (((int64_t)raw_start) <= ((int64_t)((int)blockIdx.x))))) {
        condval_12 = ((int64_t)raw_start);
      } else {
        condval_12 = (int64_t)0;
      }
      int64_t condval_13;
      if (((((int64_t)0 <= ((int64_t)raw_start)) && (((int64_t)raw_start) < (int64_t)256)) && (((int64_t)raw_start) <= ((int64_t)((int)blockIdx.x))))) {
        condval_13 = ((int64_t)raw_start);
      } else {
        condval_13 = (int64_t)0;
      }
      condval_7 = *(uint4*)(V + (((((int64_t)i_3) * (int64_t)512) + (condval_13 * (int64_t)64)) + (((int64_t)((int)threadIdx.x)) * (int64_t)8)));
    } else {
      condval_7 = make_uint4(__pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2), __pack_half2(broadcast_var_2, broadcast_var_2));
    }
    *(uint4*)(V_reg + (i_3 * 8)) = condval_7;
  }
  #pragma unroll
  for (int i_4 = 0; i_4 < 8; ++i_4) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_4 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(K_reg + (i_4 * 8));
  }
  if (!row_valid) {
    #pragma unroll
    for (int i_5 = 0; i_5 < 4; ++i_5) {
      float broadcast_var_3 = -MACART_INF_F;
      *(float4*)(acc_s + (i_5 * 4)) = make_float4(broadcast_var_3, broadcast_var_3, broadcast_var_3, broadcast_var_3);
    }
  } else {
    if (((int)blockIdx.x) < (raw_start + 63)) {
      #pragma unroll
      for (int i_6 = 0; i_6 < 16; ++i_6) {
        float condval_14;
        if (((((((i_6 >> 2) * 16) + ((((int)threadIdx.x) >> 4) * 4)) + raw_start) + (i_6 & 3)) <= ((int)blockIdx.x))) {
          condval_14 = 0x0p+0f/*0.000000e+00*/;
        } else {
          condval_14 = -MACART_INF_F;
        }
        acc_s[i_6] = condval_14;
      }
    } else {
      #pragma unroll
      for (int i_7 = 0; i_7 < 4; ++i_7) {
        float broadcast_var_4 = 0x0p+0f/*0.000000e+00*/;
        *(float4*)(acc_s + (i_7 * 4)) = make_float4(broadcast_var_4, broadcast_var_4, broadcast_var_4, broadcast_var_4);
      }
    }
  }
  __syncthreads();
  for (int ki = 0; ki < 2; ++ki) {
    for (int j = 0; j < 4; ++j) {
      *(uint4*)(kb + (j * 8)) = *(uint4*)(((half_t*)buf_dyn_shmem) + (((j * 1024) + ((((int)threadIdx.x) & 15) * 64)) + ((((ki * 4) + (((int)threadIdx.x) >> 4)) ^ (((int)threadIdx.x) & 7)) * 8)));
    }
    for (int kp = 0; kp < 2; ++kp) {
      for (int j_1 = 0; j_1 < 4; ++j_1) {
        {
      *(((float32x4*)acc_s) + j_1) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)kb) + ((j_1 * 2) + kp)),
                    *(((float16x4*)Q_reg) + ((ki * 2) + kp)),
                    *(((float32x4*)acc_s) + j_1));
    };
      }
    }
  }
  __syncthreads();
  #pragma unroll
  for (int i_8 = 0; i_8 < 8; ++i_8) {
    *(uint4*)(((half_t*)buf_dyn_shmem) + (((i_8 * 512) + ((((int)threadIdx.x) >> 3) * 64)) + (((((int)threadIdx.x) & 7) ^ (((int)threadIdx.x) >> 3)) * 8))) = *(uint4*)(V_reg + (i_8 * 8));
  }
  #pragma unroll
  for (int i_9 = 0; i_9 < 16; ++i_9) {
    acc_s[i_9] = exp2f(min((acc_s[i_9] * 0x1.2776c50bebcf3p-3f/*1.442695e-01*/), 0x1.ep+3f/*1.500000e+01*/));
  }
  scores_sum[0] = 0x0p+0f/*0.000000e+00*/;
  #pragma unroll
  for (int rv = 0; rv < 16; ++rv) {
    scores_sum[0] = (scores_sum[0] + acc_s[(((rv & 3) * 4) + (rv >> 2))]);
  }
  __syncthreads();
  scores_sum[0] = tl::AllReduce<tl::SumOp, 64, 16, 0>::run(scores_sum[0], (&(((float*)buf_dyn_shmem)[2048])));
  float condval_15;
  if ((0x0p+0f/*0.000000e+00*/ < scores_sum[0])) {
    condval_15 = (0x1p+0f/*1.000000e+00*/ / scores_sum[0]);
  } else {
    condval_15 = 0x0p+0f/*0.000000e+00*/;
  }
  scores_inv_sum[0] = condval_15;
  #pragma unroll
  for (int i_10 = 0; i_10 < 16; ++i_10) {
    acc_s[i_10] = (acc_s[i_10] * scores_inv_sum[0]);
  }
  #pragma unroll
  for (int i_11 = 0; i_11 < 4; ++i_11) {
    uint2 __1;
    float4 v_ = *(float4*)(acc_s + (i_11 * 4));
    ((half2*)(&__1))[0] = __float22half2_rn(((float2*)(&v_))[0]);
    ((half2*)(&__1))[1] = __float22half2_rn(((float2*)(&v_))[1]);
    *(uint2*)(acc_s_cast + (i_11 * 4)) = __1;
  }
  __syncthreads();
  for (int ki_1 = 0; ki_1 < 4; ++ki_1) {
    for (int j_2 = 0; j_2 < 4; ++j_2) {
      for (int local_id = 0; local_id < 4; ++local_id) {
        vb[((j_2 * 4) + local_id)] = ((half_t*)buf_dyn_shmem)[(((((ki_1 * 1024) + ((((int)threadIdx.x) >> 4) * 256)) + (local_id * 64)) + ((((j_2 * 2) + ((((int)threadIdx.x) & 15) >> 3)) ^ ((((((int)threadIdx.x) & 31) >> 4) * 4) + local_id)) * 8)) + (((int)threadIdx.x) & 7))];
      }
    }
    for (int j_3 = 0; j_3 < 4; ++j_3) {
      {
      *(((float32x4*)acc_o) + j_3) = __builtin_mxc_mma_16x16x16f16(*(((float16x4*)vb) + j_3),
                    *(((float16x4*)acc_s_cast) + ki_1),
                    *(((float32x4*)acc_o) + j_3));
    };
    }
  }
  #pragma unroll
  for (int i_12 = 0; i_12 < 4; ++i_12) {
    uint2 __2;
    float4 v__1 = *(float4*)(acc_o + (i_12 * 4));
    ((half2*)(&__2))[0] = __float22half2_rn(((float2*)(&v__1))[0]);
    ((half2*)(&__2))[1] = __float22half2_rn(((float2*)(&v__1))[1]);
    *(uint2*)(Output_local_cast + 0) = __2;
    *(uint2*)(Output + ((((((int)blockIdx.x) * 1024) + ((((int)threadIdx.x) & 15) * 64)) + (i_12 * 16)) + ((((int)threadIdx.x) >> 4) * 4))) = *(uint2*)(Output_local_cast + 0);
  }
}

